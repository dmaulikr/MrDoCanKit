//
//  NSArray+JSON.m
//  FenHongForIOS
//
//  Created by 王灿 on 16/3/29.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "NSArray+JSON.h"

@implementation NSArray (JSON)

- (NSString *)dc_toJSON
{
    NSString *jsonString = @"[";
    for (int i = 0; i < self.count ; i++ )
    {
        id obj = self[i];
        if ( [obj isKindOfClass:[JSONModel class]] )
        {
            if ( i != self.count - 1 )
            {
                jsonString = [NSString stringWithFormat:@"%@%@,", jsonString, [((JSONModel *)obj) toJSONString]];
            }
            else
            {
                jsonString = [NSString stringWithFormat:@"%@%@]", jsonString, [((JSONModel *)obj) toJSONString]];
            }
        }
        else if ( [obj isKindOfClass:[NSString class]] )
        {
            if ( i != self.count - 1 )
            {
                jsonString = [NSString stringWithFormat:@"%@%@,", jsonString, (NSString *)obj];
            }
            else
            {
                jsonString = [NSString stringWithFormat:@"%@%@]", jsonString, (NSString *)obj];
            }
        }
        else if ( [obj isKindOfClass: [NSNumber class]] )
        {
            if ( i != self.count - 1 )
            {
                jsonString = [NSString stringWithFormat:@"%@%@,", jsonString, ((NSNumber *)obj).stringValue];
            }
            else
            {
                jsonString = [NSString stringWithFormat:@"%@%@]", jsonString, ((NSNumber *)obj).stringValue];
            }
        }
        else
        {
            return nil;
        }
    }
    return jsonString;
}

@end
