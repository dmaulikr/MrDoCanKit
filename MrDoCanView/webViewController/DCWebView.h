//
//  DCWebView.h
//  MrDoCanView
//
//  Created by 王灿 on 2/8/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DCWebViewDelegate;

@interface DCWebView : UIView <UIWebViewDelegate>

@property (nonatomic, assign) BOOL shadowsHidden;

@property (nonatomic, assign) id<DCWebViewDelegate> delegate;


- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)encodingName baseURL:(NSURL *)baseURL;

- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL;

- (void)loadRequest:(NSURLRequest *)aRequest;

- (void)loadHTMLString:(NSString *)string;

- (void)loadURL:(NSURL *)aURL;

- (void)loadURLString:(NSString *)string;

@property (nonatomic, strong, readonly) NSURLRequest *request;

@property (nonatomic, strong, readonly) NSURLRequest *lastRequest;

@property (nonatomic, readonly, getter=isLoading) BOOL loading;

@property (nonatomic, readonly, getter=isLoadingPage) BOOL loadingPage;

- (void)stopLoading;

- (void)reload;

@property (nonatomic, readonly) BOOL canGoBack;

@property (nonatomic, readonly) BOOL canGoForward;

- (void)goBack;

- (void)goForward;

@property (nonatomic, assign) BOOL scalesPageToFit;

@property (nonatomic, strong, readonly) UIScrollView *scrollView;

- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;

@property (nonatomic, assign) BOOL consoleEnabled;

@property (nonatomic, assign) UIDataDetectorTypes dataDetectorTypes;

@property (nonatomic, assign) BOOL allowsInlineMediaPlayback;

@property (nonatomic, assign) BOOL mediaPlaybackRequiresUserAction;

- (void)dismissKeyboard;

- (void)removeTextSelection;

- (void)reset;

@end


@protocol DCWebViewDelegate <NSObject>

@optional

- (void)webViewDidStartLoadingPage:(DCWebView *)aWebView;

- (void)webViewDidLoadDOM:(DCWebView *)aWebView;

- (void)webViewDidFinishLoadingPage:(DCWebView *)aWebView;

- (void)webView:(DCWebView *)aWebView didFailLoadWithError:(NSError *)error;

- (BOOL)webView:(DCWebView *)aWebView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType;

- (void)webViewDidFinishLoad:(DCWebView *)aWebView;

- (void)webViewDidStartLoad:(DCWebView *)aWebView;

@end
