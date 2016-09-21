//
//  UIView+Nib.m
//  MrDoCanKit
//
//  Created by 王灿 on 1/6/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "UIView+Nib.h"

@implementation UIView (Nib)

+ (UINib *)nib
{
    return [self nibWithName:NSStringFromClass([self class])];
}

+ (UINib *)nibWithName:(NSString *)name
{
    return [UINib nibWithNibName:name bundle:[NSBundle mainBundle]];
}

+ (instancetype)loadFromNib
{
    return [self loadFromNib:NSStringFromClass([self class])];
}

+ (instancetype)loadFromNib:(NSString *)nibName
{
    return [[[self nibWithName:nibName] instantiateWithOwner:nil options:nil] firstObject];
}

+ (instancetype)loadFromNibWithFrame:(CGRect)frame
{
    UIView * nibView = [self loadFromNib];
    nibView.frame = frame;
    return nibView;
}

- (void)loadFromNib
{
    UIView * shadow = [[[[self class] nib] instantiateWithOwner:self options:nil] firstObject];
    
    [self addSubview:shadow];
    
}

- (void)customize
{
    
}

@end
