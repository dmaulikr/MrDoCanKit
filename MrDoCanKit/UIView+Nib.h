//
//  UIView+Nib.h
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Nib)

+ (UINib *)nib;
+ (UINib *)nibWithName:(NSString *)name;

// 在 StoryBoard 或者 XIB 里复用另外一个 XIB
- (void)loadFromNib;

+ (instancetype)loadFromNib;
+ (instancetype)loadFromNib:(NSString *)nibName;
+ (instancetype)loadFromNibWithFrame:(CGRect)frame;

- (void)customize;

@end