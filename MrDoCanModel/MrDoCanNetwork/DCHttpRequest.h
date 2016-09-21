//
//  DCHttpRequest.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/3/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface DCHttpRequest : NSObject

@property (readonly, nonatomic) Class httpResponseClass;
@property (strong, nonatomic) JSONModel *parameter;
@property (strong, nonatomic) AFHTTPRequestOperation *operation;

@end
