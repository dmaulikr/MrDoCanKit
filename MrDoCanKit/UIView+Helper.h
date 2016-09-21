//
//  UIView+Helper.h
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, UIViewHelperLayoutOptions) {
    // conflict with each other
    UIViewHelperLayoutOptionsLeft    = 1 << 0,
    UIViewHelperLayoutOptionsRight   = 1 << 1,
    UIViewHelperLayoutOptionsHCenter = 1 << 2,
    // conflict with each other
    UIViewHelperLayoutOptionsTop     = 1 << 3,
    UIViewHelperLayoutOptionsBottom  = 1 << 4,
    UIViewHelperLayoutOptionsVCenter = 1 << 5,
};

@interface UIView (Helper)

@property (assign, nonatomic) CGFloat	top;
@property (assign, nonatomic) CGFloat	bottom;
@property (assign, nonatomic) CGFloat	left;
@property (assign, nonatomic) CGFloat	right;

@property (assign, nonatomic) CGPoint	offset;
@property (assign, nonatomic) CGPoint	position;

@property (assign, nonatomic) CGFloat	x;
@property (assign, nonatomic) CGFloat	y;
@property (assign, nonatomic) CGFloat	w;
@property (assign, nonatomic) CGFloat	h;

@property (assign, nonatomic) CGFloat	width;
@property (assign, nonatomic) CGFloat	height;
@property (assign, nonatomic) CGSize	size;

@property (assign, nonatomic) CGFloat	centerX;
@property (assign, nonatomic) CGFloat	centerY;
@property (assign, nonatomic) CGPoint	origin;
@property (readonly, nonatomic) CGPoint	boundsCenter;

- (void)floatWithOptions:(UIViewHelperLayoutOptions)options;
- (void)floatWithOptions:(UIViewHelperLayoutOptions)options margin:(UIEdgeInsets)margin;

- (void)floatInView:(UIView *)view options:(UIViewHelperLayoutOptions)options;
- (void)floatInView:(UIView *)view options:(UIViewHelperLayoutOptions)options margin:(UIEdgeInsets)margin;

- (void)alignToView:(UIView *)view options:(UIViewHelperLayoutOptions)options;
- (void)alignToView:(UIView *)view options:(UIViewHelperLayoutOptions)options margin:(UIEdgeInsets)margin;

@end
