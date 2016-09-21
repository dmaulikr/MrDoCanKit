//
//  DCWebViewController.h
//  MrDoCanView
//
//  Created by 王灿 on 2/8/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DCWebView.h"

@interface DCWebViewController : UIViewController <DCWebViewDelegate>

@property (nonatomic, assign) BOOL toolbarHidden;
@property (nonatomic, readonly) DCWebView *webView;
@property (nonatomic, readonly) NSURL *currentURL;

@end