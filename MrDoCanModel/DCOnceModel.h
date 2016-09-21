//
//  DCOnceModel.h
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCReadModel.h"

/**
 *  获取数据回调 Block
 *
 *  @param data    新增数据，如果获取整个列表，可以
 *  @param changed 数据是否与上次一样
 *  @param error   错误信息，如果不为空，则说明出错
 */
//typedef void (^DCOnceModelBlock)(id data, BOOL changed, id error);
typedef void (^DCOnceModelBlock)( id error);

/**
 *  用于拉取不需要分页的数据，比如：详情等
 */
@interface DCOnceModel : DCReadModel

@property (nonatomic, strong) id item;

/**
 *  获取数据回调 Block
 */
@property (nonatomic, copy) DCOnceModelBlock whenBack;

@end