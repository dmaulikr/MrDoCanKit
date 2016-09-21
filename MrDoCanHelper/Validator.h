//
//  FOValidator.h
//  MrDoCanHelper
//
//  Created by wangcan on 1/3/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Validator : NSObject

/**
 *  判断是否为整数
 */
+ (BOOL)isInt:(NSString *)string;

/**
 *  11位数字
 **/
+ (BOOL)isPhoneNumber:(NSString *)string;

/**
 *  长度大于2
 **/
+ (BOOL)isUserName:(NSString *)string;

/**
 *  6-20 字母数字
 **/
+ (BOOL)isPassword:(NSString *)string;

/**
 *  验证码
 **/
+ (BOOL)isVerifyCode:(NSString *)string;

/**
 *  是否是数字和字母
 **/
+ (BOOL)isNumOrLetter:(NSString *)string;

/**
 *  是否是数字
 **/
+ (BOOL)isNum:(NSString *)string;

/**
 *  是否是字母
 **/
+ (BOOL)isAbc:(NSString *)string;

/**
 *  判断是否是邮箱
 */
+ (BOOL)isEmail:(NSString *)string;

@end
