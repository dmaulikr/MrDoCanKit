//
//  UIScrollView+DCRefreshCenter.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/8/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (DCRefreshCenter)

@property (strong, nonatomic) UIView *dc_centerView;

- (void)dc_centerViewShow;
- (void)dc_centerViewHide;
@end
