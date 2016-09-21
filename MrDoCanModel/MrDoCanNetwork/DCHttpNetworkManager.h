//
//  DCHttpNetworkManager.h
//  FenHongForIOS
//
//  Created by 王灿 on 3/3/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DCHttpRequest;
@class DCHttpResponse;


@interface DCHttpNetworkManager : NSObject


- (void)sendHttpPostWithURL:(NSString *)urlString request:(DCHttpRequest *)httpRequest outTime:(CGFloat)outTime httpBack:(void (^)(DCHttpResponse *httpResponse))httpBack ;
- (void)sendHttpGetWithURL:(NSString *)urlString request:(DCHttpRequest *)httpRequest outTime:(CGFloat)outTime httpBack:(void (^)(DCHttpResponse * httpResponse))httpBack;

@end

