//
//  UINavigationBar+BackgroundColor.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/20.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (BackgroundColor)

@property (strong, nonatomic) UIView *dc_backgroundView;
@property (strong, nonatomic) UIImageView *dc_backgroundImageView;
@property (strong, nonatomic) NSString *dc_title;
@property (strong, nonatomic) UILabel *dc_titleLabel;

- (void)dc_setBackgroundColor:(UIColor *)backgroundColor;
- (void)dc_hiddenBackground;

- (void)dc_setLabelAlpha:(CGFloat)alpha labelTitle:(NSString *)title;
- (void)dc_hiddenTitleLabe;

- (void)dc_hiddenBackgroundImage;

@end
