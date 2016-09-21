//
//  DCCache.h
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
// 

#import <Foundation/Foundation.h>

@interface DCCache : NSObject

+ (instancetype)global;

+ (void)switchCacheWithName:(NSString *)key;

+ (id)objectForKey:(NSString *)key;
+ (void)removeObjectForKey:(NSString *)key;
+ (void)setObject:(id)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;
- (void)removeObjectForKey:(NSString *)key;
- (void)setObject:(id)object forKey:(NSString *)key;

@end
