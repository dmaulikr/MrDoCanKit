//
//  UIScrollView+DCRefreshHeader.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/9/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCHeaderProtocol <NSObject>

- (void)stop;
- (void)start;
- (void)dragging:(CGFloat)delVaule;
- (void)willShow:(UIScrollView *)scrollView;
@optional
- (void)saveLastRefreshTime:(NSDate *)date;
- (void)changeViewLastRefreshTime;
@end


@interface UIScrollView (DCRefreshHeader)

@property (strong, nonatomic) UIView<DCHeaderProtocol> *dc_headerView;

@end
