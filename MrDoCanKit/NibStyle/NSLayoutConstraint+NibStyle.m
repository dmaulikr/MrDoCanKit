//
//  NSLayoutConstraint+NibStyle.m
//  xueyou
//
//  Created by QFish on 7/18/15.
//  Copyright (c) 2015 QFish. All rights reserved.
//

#import "NSLayoutConstraint+NibStyle.h"

@implementation NSLayoutConstraint (NibStyle)

@dynamic nibConstant;

- (void)setNibConstant:(CGFloat)nibConstant
{
	self.constant = nibConstant;
}

- (CGFloat)nibConstant
{
	return self.constant;
}

- (void)setNibOnePixel:(BOOL)nibOnePixel
{
	self.constant = 1 / [UIScreen mainScreen].scale;
}

- (BOOL)nibOnePixel
{
	return YES;
}



@end
