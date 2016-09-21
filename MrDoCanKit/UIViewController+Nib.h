//
//  UIViewController+Nib.h
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Nib)

@property (nonatomic, assign) BOOL didSetupConstraints;

+ (instancetype)loadFromNib;
+ (instancetype)loadFromStoryBoard:(NSString *)storyBoard;
+ (instancetype)loadInitialViewControllerFromStoryBoard:(NSString *)storyBoard;

/**
 *  @brief 自定义界面，如尺寸，位置
 */
- (void)customize;

@end
