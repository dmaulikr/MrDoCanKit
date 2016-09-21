//
//  WCRollPlayView.m
//  WCRollPlay
//
//  Created by wangcan on 15/12/5.
//  Copyright © 2015年 wangcan. All rights reserved.
//

#import "WCRollPlayView.h"

@interface WCRollPlayView()

@property (nonatomic,strong) NSArray *allPointArr;

@property (nonatomic,assign) NSInteger  number;

@property (nonatomic,assign) NSInteger  oldIndex;

@property (nonatomic,strong) UIColor *pointColor;

@property (nonatomic,strong) UIColor  *currentPointColor;

@property (nonatomic,assign) NSInteger  currentPointAspectRatio;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation WCRollPlayView


-(void)drawRect:(CGRect)rect
{
    if (self.havaPoint)
    {
        [self showPointWithFrame:self.frame pointCount:self.number pointColor:self.pointColor currentPointColor:self.currentPointColor currentIndex:0];
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    [self setup];
}
-(void)setup
{
    iCarousel *carouselView = [[iCarousel alloc]initWithFrame:self.bounds];
    _carouselView =carouselView;
    _carouselView.delegate = self;
    _carouselView.dataSource = self;
    _carouselView.pagingEnabled = YES;
    [self addSubview:_carouselView];
    _carouselView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _currentPointColor = [AppTheme  mainColor];
    _pointColor = [UIColor colorWithRGBValue:0xd8d8d8];
    _oldIndex = 0;
    if ( !_interval )
    {
        _interval = 6.0;
    }
    _currentPointAspectRatio = 1.5;
}


- (void)reloadData
{
    [self removeTimer];
    _number = [self.dataSource numberOfItemsInRollPlay:self];
    [_carouselView reloadData];
    [self setNeedsDisplay];
    [self addTimer];
}

#pragma -mark iCarouselDataSource
-(NSInteger )numberOfItemsInCarousel:(iCarousel *)carousel
{
    return _number;
}

-(UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    if ([self.dataSource respondsToSelector:@selector(rollPlay:itemAtIndex:)])
    {
        return [self.dataSource rollPlay:self itemAtIndex:index];
    }
    return nil;
}

#pragma -mark iCarouselDelegate

- (void)carouselDidScroll:(iCarousel *)carousel
{
    //视图拖动过程中操作
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel
{
    [self removeTimer];
}

- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel
{
    [self pointChangeWithOldPointIndex:self.oldIndex currentIndex:self.carouselView.currentItemIndex];
    self.oldIndex = self.carouselView.currentItemIndex;
    if ( [self.delegate respondsToSelector:@selector(rollPlay:didWillChangeOldIndex:currentIndex:)] )
    {
        [self.delegate rollPlay:self didWillChangeOldIndex:self.oldIndex currentIndex:self.carouselView.currentItemIndex];
    }
    
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionWrap)
    {
        return 1;
    }
    return value;
}

-(void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    if ([self.delegate  respondsToSelector:@selector(rollPlay:didSelectItemIndex:)]) {
        [self.delegate rollPlay:self didSelectItemIndex:index];
    }
}
#pragma -mark autoRollPlay 

-(void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:self.interval target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop]addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)removeTimer
{
    [self.timer invalidate];
}

- (void)nextImage
{
    NSInteger i = self.carouselView.currentItemIndex +1;
    if (i == _allPointArr.count )
    {
        i = 0;
    }
    [self.carouselView scrollToItemAtIndex:i animated:YES];
}

#pragma -mark rollPalyShowPoint

-(void)showPointWithFrame:(CGRect)frame pointCount:(NSInteger)count pointColor:(UIColor *)color currentPointColor:(UIColor*)currentColor currentIndex:(NSInteger)currentIndex
{
    if (!self.allPointArr)
    {
        if (count >0)
        {
            CGFloat r2 = frame.size.width/100;
            CGFloat y = frame.size.height -3*r2;
            CGFloat fx = (frame.size.width - r2*(2*count-1+count))/2;
            NSMutableArray *mArray = [NSMutableArray array];
            for (int i = 0; i<count; i++)
            {
                CGFloat x = fx + i*3*r2;
                UIView *view =[[UIView alloc]initWithFrame:CGRectMake(x, y, r2, r2)];
                view.layer.masksToBounds = YES;
                view.layer.cornerRadius =r2/2.0;
                if (i == currentIndex)
                {
                    view.backgroundColor = currentColor;
                }
                else
                {
                    view.backgroundColor = color;
                }
                [mArray addObject:view];
                [self addSubview:view];
            }
            self.allPointArr = mArray;
        }
    }
    
}
-(void)pointChangeWithOldPointIndex:(NSInteger)oldIndex currentIndex:(NSInteger)currentIndex
{
    if (self.havaPoint && oldIndex!=currentIndex&&oldIndex >=0)
    {
        UIView *oldView = self.allPointArr[oldIndex];
        oldView.backgroundColor = self.pointColor;
        UIView *currentView = self.allPointArr[currentIndex];
        currentView.backgroundColor = self.currentPointColor;
    }
}
-(void)rollPlayTimerStop
{
    [self removeTimer];
}
-(void)rollPlayTimerStar
{
    [self addTimer];
}
@end
