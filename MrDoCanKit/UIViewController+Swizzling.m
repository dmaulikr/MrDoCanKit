//
//  UIViewController+Swizzling.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/14.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "UIViewController+Swizzling.h"

@implementation UIViewController (Swizzling)

+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL systemSel = @selector(viewWillAppear:);
        SEL swizzSel = @selector(swiz_viewWillAppear:);
        
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        
        if ( isAdd )
        {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }
        else
        {
          method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
    
    static dispatch_once_t onceToken2;
    dispatch_once(&onceToken2, ^{
        SEL systemSel = @selector(viewDidLoad);
        SEL swizzSel = @selector(swiz_viewDidLoad);
        
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        
        if ( isAdd )
        {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }
        else
        {
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
    static dispatch_once_t onceToken3;
    dispatch_once(&onceToken3, ^{
        SEL systemSel = @selector(setTitle:);
        SEL swizzSel = @selector(swiz_setTitle:);
        
        Method systemMethod = class_getInstanceMethod([self class], systemSel);
        Method swizzMethod = class_getInstanceMethod([self class], swizzSel);
        
        BOOL isAdd = class_addMethod(self, systemSel, method_getImplementation(swizzMethod), method_getTypeEncoding(swizzMethod));
        
        if ( isAdd )
        {
            class_replaceMethod(self, swizzSel, method_getImplementation(systemMethod), method_getTypeEncoding(systemMethod));
        }
        else
        {
            method_exchangeImplementations(systemMethod, swizzMethod);
        }
    });
}

- (void)swiz_viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar dc_hiddenBackground];
    [self.navigationController.navigationBar dc_hiddenTitleLabe];
    [self.navigationController.navigationBar dc_hiddenBackgroundImage];
    
    //
    [self swiz_viewWillAppear:animated];
    //
    
    if ( self.dc_pageName && ![self.dc_pageName dc_isNull] )
    {
        [MiStatSDK recordPage:self.dc_pageName];
    }
    else if (self.title && ![self.title dc_isNull] )
    {
        [MiStatSDK recordPage:self.title];
    }
    else if ( self.navigationItem.title && ![self.navigationItem.title dc_isNull] )
    {
        [MiStatSDK recordPage:self.navigationItem.title];
    }
}

- (void)swiz_viewDidLoad
{
    UINavigationController *navigationController =  self.navigationController;
    NSArray<__kindof UIViewController *> *array = navigationController.childViewControllers;
    if ( array &&array.count )
    {
        UIViewController * viewController =[array firstObject];
        if ( [self isKindOfClass:viewController.class] )
        {
            self.navigationItem.leftBarButtonItems = @[];
        }
        else
        {
            __weak typeof( self ) weakSelf = self;
            self.navigationItem.leftBarButtonItems = @[[AppTheme backItemWithHandler:^(id sender) {
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }], [AppTheme itemWithContent:@"" handler:nil]];
        }
        
    }
    
    //
    [self swiz_viewDidLoad];
    //
}

- (void)swiz_setTitle:(NSString *)title
{
    self.dc_pageName = title;
    [self swiz_setTitle:title];
}

@end
