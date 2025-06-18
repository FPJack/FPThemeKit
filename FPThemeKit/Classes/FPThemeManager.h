//
//  FPThemeManager.h
//  Example
//
//  Created by admin on 2025/5/6.
//  Copyright © 2025 Draveness. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGMTheme.h"

NS_ASSUME_NONNULL_BEGIN
UIColor* _Nullable kColorWithKey(NSString * _Nullable key);
UIImage* _Nullable kImageWithKey(NSString * _Nullable key);
NSNumber* _Nullable kAlphaWithKey(NSString * _Nullable key);
//主题变化通知
extern NSString * const kThemeKitWillChangeNotification;
////主题变化UI更改完成通知
extern NSString * const kThemeKitDidChangedNotification;
//默认模式
extern NSString * const kThemeKitNormal;
//暗黑模式
extern NSString * const kThemeKitNight;

typedef NSDictionary<NSString *,NSDictionary<NSString*,NSDictionary<NSString*,id>*>*> GMThemeSourceType;

@interface FPThemeManager : NSObject

/// 根据文件解析主题集合
@property (nonatomic,strong,readonly)NSArray<NSString *> *themes;

/// 当前主题
@property (nonatomic,copy,readonly)NSString *currentTheme;

/// 状态栏是否设置跟随主题变化 默认YES
@property (nonatomic, assign) BOOL supportsStatusBar;

/// 键盘是否跟随主题变化 默认YES
@property (nonatomic, assign) BOOL supportsKeyboard;


/// 根据id加载颜色为空展示默认颜色
@property (nonatomic,copy)UIColor *defaultColor;
/// 根据id加载图片为空展示默认图片
@property (nonatomic,strong)UIImage *defaultImage;
/// 根据id加载alpha为空展示默认透明度
@property (nonatomic,copy)NSNumber *defaultAlpha;

+ (instancetype)share;

//"GMTheme(库里面的某一个类名)/BundleName(库里面资源bundle名)/imageName"
//"GMTheme/imageName" 如果库里的某个类名和资源bundle名一致，可以省略bundle名
//imageName 默认读主bundle里面资源
- (void)loadFromColorFilePath:(NSString * _Nullable)colorPath
                imageFilePath:(NSString * _Nullable)imagePath
                alphaFilePath:(NSString * _Nullable)alphaPath;

/// 通过info.plist文件字典加载
/// - Parameter themeSource: <#themeSource description#>
- (void)loadFromDictionaryInfo:(GMThemeSourceType *)themeSource;

- (void)updateTheme:(NSString *)theme;

+ (UIColor *)colorWithKey:(NSString *)key;
+ (UIImage *)imageWithKey:(NSString *)key;
+ (NSNumber *)alphaWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
