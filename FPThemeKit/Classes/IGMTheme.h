//
//  IGMTheme.h
//  FPThemeKit
//
//  Created by admin on 2025/5/6.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef id _Nullable(^GMBlockPicker)(NSString * _Nullable theme);
typedef void (^ _Nullable GMThemeBlock)(NSObject *_Nullable obj, NSString * _Nullable theme);



NS_ASSUME_NONNULL_BEGIN

@protocol IGMThemeView <NSObject>
@property(nullable, nonatomic,copy)UIColor* backgroundColor;
@property(nonatomic,strong)NSNumber* alpha;
@property(nullable, nonatomic,copy)UIColor* tintColor;
@end


@interface UIView()
- (void)themeKit:(void (^)(UIView *  view, NSString * theme))block;
- (id<IGMThemeView>)themeKit;
@end


@protocol IGMThemeLabel <IGMThemeView>
@property(nullable, nonatomic,copy)UIColor *textColor;
@property(nullable, nonatomic,copy,readwrite)GMBlockPicker attributedText;
@end
@interface UILabel()
- (id<IGMThemeLabel>)themeKit;
- (void)themeKit:(void (^)(UILabel *  label, NSString *  theme))block;
@end

@protocol IGMThemeTextField <IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* textColor;
@property(nullable, nonatomic,copy,readwrite)GMBlockPicker attributedText;

@end
@interface UITextField()
- (id<IGMThemeTextField>)themeKit;
- (void)themeKit:(void (^)(UITextField *  textField, NSString *  theme))block;
@end

@protocol IGMThemeTextView <IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* textColor;
@property(nullable, nonatomic,copy,readwrite)GMBlockPicker attributedText;
@end
@interface UITextView()
- (id<IGMThemeTextView>)themeKit;
- (void)themeKit:(void (^)(UITextView *  view, NSString *  theme))block;
@end

@protocol IGMThemeImageView<IGMThemeView>
@property(nullable, nonatomic,strong)UIImage* image;
@end
@interface UIImageView()
- (id<IGMThemeImageView>)themeKit;
- (void)themeKit:(void (^)(UIImageView *  view, NSString *  theme))block;
@end


@protocol IGMThemeButton<IGMThemeView>
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state;
- (void)setImage:(UIImage *)image forState:(UIControlState)state;
@end
@interface UIButton()
- (id<IGMThemeButton>)themeKit;
- (void)themeKit:(void (^)(UIButton *  view, NSString *  theme))block;
@end


@protocol IGMThemeBarButtonItem<IGMThemeView>
@end
@interface UIBarButtonItem()
- (id<IGMThemeBarButtonItem>)themeKit;
- (void)themeKit:(void (^)(UIBarButtonItem *  barButtonItem, NSString *  theme))block;
@end


@protocol IGMThemeNavigationBar<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* barTintColor;
@property (nonatomic, readwrite, copy) GMBlockPicker standardAppearance UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(13.0), tvos(13.0)) API_UNAVAILABLE(watchos);
/// Describes the appearance attributes for the navigation bar to use when it is displayed with its compact height. If not set, the standardAppearance will be used instead.
@property (nonatomic, readwrite, copy, nullable) GMBlockPicker compactAppearance UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos);
/// Describes the appearance attributes for the navigation bar to use when an associated UIScrollView has reached the edge abutting the bar (the top edge for the navigation bar). If not set, a modified standardAppearance will be used instead.
@property (nonatomic, readwrite, copy, nullable) GMBlockPicker scrollEdgeAppearance UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(13.0)) API_UNAVAILABLE(watchos);
/// Describes the appearance attributes for the navigation bar to use when it is displayed with its compact heights, and an associated UIScrollView has reached the edge abutting the bar. If not set, first the scrollEdgeAppearance will be tried, and if that is nil then compactAppearance followed by a modified standardAppearance.
@property(nonatomic,readwrite, copy, nullable) GMBlockPicker compactScrollEdgeAppearance UI_APPEARANCE_SELECTOR API_AVAILABLE(ios(15.0)) API_UNAVAILABLE(watchos);
@end
@interface UINavigationBar()<IGMThemeNavigationBar>
- (id<IGMThemeNavigationBar>)themeKit;
- (void)themeKit:(void (^)(UINavigationBar *  navigationBar, NSString *  theme))block;
@end



@protocol IGMThemeNavigationBarAppearance
@property (nonatomic, readwrite, copy, nullable) UIColor *backgroundColor;
/// An image to use for the bar background. This image is composited over the backgroundColor, and resized per the backgroundImageContentMode.
@property (nonatomic, readwrite, strong, nullable) UIImage *backgroundImage;
@property (nonatomic, readwrite, copy, nullable) UIColor *shadowColor;
/// Use an image for the shadow. See shadowColor for how they interact.
@property (nonatomic, readwrite, strong, nullable) UIImage *shadowImage;
@end
@interface UINavigationBarAppearance()
- (id<IGMThemeNavigationBarAppearance>)themeKit;
- (void)themeKit:(void (^)(UINavigationBarAppearance *  navigationBarAppearance, NSString *  theme))block;
@end


@protocol IGMThemePageControl<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* pageIndicatorTintColor;
@property(nullable, nonatomic,copy)UIColor* currentPageIndicatorTintColor;
@property(nullable, nonatomic,strong)UIImage* preferredIndicatorImage API_AVAILABLE(ios(16.0));
- (void)setCurrentPageIndicatorImage:(UIImage* )image forPage:(NSInteger)page API_AVAILABLE(ios(16.0));
- (void)setIndicatorImage:(UIImage* )image forPage:(NSInteger)page API_AVAILABLE(ios(14.0));
@end
@interface UIPageControl()
- (id<IGMThemePageControl>)themeKit;
- (void)themeKit:(void (^)(UIPageControl *  pageControl, NSString *  theme))block;
@end


@protocol IGMThemeProgressView<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* progressTintColor;
@property(nullable, nonatomic,copy)UIColor* trackTintColor;
@property(nullable, nonatomic,strong)UIImage* progressImage;
@property(nullable, nonatomic,strong)UIImage* trackImage;
@end
@interface UIProgressView()
- (id<IGMThemeProgressView>)themeKit;
- (void)themeKit:(void (^)(UIProgressView *  progressView, NSString *  theme))block;
@end

@protocol IGMThemeSearchBar<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* barTintColor;
@end
@interface UISearchBar()
- (id<IGMThemeSearchBar>)themeKit;
- (void)themeKit:(void (^)(UISearchBar *  searchBar, NSString *  theme))block;
@end

@protocol IGMThemeSlider<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* minimumTrackTintColor;
@property(nullable, nonatomic,copy)UIColor* maximumTrackTintColor;
@property(nullable, nonatomic,copy)UIColor* thumbTintColor;
@property(nullable, nonatomic,strong)UIImage* minimumValueImage;
@property(nullable, nonatomic,strong)UIImage* maximumValueImage;
- (void)setThumbImage:(UIImage*)image forState:(UIControlState)state;
- (void)setMinimumTrackImage:(UIImage*)image forState:(UIControlState)state;
- (void)setMaximumTrackImage:(UIImage*)image forState:(UIControlState)state;
@end

@interface UISlider()
- (id<IGMThemeSlider>)themeKit;
- (void)themeKit:(void (^)(UISlider *  slider, NSString *  theme))block;
@end

@protocol IGMThemeSwitch<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* onTintColor;
@property(nullable, nonatomic,copy)UIColor* thumbTintColor;
@end
@interface UISwitch()
- (id<IGMThemeSwitch>)themeKit;
- (void)themeKit:(void (^)(UISwitch *  sh, NSString *  theme))block;
@end


@protocol IGMThemeTabBar<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* barTintColo;
@end
@interface UITabBar()
- (id<IGMThemeTabBar>)themeKit;
- (void)themeKit:(void (^)(UITabBar *  tabBar, NSString *  theme))block;
@end

@protocol IGMThemeTableView<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* separatorColor;
@property(nullable, nonatomic,copy)UIColor* sectionIndexColor;
@property(nullable, nonatomic,copy)UIColor* sectionIndexBackgroundColor;
@property(nullable, nonatomic,copy)UIColor* sectionIndexTrackingBackgroundColor;
@end
@interface UITableView()
- (id<IGMThemeTableView>)themeKit;
- (void)themeKit:(void (^)(UITableView *  tableView, NSString *  theme))block;
@end

@interface UITableViewCell()
- (void)themeKit:(void (^)(UITableViewCell *  cell, NSString *  theme))block;
@end

@protocol IGMThemeToolbar<IGMThemeView>
@property(nullable, nonatomic,copy)UIColor* barTintColor;
@end
@interface UIToolbar()
- (id<IGMThemeToolbar>)themeKit;
- (void)themeKit:(void (^)(UIToolbar *  toolbar, NSString *  theme))block;
@end

@protocol IGMThemeLayer
@property(nullable, nonatomic,copy)UIColor* shadowColor;
@property(nullable, nonatomic,copy)UIColor* borderColor;
@property(nullable, nonatomic,copy)UIColor* backgroundColor;
@end
@interface CALayer()
- (id<IGMThemeLayer>)themeKit;
- (void)themeKit:(void (^)(CALayer *  layer, NSString *  theme))block;
@end

@protocol IGMThemeShapeLayer<IGMThemeLayer>
@property(nullable, nonatomic,copy)UIColor* strokeColor;
@property(nullable, nonatomic,copy)UIColor* fillColor;
@end
@interface CAShapeLayer()
- (id<IGMThemeShapeLayer>)themeKit;
- (void)themeKit:(void (^)(CAShapeLayer *  layer, NSString *  theme))block;
@end

NS_ASSUME_NONNULL_END
