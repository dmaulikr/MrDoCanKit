//
//  Validator.m
//  MrDoCanHelper
//
//  Created by wangcan on 1/3/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "Validator.h"

@implementation Validator

+ (BOOL)isInt:(NSString *)string
{
    NSString * MOBILE = @"[-+]?[0-9]*";
    NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return  [regextestMobile evaluateWithObject:string];
}

+ (BOOL)isPhoneNumber:(NSString *)string
{
	NSString * MOBILE = @"^[1-9]\\d{10}$";
	NSPredicate *regextestMobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
	return  [regextestMobile evaluateWithObject:string];
}

+ (BOOL)isUserName:(NSString *)string
{
	NSString *		regex = @"(^[A-Za-z0-9]{3,14}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:string];
}

+ (BOOL)isPassword:(NSString *)string
{
	NSString *		regex = @"(^[A-Za-z0-9]{6,16}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:string];
}


+ (BOOL)isVerifyCode:(NSString *)string
{
	NSString *		regex = @"(^[A-Za-z0-9]{6,}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:string];
}

+ (BOOL)isNumOrLetter:(NSString *)string
{
	NSString *		regex = @"(^[A-Za-z0-9]{0,}$)";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:string];
}

+ (BOOL)isNum:(NSString *)string
{
	NSString *		regex = @"^[0-9]*$";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
	
	return [pred evaluateWithObject:string];
}

+ (BOOL)isAbc:(NSString *)string
{
	NSString *		regex = @"^[a-zA-Z]*$";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

	return [pred evaluateWithObject:string];
}

+ (BOOL)isEmail:(NSString *)string
{
	NSString *		regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
	NSPredicate *	pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];

	return [pred evaluateWithObject:string];
}

@end
