//
//  NSString+Function.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/16.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "NSString+Function.h"

@implementation NSString (Function)

- (NSString *)dc_disable_emoji
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:self
                                                               options:0
                                                                 range:NSMakeRange(0, [self length])
                                                          withTemplate:@""];
    return modifiedString;
}

@end
