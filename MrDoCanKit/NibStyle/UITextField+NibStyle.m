//
//  UITextField+NibStyle.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/17.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "UITextField+NibStyle.h"

static const char kUITextFieldNibMaxLegnthKey;

@implementation UITextField (NibStyle)

@dynamic nibMaxLength;

- (void)setNibMaxLength:(NSInteger)nibMaxLength
{
    objc_setAssociatedObject(self, &kUITextFieldNibMaxLegnthKey, @(nibMaxLength), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    self.bk_shouldChangeCharactersInRangeWithReplacementStringBlock = ^(UITextField * textField, NSRange range, NSString * string)
    {
        NSString * text = [textField.text stringByReplacingCharactersInRange:range withString:string];
        
        if ( nibMaxLength > 0 && text.length > nibMaxLength )
        {
            return NO;
        }
        
        return YES;
    };
}

- (NSInteger)nibMaxLength
{
    return [objc_getAssociatedObject(self, &kUITextFieldNibMaxLegnthKey) integerValue];
}

@end
