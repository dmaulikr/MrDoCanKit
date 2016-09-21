//
//  UIViewController+Swizzling.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/14.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Swizzling)

- (void)swiz_viewWillAppear:(BOOL)animated;

- (void)swiz_viewDidLoad;

- (void)swiz_setTitle:(NSString *)title;
@end
