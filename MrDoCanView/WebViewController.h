//
//  WebViewController.h
//  FenHongForIOS
//
//  Created by 王灿 on 16/4/19.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DCWebViewController.h"

/*
 * Example:
 *
 * // 打开百度
 * [WebViewController openURL:@"http://baidu.com" in:vc];
 *
 * // 打开百度，页面 title 为 标题
 * [WebViewController openURL:@"http://baidu.com" in:vc title:@"标题"];
 *
 * // 打开百度，页面 title 为 标题，同时显示 底部操作栏
 * [WebViewController openURL:@"http://baidu.com" in:vc title:@"标题" toolbarHidden:NO];
 *
 * // 最大限度自定
 * [WebViewController openURL:@"http://baidu.com" in:vc beforePushing:^(DCWebViewController *vc) {
 *      // Push 之前的时机，比如：
 *      vc.hidesBottomBarWhenPushed = YES;
 * }];
 *
 */

@interface WebViewController : NSObject

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc;
+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc title:(NSString *)title;
+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc title:(NSString *)title toolbarHidden:(BOOL)toolbarHidden;

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc beforePushing:(void (^)(UIViewController * vc))beforePushing;
+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc toolbarHidden:(BOOL)toolbarHidden beforePushing:(void (^)(UIViewController * vc))beforePushing;

@end
