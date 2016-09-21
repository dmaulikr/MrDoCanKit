//
//  UIScrollView+DCRefreshHeader.m
//  FenHongForIOS
//
//  Created by 王灿 on 3/9/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import "UIScrollView+DCRefreshHeader.h"

@implementation UIScrollView (DCRefreshHeader)

#pragma mark - herder

static const char DCRefreshHeaderKey = '\0';
- (void)setDc_headerView:(UIView *)dc_headerView
{
    if (dc_headerView != self.dc_headerView)
    {
        [self.dc_headerView removeFromSuperview];
        
        dc_headerView.frame = self.mj_header.frame;
        dc_headerView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        
        [self.mj_header insertSubview:dc_headerView atIndex:9999];
        
        [self willChangeValueForKey:@"dc_center"];
        objc_setAssociatedObject(self, &DCRefreshHeaderKey,dc_headerView, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"dc_center"];
    }
}

- (UIView *)dc_headerView
{
    return objc_getAssociatedObject(self, &DCRefreshHeaderKey);
}
@end
