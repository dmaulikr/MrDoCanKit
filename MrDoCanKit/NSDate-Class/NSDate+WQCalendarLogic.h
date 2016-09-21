//
//  Color.h
//  VIPTravel
//
//  Created by 张凡 on 14-6-6.
//  Copyright (c) 2014年 张凡. All rights reserved.
//

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com

#import <Foundation/Foundation.h>

@interface NSDate (WQCalendarLogic)

- (NSUInteger)numberOfDaysInCurrentMonth;

- (NSUInteger)numberOfWeeksInCurrentMonth;

- (NSUInteger)weeklyOrdinality;

- (NSDate *)firstDayOfCurrentMonth;

- (NSDate *)lastDayOfCurrentMonth;

- (NSDate *)dayInThePreviousMonth;

- (NSDate *)dayInTheFollowingMonth;

- (NSDate *)dayInTheFollowingMonth:(int)month;//获取当前日期之后的几个月

/**
 *  获取当前日期过指定天数后的日期
 *
 *  @param day
 *
 *  @return 日期
 */
- (NSDate *)dayInTheFollowingDay:(int)day;

/**
 *  获取当前日期到指定日期之间有多少天
 *
 *  @param day
 *
 *  @return
 */
- (NSInteger)dayInTheFollowingDate:(NSDate *)endDate;

- (NSDateComponents *)YMDComponents;
- (NSDateComponents *)YMDHMComponents;
- (NSString *)currentDateForMatterYMD;
- (NSString *)currentDateForMatterMD;
- (NSString *)currentDateForMatterYMDHM;

- (NSDate *)dateFromString:(NSString *)dateString;//NSString转NSDate

- (NSString *)stringFromDate;//NSDate转NSString

+ (NSInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

- (NSInteger)getWeekIntValueWithDate;


//判断日期是今天,明天,后天,周几
- (NSString *)compareIfTodayWithDate;
//通过数字返回星期几
+ (NSString *)getWeekStringFromInteger:(NSInteger)week;

- (NSDate *)nextDayInTheFollowwingDay:(NSInteger)type;

@end
