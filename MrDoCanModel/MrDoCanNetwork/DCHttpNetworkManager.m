//
//  DCHttpNetworkManager.m
//  FenHongForIOS
//
//  Created by 王灿 on 3/3/16.
//  Copyright © 2016 GuoXinTech. All rights reserved.
//

#import "AFNetworking.h"
#import "DCHttpNetworkManager.h"

@implementation DCHttpNetworkManager

- (void)sendHttpPostWithURL:(NSString *)urlString request:(DCHttpRequest *)httpRequest outTime:(CGFloat)outTime httpBack:(void (^)(DCHttpResponse *))httpBack
{
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    
    manager.securityPolicy = securityPolicy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    DCHttpResponse *httpResponse = [[httpRequest.httpResponseClass alloc] init];
    
    __block BOOL isBack = NO;
    
    httpRequest.operation = [manager POST:urlString parameters:[httpRequest.parameter toDictionary] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        isBack = YES;
        if ( httpBack)
        {
            httpResponse.data = [httpResponse resolveData:responseObject];
            httpBack(httpResponse);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ( httpBack )
        {
            httpResponse.error = @"接口调用失败";
            httpBack(httpResponse);
        }
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(outTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ( !isBack )
        {
            httpResponse.error = @"请求超时";
            [httpRequest.operation cancel];
            if ( httpBack )
            {
                httpBack(httpResponse); 
            }
        }
    });
    
}

- (void)sendHttpGetWithURL:(NSString *)urlString request:(DCHttpRequest *)httpRequest outTime:(CGFloat)outTime httpBack:(void (^)(DCHttpResponse *))httpBack
{
    NSURL *url = [NSURL URLWithString:urlString];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    securityPolicy.allowInvalidCertificates = YES;
    securityPolicy.validatesDomainName = NO;
    
    manager.securityPolicy = securityPolicy;
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    DCHttpResponse *httpResponse = [[DCHttpResponse alloc] init];
    
    __block BOOL isBack = NO;
    
    httpRequest.operation = [manager GET:urlString parameters:[httpRequest.parameter toDictionary] success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        isBack = YES;
        if ( httpBack)
        {
            httpResponse.data = responseObject;
            httpBack(httpResponse);
        }
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        isBack = YES;
        if ( httpBack )
        {
            httpResponse.error = [error localizedDescription];
            httpBack(httpResponse);
        }
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(outTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if ( !isBack )
        {
            httpResponse.error = @"请求超时";
            [httpRequest.operation cancel];
            httpBack(httpResponse);
        }
    });
}

@end
