//
//  MJRefreshHeader+DCRefreshHeader.m
//  FenHongForIOS
//
//  Created by 王灿 on 3/9/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import "MJRefreshHeader+DCRefreshHeader.h"

@implementation MJRefreshHeader (DCRefreshHeader)

- (void)beginRefreshing
{
    if ( self.scrollView.dc_headerView )
    {
        if ( [self.scrollView.dc_headerView respondsToSelector:@selector(changeViewLastRefreshTime)] )
        {
            [self.scrollView.dc_headerView changeViewLastRefreshTime];
        }
        [self.scrollView.dc_headerView start];
    }
    [super beginRefreshing];
}

- (void)endRefreshing
{
    [super endRefreshing];
    if ( self.scrollView.dc_headerView )
    {
        if ( [self.scrollView.dc_headerView respondsToSelector:@selector(saveLastRefreshTime:)])
        {
            [self.scrollView.dc_headerView saveLastRefreshTime:self.lastUpdatedTime];
        }
        [self.scrollView.dc_headerView stop];
    }
}

- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];

    [self.scrollView.dc_headerView dragging:pullingPercent];
}
@end
