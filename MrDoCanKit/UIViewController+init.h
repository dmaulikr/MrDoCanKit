//
//  UIViewController+init.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/13.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FHLoadForUrlViewController <NSObject>

- (void)resolveUrlPram:(NSDictionary *)pram;    //parm value is NSString Class

@end

@interface UIViewController (init)

@property (strong, nonatomic) NSString *dc_pageName;

+ (UIViewController *)viewControllerWithParameter:(NSDictionary *)loadViewControllerParameter;

- (void)dc_setTitleAlpha:(CGFloat)alpha;

@end
