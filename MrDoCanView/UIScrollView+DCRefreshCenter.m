//
//  UIScrollView+DCRefreshCenter.m
//  FenHongForIOS
//
//  Created by 王灿 on 3/8/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import "UIScrollView+DCRefreshCenter.h"

@implementation UIScrollView (DCRefreshCenter)

#pragma mark - center 

static const char DCRefreshCenterKey = '\0';
- (void)setDc_centerView:(UIView *)dc_centerView
{
    if (dc_centerView != self.dc_centerView)
    {
        [self.dc_centerView removeFromSuperview];

        dc_centerView.frame = CGRectMake(0, 0, self.width, self.height);
        
        [self insertSubview:dc_centerView atIndex:9999];
        
        [self willChangeValueForKey:@"dc_center"];
        objc_setAssociatedObject(self, &DCRefreshCenterKey,dc_centerView, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"dc_center"];
    }
}

- (UIView *)dc_centerView
{
    return objc_getAssociatedObject(self, &DCRefreshCenterKey);
}

- (void)dc_centerViewShow
{
    UIView *centerView = objc_getAssociatedObject(self, &DCRefreshCenterKey);
    [UIView animateWithDuration:0.45 animations:^{
        centerView.alpha = 1.0;
    }];
}

- (void)dc_centerViewHide
{
    UIView *centerView = objc_getAssociatedObject(self, &DCRefreshCenterKey);
    [UIView animateWithDuration:0.45 animations:^{
        centerView.alpha = 0.0;
    }];
}

- (void)layoutSubviews
{
    self.dc_centerView.size = self.size;
    self.dc_centerView.center = self.center;
}

@end
