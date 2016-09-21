//
//  UINavigationBar+BackgroundColor.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/20.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "UINavigationBar+BackgroundColor.h"

@implementation UINavigationBar (BackgroundColor)

static const char dc_backgroundViewKey = '\0';
- (UIView *)dc_backgroundView
{
    return objc_getAssociatedObject(self, &dc_backgroundViewKey);
}

- (void)setDc_backgroundView:(UIView *)dc_backgroundView
{
    objc_setAssociatedObject(self, &dc_backgroundViewKey, dc_backgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char dc_backgroundImageViewKey = '\0';
- (UIImageView *)dc_backgroundImageView
{
    return objc_getAssociatedObject(self, &dc_backgroundImageViewKey);
}

- (void)setDc_backgroundImageView:(UIImageView *)dc_backgroundImageView
{
    if ( self.dc_backgroundImageView )
    {
        [self.dc_backgroundImageView removeFromSuperview];
    }
    objc_setAssociatedObject(self, &dc_backgroundImageViewKey, dc_backgroundImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    for (UIView *view in self.subviews )
    {
        if ([view isKindOfClass:[NSClassFromString(@"_UINavigationBarBackground") class]] )
        {
            [self insertSubview:self.dc_backgroundImageView belowSubview:view];
            self.dc_backgroundImageView.frame = view.frame;
        }
    }
}

static const char dc_titleKey = '\0';
- (NSString *)dc_title
{
    return objc_getAssociatedObject(self, &dc_titleKey);
}

- (void)setDc_title:(NSString *)dc_title
{
    objc_setAssociatedObject(self, &dc_titleKey, dc_title, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

static const char dc_titleLabelKey = '\0';
- (UILabel *)dc_titleLabel
{
    return objc_getAssociatedObject(self, &dc_titleLabelKey);
}

- (void)setDc_titleLabel:(UILabel *)dc_titleLabel
{
    objc_setAssociatedObject(self, &dc_titleLabelKey, dc_titleLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)dc_setBackgroundColor:(UIColor *)backgroundColor
{
    for (UIView *view in self.subviews )
    {
        if ([view isKindOfClass:[NSClassFromString(@"_UINavigationBarBackground") class]] )
        {
            view.hidden = YES;
        }
    }
    if (!self.dc_backgroundView)
    {
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self setShadowImage:[UIImage new]]; 
    self.dc_backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, 64)];
    [self insertSubview:self.dc_backgroundView atIndex:0];
    }
    self.dc_backgroundView.backgroundColor = backgroundColor;
}

- (void)dc_hiddenBackground
{
    for (UIView *view in self.subviews )
    {
        if ([view isKindOfClass:[NSClassFromString(@"_UINavigationBarBackground") class]] )
        {
            view.hidden = NO;
        }
    }
    if (!self.dc_backgroundView)
    {
        [self.dc_backgroundView removeFromSuperview];
    }
}

- (void)dc_setLabelAlpha:(CGFloat)alpha labelTitle:(NSString *)title;
{
    if ( title != nil && ![title dc_isNull] )
    {
        self.dc_title = title;
    }
    if ( !self.dc_titleLabel )
    {
        for (UIView *view in self.subviews )
        {
            if ( [view isKindOfClass:[NSClassFromString(@"UINavigationItemView") class]] )
            {
                for (UIView *subview in view.subviews )
                {
                    if ( [subview isKindOfClass:[UILabel class]] )
                    {
                        self.dc_titleLabel = [[UILabel alloc] init];
                        self.dc_titleLabel.font = ((UILabel *)subview).font;
                        self.dc_titleLabel.textColor = ((UILabel *)subview).textColor;
                        self.dc_titleLabel.text = self.dc_title;
                        self.dc_titleLabel.frame = subview.frame;
                        self.dc_titleLabel.height = [self.dc_title heightWithWidth:9999.9 font:17];
                        self.dc_titleLabel.width = [self.dc_title widthWithheight:9999.9 font:17];
                        self.dc_titleLabel.center = view.center;
                        [self insertSubview:self.dc_titleLabel aboveSubview:view];
                        self.dc_titleLabel.alpha = alpha;
                        return;
                    }
                }
            }
        }
    }
    self.dc_titleLabel.alpha = alpha;
}

- (void)dc_hiddenTitleLabe
{
    [self.dc_titleLabel removeFromSuperview];
    self.dc_titleLabel = nil;
}

- (void)dc_hiddenBackgroundImage
{
    for (UIView *view in self.subviews )
    {
        if ([view isKindOfClass:[NSClassFromString(@"_UINavigationBarBackground") class]] )
        {
            view.hidden = NO;
        }
    }
    if (!self.dc_backgroundImageView)
    {
        [self.dc_backgroundImageView removeFromSuperview];
    }
}

@end
