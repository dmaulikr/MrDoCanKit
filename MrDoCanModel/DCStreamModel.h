//
//  DCStreamModel.h
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCReadModel.h"

/**
 *  获取数据回调 Block
 *
 *  @param error   错误信息，如果不为空，则说明出错
 */
typedef void (^DCStreamModelBlock)(id error);

@interface DCStreamModel :DCReadModel

/**
 *  是否还有更多数据，用于上拉加载更多等场景
 */
@property (nonatomic, assign) BOOL more;
@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic, strong) NSMutableArray * items;

/**
 *  获取数据回调 Block
 */
@property (nonatomic, copy) DCStreamModelBlock whenBack;

/**
 *  加载跟多数据
 */
- (void)loadMore;

@end