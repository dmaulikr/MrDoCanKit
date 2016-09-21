//
//  DCCache.m
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCCache.h"
#import "PINCache.h"

@interface DCCache ()
@property (nonatomic, readonly) DCCache * sharedInstance;
- (DCCache *)sharedInstance;
+ (DCCache *)sharedInstance;
@property (nonatomic, strong) PINCache * cache;
@end

@implementation DCCache

@dynamic sharedInstance;
- (DCCache *)sharedInstance
{
    return [DCCache sharedInstance];
}
+ (DCCache *)sharedInstance
{
    static dispatch_once_t once;
    static  DCCache *singleton = nil;
    dispatch_once( &once, ^{
        singleton = [[DCCache alloc] init];
        singleton.cache = [[PINCache alloc] initWithName:[self cacheName]];
    } );
    return singleton;
}

+ (NSString *)cacheName
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+ (instancetype)global
{
    static dispatch_once_t once;
    static __strong DCCache * global = nil;
    dispatch_once( &once, ^{
        global = [[DCCache alloc] init];
        global.cache = [[PINCache alloc] initWithName:[self cacheName]];
    } );
    return global;
}

- (void)switchCacheWithName:(NSString *)name
{
    if ( !name ) {
        name = @"default";
    }
    
    self.cache = [[PINCache alloc] initWithName:name];
}

#pragma mark -

- (void)setObject:(id <NSCoding, NSObject>)object forKey:(NSString *)key
{
    if ( !object )
        return;
    
    NSParameterAssert( [object respondsToSelector:@selector(initWithCoder:)] && [object respondsToSelector:@selector(encodeWithCoder:)] );
    [self.cache.diskCache setObject:(id<NSCoding>)object forKey:key];
}

- (id <NSCoding>)objectForKey:(NSString *)key
{
    return [self.cache.diskCache objectForKey:key];
}

- (void)removeObjectForKey:(NSString *)key
{
    [self.cache.diskCache removeObjectForKey:key];
}

#pragma mark -

+ (void)switchCacheWithName:(NSString *)name
{
    [[self sharedInstance] switchCacheWithName:name];
}

+ (void)setObject:(id)object forKey:(NSString *)key
{
    [[self sharedInstance] setObject:object forKey:key];
}

+ (id)objectForKey:(NSString *)key
{
    return [[self sharedInstance] objectForKey:key];
}

+ (void)removeObjectForKey:(NSString *)key
{
    return [[self sharedInstance] removeObjectForKey:key];
}

@end

