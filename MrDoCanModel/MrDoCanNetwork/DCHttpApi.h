//
//  DCHttpApi.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/3/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCHttpNetworkManager.h"
#import "DCHttpRequest.h"
#import "DCHttpResponse.h"

@interface DCHttpApi : NSObject
@property (strong, nonatomic) DCHttpNetworkManager *httpNetworkManager;
@property (strong, nonatomic) DCHttpRequest *httpRequest;
@property (strong, nonatomic) NSString *httpUrlString;
@property (assign, nonatomic) CGFloat outTime;

@property (copy, nonatomic) void (^whenHttpBack)(DCHttpResponse *httpResponse);

- (void)send;
- (void)sendGet;

@end
