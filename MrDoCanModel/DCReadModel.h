//
//  DCReadModel.h
//  MrDoCanModel
//
//  Created by 王灿 on 1/2/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCModel.h"

@interface DCReadModel : DCModel

/**
 *  是否加从数据源获取过数据，请求网络成功后设置为YES
 */
@property (nonatomic, assign) BOOL loaded;

/**
 *  数据是否为空
 *
 *  条件：无数据
 */
@property (nonatomic, assign, readonly) BOOL isEmpty;

/**
 *  刷新数据
 */
- (void)refresh;

@end