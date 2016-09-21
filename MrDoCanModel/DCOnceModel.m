//
//  DCOnceModel.m
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCOnceModel.h"

@implementation DCOnceModel

- (BOOL)isEmpty
{
    return nil == self.item;
}

#pragma mark -

- (NSString *)cacheKey
{
    return NSStringFromClass(self.class);
}

- (void)loadCache
{
    self.item = [DCCache objectForKey:[self cacheKey]];
}

- (void)saveCache
{
    [DCCache setObject:self.item forKey:[self cacheKey]];
}

- (void)clearCache
{
    [DCCache removeObjectForKey:[self cacheKey]];
}

@end