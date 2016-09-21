//
//  AlertView.m
//  MrDoCanView
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "AlertView.h"

@interface AlertView ()
@property (nonatomic, strong) UIButton * mask;
@property (nonatomic, strong) UIView<AlertContentView> * content;
@end

@implementation AlertView
- (void)dealloc
{
	
}

- (void)setViewYWithNumber:(NSInteger)number
{
	[UIView animateWithDuration:0.3 animations:^{
		self.content.y = number;
	}];
}

- (instancetype)initWithContent:(UIView<AlertContentView> *)content type:(AlertViewType)type;
{
	self = [super init];
	if (self) {
		CGRect bounds = [UIScreen mainScreen].bounds;
		self.frame = bounds;

		_mask = [[UIButton alloc] initWithFrame:bounds];
		_mask.alpha = 0.f;
		[_mask addTarget:self action:@selector(masked:) forControlEvents:UIControlEventTouchUpInside];
		_mask.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
		[self addSubview:_mask];

		if ( type == AlertViewTypeMonospaced )
		{
			CGRect contentFrame = content.frame;
			contentFrame.size.width = self.frame.size.width;
			content.frame = contentFrame;
		}

		_content = content;

		content.container = self;

		content.center = self.center;
		[self addSubview:content];
	}

	return self;
}

- (void)resetAnimation
{
	self.content.alpha = 0.f;
	self.content.top = self.height;
}

- (void)endAnimation
{
	self.content.alpha = 1.0f;
	self.content.center = self.center;
}

- (void)endSharedViewAnimation
{
	self.content.alpha = 1.f;
	self.content.top = self.height - self.content.size.height;
}

- (void)endModifyAnimation
{
	self.content.alpha = 1.f;
	CGPoint point = self.center;
	point.y = point.y - 40;
	self.content.center = point;
}

- (void)showIn:(UIView *)container
{
	[self resetAnimation];

	[container addSubview:self];
	[UIView animateWithDuration:0.55f delay:0.f usingSpringWithDamping:0.75 initialSpringVelocity:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
		self.mask.alpha = 1.f;
		[self endAnimation];
	} completion:^(BOOL finished) {
	}];
}

- (void)show
{
	[self showIn:[UIApplication sharedApplication].keyWindow];
}

// TODO:
- (void)showSharedViewIn:(UIView *)container
{
	[self resetAnimation];
	
	[container addSubview:self];
	[UIView animateWithDuration:0.55f delay:0.f usingSpringWithDamping:0.75 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
		self.mask.alpha = 1.f;
		[self endSharedViewAnimation];
	} completion:^(BOOL finished) {
	}];
}

- (void)showSharedView
{
	[self showSharedViewIn:[UIApplication sharedApplication].keyWindow];
}

// TODO:

- (void)showModifyViewIn:(UIView *)container
{
	[self resetAnimation];
	
	[container addSubview:self];
	[UIView animateWithDuration:0.55f delay:0.f usingSpringWithDamping:0.75 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
		self.mask.alpha = 1.f;
		[self endModifyAnimation];
	} completion:^(BOOL finished) {
	}];
}

- (void)hide
{
	[self hideWithCompetion:nil];
}

- (void)hideWithCompetion:(void (^)(BOOL))completion
{
	[UIView animateWithDuration:0.3f delay:0.f options:UIViewAnimationOptionCurveEaseIn animations:^{
		self.mask.alpha = 0.f;
		self.content.alpha = 0.f;
	} completion:^(BOOL finished) {
		[self removeFromSuperview];
        if ( completion )
        {
            completion(finished);
        }
        if ( self.content.whenHide )
        {
            self.content.whenHide(finished);
        }
	}];
}

- (void)masked:(id)sender
{
	[self hide];
}

@end
