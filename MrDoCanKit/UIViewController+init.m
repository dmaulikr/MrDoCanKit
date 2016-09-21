//
//  UIViewController+init.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/13.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "UIViewController+init.h"

@implementation UIViewController (init)

+ (UIViewController *)viewControllerWithParameter:(NSDictionary *)loadViewControllerParameter;
{
    UIViewController *viewController = [self spawn];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([viewController class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
         const char * name = property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id value = [loadViewControllerParameter valueForKey:propertyName];
        if ( value ) [viewController setValue:value forKeyPath:propertyName];        
    }
    return viewController;
}

static const char DCPageNameKey = '\0';
- (void)setDc_pageName:(NSString *)dc_pageName
{
    if ( dc_pageName != self.dc_pageName )
    {
        objc_setAssociatedObject(self, &DCPageNameKey, dc_pageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSString *)dc_pageName
{
    return objc_getAssociatedObject(self, &DCPageNameKey);
}

- (void)dc_setTitleAlpha:(CGFloat)alpha
{
    [self.navigationController.navigationBar dc_setLabelAlpha:alpha labelTitle:self.dc_pageName];
    self.title = @"";
}


@end


