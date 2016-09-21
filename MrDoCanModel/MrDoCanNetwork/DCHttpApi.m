//
//  DCHttpApi.m
//  FenHongForIOS
//
//  Created by 王灿 on 3/3/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import "DCHttpApi.h"

@implementation DCHttpApi

- (void)send
{
    [self.httpNetworkManager sendHttpPostWithURL:self.httpUrlString request:self.httpRequest outTime:self.outTime httpBack:^(DCHttpResponse *httpResponse) 
    {
        if ( self.whenHttpBack )
        {
            self.whenHttpBack(httpResponse);
        }
    }];
}

- (void)sendGet
{
    [self.httpNetworkManager sendHttpGetWithURL:self.httpUrlString request:self.httpRequest outTime:self.outTime httpBack:^(DCHttpResponse *httpResponse)
    {
        if ( self.whenHttpBack )
        {
            self.whenHttpBack(httpResponse);
        }
        
    }];
}

- (DCHttpNetworkManager *)httpNetworkManager
{
    if ( !_httpNetworkManager )
    {
        _httpNetworkManager = [[DCHttpNetworkManager alloc] init];
    }
    return _httpNetworkManager;
}

- (CGFloat)outTime
{
    if ( !_outTime )
    {
        _outTime = 2000.0;
    }
    return _outTime;
}
@end
