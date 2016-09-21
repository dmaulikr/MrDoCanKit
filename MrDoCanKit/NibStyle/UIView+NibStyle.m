//
//  UIView+NibStyle.m
//  FenHongForIOS
//
//  Created by 王灿 on 3/10/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import "UIView+NibStyle.h"

@implementation UIView (NibStyle)

@dynamic nibBorderColor;
@dynamic nibBorderWidth;
@dynamic nibCornerRadius;
@dynamic nibBackgroundColorToAppTheme;

static const char backgroundCollorToSpaciousKey = '\0';
-(void)setBackgroundColorToSpacious:(NSString *)backgroundCollorToSpacious
{
    
    objc_setAssociatedObject(self, &backgroundCollorToSpaciousKey,backgroundCollorToSpacious, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)backgroundColorToSpacious
{
    return objc_getAssociatedObject(self, &backgroundCollorToSpaciousKey);
}



+ (UIColor *)colorWithAny:(id)any
{
    if ( [any isKindOfClass:[NSString class]] ) {
        return [UIColor colorWithHexString:any];
    } else if ( [any isKindOfClass:[UIColor class]] ) {
        return (UIColor *)any;
    } else {
        return nil;
    }
}

- (void)setNibBorderColor:(id)nibBorderColor
{
    UIColor * color = [UIView colorWithAny:nibBorderColor];
    if ( color ) {
        self.layer.borderColor =color.CGColor;
    }
}

- (void)setNibBorderWidth:(NSNumber *)nibBorderWidth
{
    self.layer.borderWidth = nibBorderWidth.floatValue;
}

- (void)setNibCornerRadius:(NSNumber *)nibCornerRadius
{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = nibCornerRadius.floatValue;
}

- (void)setNibBackgroundColorToAppTheme:(NSString *)nibBackgroundColorToAppTheme
{
    self.backgroundColor = (UIColor *)[[AppTheme sharedAppTheme] performSelector:NSSelectorFromString(nibBackgroundColorToAppTheme) withObject:nil];
}

@end
