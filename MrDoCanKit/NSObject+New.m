//
//  NSObject+New.m
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "NSObject+New.h"

@implementation NSObject (New)

+ (instancetype)spawn
{
    return [self new];
}

- (NSDictionary *)objectToDictionary
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i<outCount; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    free(properties);
    return props;
}

- (BOOL)dc_isNull
{
    if ( [self isKindOfClass:[NSNull class]])
        return YES;
    if ( [self isKindOfClass:[NSArray class]])
    {
        if (((NSArray *)self).count == 0)
        {
            return YES;
        }
    }
    if ( [self isKindOfClass:[NSString class]] )
    {
        if ( [((NSString *)self) isEqualToString:@""] )
        {
            return YES;
        }
    }
    return NO;
}
@end
