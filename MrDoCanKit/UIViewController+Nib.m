//
//  UIViewController+Nib.m
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "UIViewController+Nib.h"
#import <objc/runtime.h>

static const char kDidSetupConstraintsKey;

@implementation UIViewController (Nib)

@dynamic didSetupConstraints;

- (void)setDidSetupConstraints:(BOOL)didSetupConstraints
{
    objc_setAssociatedObject(self, &kDidSetupConstraintsKey, @(didSetupConstraints), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)didSetupConstraints
{
    return [objc_getAssociatedObject(self, &kDidSetupConstraintsKey) boolValue];
}

+ (instancetype)loadFromNib
{
    return [[self alloc] initWithNibName:NSStringFromClass(self) bundle:nil];
}

+ (instancetype)loadFromStoryBoard:(NSString *)storyBoard
{
    UIViewController * board = [[UIStoryboard storyboardWithName:storyBoard bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass(self)];
    return board;
}

+ (instancetype)loadInitialViewControllerFromStoryBoard:(NSString *)storyBoard
{
    UIViewController * board = [[UIStoryboard storyboardWithName:storyBoard bundle:nil] instantiateInitialViewController];
    return board;
}

/**
 *  @brief 自定义界面，如尺寸，位置
 */
- (void)customize
{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

@end
