//
//  DCModel.h
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCCache.h"

@interface DCModel : NSObject

@property (nonatomic, strong, readonly) NSString * cacheKey;

- (void)loadCache;
- (void)saveCache;
- (void)clearCache;

@end