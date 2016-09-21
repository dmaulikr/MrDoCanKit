//
//  NSObject+Tips.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/16.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - UIView

@interface UIView (Tips)

- (void)presentMessageTips:(NSString *)message;
- (void)presentSuccessTips:(NSString *)message;
- (void)presentFailureTips:(NSString *)message;
- (void)presentLoadingTips:(NSString *)message;

- (void)dismissTips;

@end

#pragma mark - UIViewController

@interface UIViewController (Tips)

- (void)presentMessageTips:(NSString *)message;
- (void)presentSuccessTips:(NSString *)message;
- (void)presentFailureTips:(NSString *)message;
- (void)presentLoadingTips:(NSString *)message;

- (void)dismissTips;

@end
