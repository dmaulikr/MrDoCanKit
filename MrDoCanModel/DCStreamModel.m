//
//  DCStreamModel.m
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCStreamModel.h"

@implementation DCStreamModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty
{
    return nil == self.items || 0 == self.items.count;
}

- (void)loadMore
{
    NSAssert(NO, @"Must be overwrite");
}

#pragma mark -

- (NSString *)cacheKey
{
    return NSStringFromClass(self.class);
}

- (void)loadCache
{
    NSArray * items = [DCCache objectForKey:[self cacheKey]];
    
    if ( items )
    {
        [self.items removeAllObjects];
        [self.items addObjectsFromArray:items];
    }
}

- (void)saveCache
{
    [DCCache setObject:self.items forKey:[self cacheKey]];
}

- (void)clearCache
{
    [DCCache removeObjectForKey:[self cacheKey]];
}

@end