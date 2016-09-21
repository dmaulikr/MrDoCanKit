//
//  WebViewController.m
///  FenHongForIOS
//
//  Created by 王灿 on 16/4/19.
//  Copyright © 2016年 GuoXinTech. All rights reserved.
//

#import "WebViewController.h"


@implementation WebViewController

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc
{
    return [self openURL:url in:vc title:nil toolbarHidden:YES];
}

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc title:(NSString *)title
{
	return [self openURL:url in:vc title:title toolbarHidden:YES];
}

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc title:(NSString *)title toolbarHidden:(BOOL)toolbarHidden
{
    DCWebViewController * viewController = (DCWebViewController *)[self openURL:url in:vc beforePushing:nil];
    viewController.title = title;
    viewController.toolbarHidden = toolbarHidden;
    return viewController;
}

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc beforePushing:(void (^)(UIViewController * vc))beforePushing
{
    return [self openURL:url in:vc toolbarHidden:YES beforePushing:beforePushing];
}

+ (UIViewController *)openURL:(NSString *)url in:(UIViewController *)vc toolbarHidden:(BOOL)toolbarHidden beforePushing:(void (^)(UIViewController * vc))beforePushing;
{
	if ( nil == url )
    {
        [[[UIAlertView alloc] initWithTitle:@"提醒" message:@"无法打开网页链接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

        return nil;
    }

	if ( NO == [url hasPrefix:@"http://"] && NO == [url hasPrefix:@"https://"] )
	{
		url = [NSString stringWithFormat:@"http://%@", url];
	}

	NSArray * cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];

	for ( NSHTTPCookie * cookie in cookies )
	{
		[[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
	}

	DCWebViewController * webViewController = [[DCWebViewController alloc] init];

    if ( beforePushing ) {
        beforePushing(webViewController);
    }

	[webViewController.webView loadURL:[NSURL URLWithString:url]];

	webViewController.toolbarHidden = toolbarHidden;
	webViewController.hidesBottomBarWhenPushed = YES;
	
	[vc.navigationController pushViewController:webViewController animated:YES];
    
    return webViewController;
}

@end
