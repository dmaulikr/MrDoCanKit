//
//  DCModel.m
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCModel.h"

@interface DCModel ()
@end

@implementation DCModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (NSString *)cacheKey
{
    return [[self class] description];
}

- (void)loadCache {}
- (void)saveCache {}
- (void)clearCache {}

@end
