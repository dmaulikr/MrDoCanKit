//
//  WCRollPlayView.h
//  WCRollPlay
//
//  Created by wangcan on 15/12/5.
//  Copyright © 2015年 wangcan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iCarousel.h"

@class WCRollPlayView;

@protocol WCRollPlayViewDelegate, WCRollPlayViewDataSource;

@interface WCRollPlayView : UIView<iCarouselDataSource,iCarouselDelegate>

@property (nonatomic,strong) iCarousel *carouselView;

@property (nonatomic,assign) CGFloat interval; //设置轮播图的时间间隔

@property (nonatomic,assign) BOOL  havaPoint;//是否拥有pageControl

@property (nonatomic,weak) id<WCRollPlayViewDelegate> delegate;

@property (nonatomic,weak) id<WCRollPlayViewDataSource> dataSource;

//刷新轮播图数据方法
- (void)reloadData;
//轮播图停止方法
- (void)rollPlayTimerStop;
//轮播图开始方法
- (void)rollPlayTimerStar;

@end

@protocol WCRollPlayViewDataSource <NSObject>

//返回轮播图的个数
- (NSInteger)numberOfItemsInRollPlay:(WCRollPlayView *)rollPlayView;
//返回轮播的视图
- (UIView *)rollPlay:(WCRollPlayView *)rollPlay itemAtIndex:(NSInteger)index;
@optional

@end

@protocol WCRollPlayViewDelegate <NSObject>

@optional

//轮播视图发当前视图发生改变的时候调用的方法
- (void)rollPlay:(WCRollPlayView *)rollPlay didWillChangeOldIndex:(NSInteger)oldIndex currentIndex:(NSInteger)index;
//轮播图被点击事件发生的方法
- (void)rollPlay:(WCRollPlayView *)rollPlay didSelectItemIndex:(NSInteger)index;

@end