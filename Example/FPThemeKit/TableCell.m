//
//  TableCell.m
//  FPThemeKit_Example
//
//  Created by admin on 2025/5/6.
//  Copyright © 2025 fanpeng. All rights reserved.
//

#import "TableCell.h"
#import <FPThemeKit/FPThemeKit.h>
#import <FPThemeKit/IGMTheme.h>
@implementation TableCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    self.alphaView.themeKit.alpha = @(0.5);
//    [self.button setImage:[UIImage imageNamed:@"image_red"] forState:UIControlStateNormal];
//    [self.button setImage:nil forState:UIControlStateNormal];

//    self.button.themeKit.backgroundColor = [GMThemeProxy colorWithKey:@"BAR"];
//    return;;
    
//    [self setImage:[self createRedBackgroundImageWithSize:CGSizeMake(100, 100)] forButton:self.button state:UIControlStateNormal];
//    return;
//    SEL selector = @selector(setImage:forState:);
//
//    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[self.button methodSignatureForSelector:selector]];
//    invocation.target = self.button;
//    invocation.selector = selector;
//    UIImage *image = UIImage.new;
//    [invocation setArgument:&image atIndex:2];
//    NSInteger state = 0;
//    [invocation setArgument:&state atIndex:3];
//    [invocation invoke];
//    return;
    
    [self themeKit:^(UIView * _Nullable v, NSString * _Nullable theme) {
        TableCell *view = (TableCell *)v;
        view.switch1.onTintColor = kColorWithKey(@"SEP");
        NSString *text = @"这是富文本红色文字，这是蓝色文字";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attrStr addAttribute:NSForegroundColorAttributeName
                       value: kColorWithKey(@"RICH")
                       range:NSMakeRange(2, 4)]; // "红色文字"
        [attrStr addAttribute:NSForegroundColorAttributeName
                       value: kColorWithKey(@"BAR")
                       range:NSMakeRange(9, 4)]; // "蓝色文字"
        view.textField.attributedText = attrStr;
        
       
        
    //
        view.slider.thumbTintColor = kColorWithKey(@"TEXT");
        view.slider.maximumTrackTintColor = kColorWithKey(@"SEP");
        //
        view.slider.minimumTrackTintColor = kColorWithKey(@"BAR");
        //
        
        view.progress.progressTintColor = kColorWithKey(@"SEP");
        //
        view.progress.trackTintColor = kColorWithKey(@"BAR");

        view.pagecontroll.currentPageIndicatorTintColor = kColorWithKey(@"BAR");
        view.pagecontroll.pageIndicatorTintColor = kColorWithKey(@"BAR");
        [view.pagecontroll setCurrentPageIndicatorImage:kImageWithKey(@"image1") forPage:0];
        [view.pagecontroll setIndicatorImage:kImageWithKey(@"image1") forPage:0];
        [view.pagecontroll setIndicatorImage:kImageWithKey(@"image2") forPage:1];
        [view.pagecontroll setIndicatorImage:kImageWithKey(@"image3") forPage:2];

        view.button.backgroundColor =  kColorWithKey(@"BAR");
        [view.button setTitleColor: kColorWithKey(@"TEXT") forState:UIControlStateNormal];
    ////
        [view.button setImage:kImageWithKey(@"image1")  forState:UIControlStateNormal];
        [view.button setImage:kImageWithKey(@"image2")  forState:UIControlStateSelected];
    //
    //    self.textField.themeKit.textColor = GMColorPickerWithKey(TEXT);
    //    self.label.themeKit.textColor = GMColorPickerWithKey(TEXT);
        view.label.textColor = kColorWithKey(@"TEXT");
      
        
    //
    //    self.alphaView.themeKit.alpha = [GMThemeProxy alphaWithKey:@"alpha1"];
        view.alphaView.alpha = kAlphaWithKey(@"alpha1").floatValue;
        view.layer.borderColor = kColorWithKey(@"RICH").CGColor;
        view.layer.borderWidth = 2;
        
        [view themeKit:^(UIView * _Nullable v, NSString * _Nullable theme) {
            NSLog(@"%@",v);
        }];
    }];
    return;
    self.switch1.themeKit.onTintColor = kColorWithKey(@"SEP");
    self.textField.themeKit.attributedText = ^NSAttributedString * _Nullable(NSString * _Nullable theme) {
        NSString *text = @"这是富文本红色文字，这是蓝色文字";
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:text];
        [attrStr addAttribute:NSForegroundColorAttributeName
                       value: kColorWithKey(@"RICH")
                       range:NSMakeRange(2, 4)]; // "红色文字"
        [attrStr addAttribute:NSForegroundColorAttributeName
                       value: kColorWithKey(@"BAR")
                       range:NSMakeRange(9, 4)]; // "蓝色文字"
        return attrStr;
    };
    
   
    
//
    self.slider.themeKit.thumbTintColor = kColorWithKey(@"TEXT");
    self.slider.themeKit.maximumTrackTintColor = kColorWithKey(@"SEP");
    //
    self.slider.themeKit.minimumTrackTintColor = kColorWithKey(@"BAR");
    //
    
    self.progress.themeKit.progressTintColor = kColorWithKey(@"SEP");
    //
    self.progress.themeKit.trackTintColor = kColorWithKey(@"BAR");

    self.pagecontroll.themeKit.currentPageIndicatorTintColor = kColorWithKey(@"BAR");
    self.pagecontroll.themeKit.pageIndicatorTintColor = kColorWithKey(@"BAR");
    [self.pagecontroll.themeKit setCurrentPageIndicatorImage:kImageWithKey(@"image1") forPage:0];
    [self.pagecontroll.themeKit setIndicatorImage:kImageWithKey(@"image1") forPage:0];
    [self.pagecontroll.themeKit setIndicatorImage:kImageWithKey(@"image2") forPage:1];
    [self.pagecontroll.themeKit setIndicatorImage:kImageWithKey(@"image3") forPage:2];

    self.button.themeKit.backgroundColor =  kColorWithKey(@"BAR");
    [self.button.themeKit setTitleColor: kColorWithKey(@"TEXT") forState:UIControlStateNormal];
////
    [self.button.themeKit setImage:kImageWithKey(@"image1")  forState:UIControlStateNormal];
    [self.button.themeKit setImage:kImageWithKey(@"image2")  forState:UIControlStateSelected];
//
//    self.textField.themeKit.textColor = GMColorPickerWithKey(TEXT);
//    self.label.themeKit.textColor = GMColorPickerWithKey(TEXT);
    self.label.themeKit.textColor = kColorWithKey(@"TEXT");
  
    [self.label themeKit:^(UILabel * _Nonnull label, NSString * _Nonnull theme) {
        label.textColor = kColorWithKey(@"TEXT");
    }];
   
//
//    self.alphaView.themeKit.alpha = [GMThemeProxy alphaWithKey:@"alpha1"];
    self.alphaView.themeKit.alpha = kAlphaWithKey(@"alpha1");
    self.layer.themeKit.borderColor = kColorWithKey(@"RICH");
    self.layer.borderWidth = 2;
//    self.backgroundColor = nil;
//
//    NSString *txt = @"[self.pagecontroll.themeKit setIndicatorImage:GMImagePickerWithKey(image1) forPage:0]";
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:txt];
//    
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    
//    UIFont *font = [UIFont systemFontOfSize:18];
//    UIColor *textColor = UIColor.redColor;
//    
//    [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, txt.length)];
//    [string addAttribute:NSForegroundColorAttributeName value:textColor range:NSMakeRange(0, txt.length)];
//    [string addAttribute:NSParagraphStyleAttributeName value:paragraph range:NSMakeRange(0, txt.length)];
//    
//    [string setAttributes:@{NSForegroundColorAttributeName : UIColor.blueColor} range:[txt rangeOfString:@"setIndicatorImage:"]];
//    @weakify(self)
//    [string setTextHighlightRange:[txt rangeOfString:@"setIndicatorImage:"] color:UIColor.blueColor backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
//        @strongify(self)
//        NSLog(@"setTextHighlightRange");
//    }];
    
//    self.label.attributedText = string;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (IBAction)buttonAction:(UIButton *)sender {
    
    [sender themeKit:^(UIButton * _Nonnull view, NSString * _Nonnull theme) {
        NSLog(@"%@",view);
    }];
   
}
- (void)dealloc
{
    NSLog(@"dealloc %@", NSStringFromClass(self.class));
}

@end
