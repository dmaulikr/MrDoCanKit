//
//  NSObject+New.h
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (New)

+ (instancetype)spawn;
- (NSDictionary *)objectToDictionary;
- (BOOL)dc_isNull;
@end
