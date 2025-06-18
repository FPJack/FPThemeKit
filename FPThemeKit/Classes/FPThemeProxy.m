//
//  FPThemeProxy.m
//  FPThemeKit
//
//  Created by admin on 2025/5/6.
//

#import "FPThemeProxy.h"
#import <objc/message.h>
#import "FPThemeManager.h"
static NSHashTable *cache;
#define kCGColorTag 1
#define kAlphaTag 2
#define kImageTag 3
#define kColorTag 4
#define kAppearanceTag 5
#define kBlockPicker 6


@interface GMPickerObj : NSObject
@property (nonatomic,copy)GMBlockPicker blockPicker;
@property (nonatomic,strong)NSInvocation *invocation;
@property (nonatomic,assign)int tag;
@property (nonatomic,copy)NSString *themeId;
@property (nonatomic,strong)id argument;
@end
@implementation GMPickerObj
- (void)dealloc
{
    self.invocation = nil;
    self.argument = nil;
    self.themeId = nil;
}
@end

@interface FPThemeProxy()
+ (instancetype)wrapView:(NSObject *)obj;
@end

@implementation NSObject (GMTheme)
- (id<IGMThemeView>)themeKit {
    return (id<IGMThemeView>)[FPThemeProxy wrapView:self];
}
static const void *MyDictionaryKey = &MyDictionaryKey;
- (void)_setThemeMap:(NSMutableDictionary *)dic {
    objc_setAssociatedObject(self, MyDictionaryKey, dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSMutableDictionary *)_themeDic {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, MyDictionaryKey);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        [self _setThemeMap:dict];
    }
    return dict;
}

static const void *MyThemeKitId = &MyThemeKitId;
- (void)_setThemeKitId:(NSString *)themeKitId {
    if ([[self _themeKitId] isEqualToString:themeKitId]) return;
    objc_setAssociatedObject(self, MyThemeKitId, themeKitId, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSString *)_themeKitId {
    return objc_getAssociatedObject(self, MyThemeKitId);
}
@end

@interface FPThemeProxy()
@property (nonatomic,weak)NSObject* object;
@property (nonatomic,copy)NSString *theme;
@end
@implementation FPThemeProxy
+ (UIColor *)colorWithKey:(NSString *)key {
    UIColor *color = [FPThemeManager colorWithKey:key];
    if (color) [color _setThemeKitId:key];
    return color ? color : FPThemeManager.share.defaultColor;
}
+ (UIImage *)imageWithKey:(NSString *)key {
    UIImage *image = [FPThemeManager imageWithKey:key];
    if (image) [image _setThemeKitId:key];
    return image ? image : FPThemeManager.share.defaultImage;
}
+ (NSNumber *)alphaWithKey:(NSString *)key {
    NSNumber *alpha = [FPThemeManager alphaWithKey:key];
    if (alpha) [alpha _setThemeKitId:key];
    return alpha ? alpha : FPThemeManager.share.defaultAlpha;
}
+ (void)initialize
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cache = [NSHashTable weakObjectsHashTable];
    });
}
+ (instancetype)wrapView:(NSObject *)view {
    FPThemeProxy *proxy = FPThemeProxy.alloc;
    proxy.object = view;
    return proxy;
}
- (NSString *)theme {
    return FPThemeManager.share.currentTheme;
}
+ (void)changeTheme:(NSString *)theme {
    if (FPThemeManager.share.supportsStatusBar) {
        if ([theme isEqualToString:kThemeKitNight]) {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }else {
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
        }
    }
    CFTimeInterval start = CACurrentMediaTime();
    NSInteger idx = 0;
    for (NSObject *view in cache) {
        if ([view isKindOfClass:UINavigationBar.class]) continue;
        idx += 1;
        [self changeThemeWithObj:view];
    }
    for (NSObject *view in cache) {
        //设置导航栏颜色色的时候有先后顺序
        if (![view isKindOfClass:UINavigationBar.class]) continue;
        idx += 1;
        [self changeThemeWithObj:view];
    }
    [NSNotificationCenter.defaultCenter postNotificationName:kThemeKitDidChangedNotification object:theme];
    CFTimeInterval end = CACurrentMediaTime();
#if DEBUG
    NSLog(@"主题切换view的个数:%ld---用时:%f秒",idx,end-start);
#endif
}

+ (void)changeThemeWithObj:(NSObject*)view {
    [self changeKeyboardAppearce:view];
    NSDictionary *dic =  [view _themeDic];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString*  _Nonnull key, GMPickerObj*  _Nonnull pickerObj, BOOL * _Nonnull stop) {
        NSInvocation *invocation = pickerObj.invocation;
        int tag = pickerObj.tag;
        if (tag == kAlphaTag) {
             NSNumber *alpha = [FPThemeProxy alphaWithKey:pickerObj.themeId];
            CGFloat alphaValue = alpha.floatValue;
            [invocation setArgument:&alphaValue atIndex:2];
            [invocation invoke];
        }else if (tag == kCGColorTag){
            UIColor *color = [FPThemeProxy colorWithKey:pickerObj.themeId];
            CGColorRef cgColor = color.CGColor;
            [invocation setArgument:&cgColor atIndex:2];
            [invocation invoke];
        }else if (tag == kBlockPicker) {
            GMBlockPicker block = pickerObj.blockPicker;
            if (block) {
                id blockReturnValue = block(FPThemeManager.share.currentTheme);
                [invocation setArgument:&blockReturnValue atIndex:2];
                [invocation invoke];
            }else {
                id blockReturnValue;
                [invocation setArgument:&blockReturnValue atIndex:2];
                [invocation invoke];
            }
        }else if (tag == kAppearanceTag) {
            if (@available(iOS 13.0, *)) {
                GMBlockPicker block = pickerObj.blockPicker;
                if (block) {
                    UINavigationBarAppearance *appearance = block(FPThemeManager.share.currentTheme);
                    [invocation setArgument:&appearance atIndex:2];
                    [invocation invoke];
                }else {
                    UINavigationBarAppearance *appearance;
                    [invocation setArgument:&appearance atIndex:2];
                    [invocation invoke];
                }
            } else {
                // Fallback on earlier versions
            }
        } else {
            NSString *themeKitId = pickerObj.themeId;
            if (tag == kColorTag) {
                 UIColor* argument = [FPThemeProxy colorWithKey:themeKitId];
                [invocation setArgument:&argument atIndex:2];
                [invocation invoke];
            }else if (tag == kImageTag) {
                UIImage* argument = [FPThemeProxy imageWithKey:themeKitId];
                [invocation setArgument:&argument atIndex:2];
                //括号外部调用有可能导致Image释放了导致坏内存崩溃
                [invocation invoke];
            }
        }
    }];
}
+ (void)changeKeyboardAppearce:(NSObject *)view {
    if (!FPThemeManager.share.supportsKeyboard) return;
    NSString *theme = FPThemeManager.share.currentTheme;
    if ([view isKindOfClass:UITextField.class]
        || [view isKindOfClass:UITextView.class]) {
        UIKeyboardAppearance apperance = [theme isEqualToString:kThemeKitNight] ? UIKeyboardAppearanceDark : UIKeyboardAppearanceLight;
        ((UITextField *)view).keyboardAppearance = apperance;
    }else if ([view isKindOfClass:UISearchBar.class]) {
        UIKeyboardAppearance apperance = [theme isEqualToString:kThemeKitNight] ? UIKeyboardAppearanceDark : UIKeyboardAppearanceLight;
        if (@available(iOS 13.0, *)) {
            ((UISearchBar *)view).searchTextField.keyboardAppearance = apperance;
        } else {
            UITextField *searchField = [view valueForKey:@"_searchField"];
            searchField.keyboardAppearance = apperance;
        }
    }
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    if (![aSelectorStr hasPrefix:@"set"]) {
        NSMethodSignature *sig  = [self.object methodSignatureForSelector:aSelector];
        return sig ? sig : [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    if ([aSelectorStr containsString:@"setAlpha:"] || [self.object isKindOfClass:CALayer.class]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:@"];
    }
    if ([aSelectorStr hasSuffix:@"AttributedText:"]
        || [aSelectorStr hasSuffix:@"Appearance:"]) {
        //block
        return [NSMethodSignature signatureWithObjCTypes:"v@:@?"];
    }
    NSMethodSignature *sig  = [self.object methodSignatureForSelector:aSelector];
    return sig ? sig : [NSMethodSignature signatureWithObjCTypes:"v@:@"];
}
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL aSelector = anInvocation.selector;
    if (![self.object respondsToSelector:aSelector]) {return;}
    NSString *aSelectorStr = NSStringFromSelector(aSelector);
    if (![aSelectorStr hasPrefix:@"set"]) {//get 方法直接object 调用
        [anInvocation invokeWithTarget:self.object];
        return;;
    }
    NSUInteger numberOfArguments = anInvocation.methodSignature.numberOfArguments;
    NSInteger state = -1;
    GMPickerObj *pickerObj = GMPickerObj.new;
    anInvocation.target = self.object;
    [FPThemeProxy changeKeyboardAppearce:self.object];
    //最后一个参数类型
    const char *lastArgType;
    for (NSUInteger i = 2; i < numberOfArguments; i++) { // 0:self, 1:_cmd
        const char *argType = [anInvocation.methodSignature getArgumentTypeAtIndex:i];
        if (strcmp(argType, "Q") == 0) {
            [anInvocation getArgument:&state atIndex:i];
        }
        if (i == numberOfArguments - 1) {
           lastArgType = [anInvocation.methodSignature getArgumentTypeAtIndex:i];
        }
    }
    if ([aSelectorStr containsString:@"setAlpha:"]) {
        __unsafe_unretained NSNumber *alpha;
        [anInvocation getArgument:&alpha atIndex:2];
        NSMethodSignature *sig = [self.object methodSignatureForSelector:aSelector];
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
        invocation.selector = aSelector;
        CGFloat alphaValue = alpha.floatValue;
        [invocation setArgument:&alphaValue atIndex:2];
        pickerObj.themeId = [alpha _themeKitId];
        pickerObj.tag = kAlphaTag;
        pickerObj.argument = alpha;
        invocation.target = self.object;
        [invocation invoke];
        anInvocation = invocation;
    } else if ([self.object isKindOfClass:CALayer.class]) {
        __unsafe_unretained UIColor *color;
        [anInvocation getArgument:&color atIndex:2];
        NSMethodSignature *sig = [self.object methodSignatureForSelector:aSelector];
        NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:sig];
        invocation.selector = aSelector;
        CGColorRef cgColor = color.CGColor;
        [invocation setArgument:&cgColor atIndex:2];
        pickerObj.themeId = [color _themeKitId];
        pickerObj.tag = kCGColorTag;
        pickerObj.argument = color;
        invocation.target = self.object;
        [invocation invoke];
        anInvocation = invocation;
    } else if ([self.object isKindOfClass:UINavigationBar.class]
               && strcmp(lastArgType, "@?") == 0
               && [aSelectorStr hasSuffix:@"Appearance:"]) {
        if (@available(iOS 13.0, *)) {
            __unsafe_unretained GMBlockPicker appearancePicker;
            [anInvocation getArgument:&appearancePicker atIndex:2];
            UINavigationBarAppearance* appearance;
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self.object methodSignatureForSelector:aSelector]];
            invocation.selector = aSelector;
            invocation.target = self.object;
            if (appearancePicker) {
                appearance = appearancePicker(FPThemeManager.share.currentTheme);
                pickerObj.blockPicker = [appearancePicker copy];
                [invocation setArgument:&appearance atIndex:2];
                [invocation invoke];
            }else {
                [invocation setArgument:&appearance atIndex:2];
                [invocation invoke];
            }
            pickerObj.tag = kAppearanceTag;
            anInvocation = invocation;
        } else {
            // Fallback on earlier versions
        }
    }else if (strcmp(lastArgType, "@?") == 0) {
        __unsafe_unretained GMBlockPicker blockPicker;
        NSUInteger index = numberOfArguments - 1;
        [anInvocation getArgument:&blockPicker atIndex:index];
        id blockReturnValue;
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self.object methodSignatureForSelector:aSelector]];
        invocation.selector = aSelector;
        invocation.target = self.object;
        if (blockPicker) {
            blockReturnValue = blockPicker(FPThemeManager.share.currentTheme);
            pickerObj.blockPicker = [blockPicker copy];
            [invocation setArgument:&blockReturnValue atIndex:index];
            [invocation invoke];
        }else {
            [invocation setArgument:&blockReturnValue atIndex:index];
            [invocation invoke];
        }
        anInvocation = invocation;
        pickerObj.tag = kBlockPicker;
    }else {
        __unsafe_unretained id argument;
        [anInvocation getArgument:&argument atIndex:2];
        if (argument && [argument isKindOfClass:UIColor.class]) {
            pickerObj.tag = kColorTag;
            pickerObj.themeId = [argument _themeKitId];
            pickerObj.argument = argument;
            [anInvocation invoke];
        }else if (argument && [argument isKindOfClass:UIImage.class]) {
            pickerObj.tag = kImageTag;
            pickerObj.themeId = [argument _themeKitId];
            pickerObj.argument = argument;
            [anInvocation invoke];
        }
    }
    pickerObj.invocation = anInvocation;
    [self.object._themeDic setValue:pickerObj forKey:[NSString stringWithFormat:@"%ld-%@",state,aSelectorStr]];
    [cache addObject:self.object];
}

@end
UIColor* _Nullable kColorWithKey(NSString * _Nullable key) {
    return [FPThemeProxy colorWithKey:key];
}
UIImage* _Nullable kImageWithKey(NSString * _Nullable key) {
    return [FPThemeProxy imageWithKey:key];
}
NSNumber* _Nullable kAlphaWithKey(NSString * _Nullable key) {
    return [FPThemeProxy alphaWithKey:key];
}
