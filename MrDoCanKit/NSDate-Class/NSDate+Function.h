//
//  NSDate+Function.h
//  tongchuang
//
//  Created by Chenyun on 15/7/1.
//  Copyright (c) 2015年 geek-zoo. All rights reserved.
//


#define SECOND		(1)
#define MINUTE		(60 * SECOND)
#define HOUR		(60 * MINUTE)
#define DAY			(24 * HOUR)
#define MONTH		(30 * DAY)
#define YEAR		(12 * MONTH)
#define NOW			[NSDate date]

@interface NSDate (Function)

- (NSString *)timeAgo;

@end
