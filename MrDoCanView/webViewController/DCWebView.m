//
//  DCWebView.m
//  MrDoCanView
//
//  Created by 王灿 on 2/8/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCWebView.h"

@interface DCWebView ()
@property (nonatomic, assign, readwrite, getter=isLoadingPage) BOOL loadingPage;
@property (nonatomic, strong, readwrite) NSURLRequest *lastRequest;

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, assign) NSUInteger requestCount;
@property (nonatomic, assign) BOOL testedDOM;
@end

@implementation DCWebView

@synthesize delegate = _delegate;
@synthesize consoleEnabled = _consoleEnabled;
@synthesize lastRequest = _lastRequest;
@synthesize loadingPage = _loadingPage;
@synthesize shadowsHidden = _shadowsHidden;
@synthesize webView = _webView;
@synthesize requestCount = _requestCount;
@synthesize testedDOM = _testedDOM;


#pragma mark - NSObject

- (void)dealloc
{
    self.delegate = nil;
    self.webView.delegate = nil;
    [self.webView stopLoading];
}


#pragma mark - UIView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder]))
    {
        [self initialize];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        [self initialize];
    }
    return self;
}


- (void)layoutSubviews
{
    self.webView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
}


#pragma mark - SAMWebView Methods

- (void)dismissKeyboard
{
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.activeElement.blur()"];
}


- (void)removeTextSelection
{
    if (self.webView.userInteractionEnabled == NO)
    {
        return;
    }
    
    self.webView.userInteractionEnabled = NO;
    self.webView.userInteractionEnabled = YES;
}


- (void)reset
{
    [self clearCache];
    
    BOOL loadPreviousSettings = NO;
    UIDataDetectorTypes tempDataDetectorTypes;
    BOOL tempScalesPageToFit = NO;
    BOOL tempAllowsInlineMediaPlayback = NO;
    BOOL tempMediaPlaybackRequiresUserAction = NO;
    
    if (self.webView)
    {
        self.webView.delegate = nil;
        [self.webView stopLoading];
        
        loadPreviousSettings = YES;
        tempDataDetectorTypes = self.webView.dataDetectorTypes;
        tempScalesPageToFit = self.webView.scalesPageToFit;
        tempAllowsInlineMediaPlayback = self.webView.allowsInlineMediaPlayback;
        tempMediaPlaybackRequiresUserAction = self.webView.mediaPlaybackRequiresUserAction;
        
        [self.webView removeFromSuperview];
    }
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    self.webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    if (loadPreviousSettings)
    {
        self.webView.dataDetectorTypes = tempDataDetectorTypes;
        self.webView.scalesPageToFit = tempScalesPageToFit;
        self.webView.allowsInlineMediaPlayback = tempAllowsInlineMediaPlayback;
        self.webView.mediaPlaybackRequiresUserAction = tempMediaPlaybackRequiresUserAction;
    }
    
    self.webView.delegate = self;
    [self addSubview:self.webView];
    
    self.lastRequest = nil;
}


#pragma mark - Convenience Methods

- (void)loadHTMLString:(NSString *)string
{
    [self loadHTMLString:string baseURL:nil];
}


- (void)loadURL:(NSURL *)aURL
{
    [self loadRequest:[NSURLRequest requestWithURL:aURL]];
}


- (void)loadURLString:(NSString *)string
{
    if ([string length] < 5)
    {
        return;
    }
    
    if ([string hasPrefix:@"http://"] == NO && [string hasPrefix:@"https://"] == NO)
    {
        string = [NSString stringWithFormat:@"http://%@", string];
    }
    [self loadURL:[NSURL URLWithString:string]];
}


#pragma mark - Private Methods

- (void)initialize
{
    [self reset];
    
    self.loadingPage = NO;
    self.shadowsHidden = NO;
    self.consoleEnabled = NO;
}


- (void)loadingStatusChanged
{
    if (self.loading == NO)
    {
        [self finishedLoading];
    }
}

- (void)startLoading
{
    self.loadingPage = YES;
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoadingPage:)])
    {
        [self.delegate webViewDidStartLoadingPage:self];
    }
}

- (void)finishedLoading
{
    self.loadingPage = NO;
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoadingPage:)])
    {
        [self.delegate webViewDidFinishLoadingPage:self];
    }
}

- (void)DOMLoaded
{
    if ([self.delegate respondsToSelector:@selector(webViewDidLoadDOM:)])
    {
        [self.delegate webViewDidLoadDOM:self];
    }
}


#pragma mark - Getters

- (BOOL)shadowsHidden {
    for (UIView *view in [self.webView subviews])
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            for (UIView *innerView in [view subviews])
            {
                if ([innerView isKindOfClass:[UIImageView class]])
                {
                    return [innerView isHidden];
                }
            }
        }
    }
    return NO;
}

#pragma mark - Setters

- (void)setOpaque:(BOOL)o
{
    [super setOpaque:o];
    self.webView.opaque = o;
}


- (void)setBackgroundColor:(UIColor *)color
{
    [super setBackgroundColor:color];
    self.webView.backgroundColor = color;
}


- (void)setShadowsHidden:(BOOL)hide
{
    if (_shadowsHidden == hide)
    {
        return;
    }
    
    _shadowsHidden = hide;
    
    for (UIView *view in [self.webView subviews])
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            for (UIView *innerView in [view subviews])
            {
                if ([innerView isKindOfClass:[UIImageView class]])
                {
                    innerView.hidden = _shadowsHidden;
                }
            }
        }
    }
}


#pragma mark - UIWebView Methods

- (BOOL)canGoBack
{
    return [self.webView canGoBack];
}


- (BOOL)canGoForward
{
    return [self.webView canGoForward];
}

- (void)setDataDetectorTypes:(UIDataDetectorTypes)types
{
    [self.webView setDataDetectorTypes:types];
}


- (UIDataDetectorTypes)dataDetectorTypes
{
    return [self.webView dataDetectorTypes];
}


- (BOOL)isLoading
{
    return [self.webView isLoading];
}


- (NSURLRequest *)request
{
    return [self.webView request];
}


- (BOOL)scalesPageToFit
{
    return [self.webView scalesPageToFit];
}


- (void)setScalesPageToFit:(BOOL)scales
{
    [self.webView setScalesPageToFit:scales];
}


- (void)goBack
{
    [self.webView goBack];
}

- (void)goForward
{
    [self.webView goForward];
}


- (void)loadData:(NSData *)data MIMEType:(NSString *)MIMEType textEncodingName:(NSString *)encodingName baseURL:(NSURL *)baseURL
{
    self.lastRequest = nil;
    
    [self.webView loadData:data MIMEType:MIMEType textEncodingName:encodingName baseURL:baseURL];
}


- (void)loadHTMLString:(NSString *)string baseURL:(NSURL *)baseURL
{
    self.lastRequest = nil;
    
    if (!baseURL)
    {
        baseURL = [NSURL URLWithString:@"http://localhost/"];
    }
    [self.webView loadHTMLString:string baseURL:baseURL];
}


- (void)loadRequest:(NSURLRequest *)aRequest
{
    self.lastRequest = nil;
    [self.webView loadRequest:aRequest];
}


- (void)reload
{
    self.lastRequest = nil;
    [self.webView reload];
}


- (void)stopLoading
{
    [self.webView stopLoading];
}


- (NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script
{
    return [self.webView stringByEvaluatingJavaScriptFromString:script];
}


- (UIScrollView *)scrollView
{
    if (([[[UIDevice currentDevice] systemVersion] compare:@"5.0"] == NSOrderedAscending))
    {
        for (UIView *view in [self.webView subviews])
        {
            if ([view isKindOfClass:[UIScrollView class]])
            {
                return (UIScrollView *)view;
            }
        }
        return nil;
    }
    else
    {
        return self.webView.scrollView;
    }
}


- (BOOL)allowsInlineMediaPlayback
{
    return self.webView.allowsInlineMediaPlayback;
}


- (void)setAllowsInlineMediaPlayback:(BOOL)allow
{
    self.webView.allowsInlineMediaPlayback = allow;
}


- (BOOL)mediaPlaybackRequiresUserAction
{
    return self.webView.mediaPlaybackRequiresUserAction;
}


- (void)setMediaPlaybackRequiresUserAction:(BOOL)requires
{
    self.webView.mediaPlaybackRequiresUserAction = requires;
}


#pragma mark - UIWebViewDelegate

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    if ([self.delegate respondsToSelector:@selector(webView:didFailLoadWithError:)])
    {
        [self.delegate webView:self didFailLoadWithError:error];
    }
    
    self.requestCount--;
    if (self.requestCount == 0)
    {
        [self loadingStatusChanged];
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)aRequest navigationType:(UIWebViewNavigationType)navigationType
{
    BOOL should = YES;
    NSURL *url = [aRequest URL];
    NSString *scheme = [url scheme];
    
    if ([scheme isEqualToString:@"x-sswebview"])
    {
        NSString *host = [url host];
        if ([host isEqualToString:@"dom-loaded"])
        {
            [self DOMLoaded];
        } else if ([host isEqualToString:@"log"] && self.consoleEnabled)
        {
            
        }
        return NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(webView:shouldStartLoadWithRequest:navigationType:)])
    {
        should = [self.delegate webView:self shouldStartLoadWithRequest:aRequest navigationType:navigationType];
    }
    
    else
    {
        should = [scheme isEqualToString:@"http"] || [scheme isEqualToString:@"https"] || [scheme isEqualToString:@"file"];
    }
    
    if (should == NO)
    {
        return NO;
    }
    
    if ([[aRequest mainDocumentURL] isEqual:[self.lastRequest mainDocumentURL]] == NO)
    {
        self.lastRequest = aRequest;
        self.testedDOM = NO;
        
        [self startLoading];
    }
    
    else
    {
//        [[self class] cancelPreviousPerformRequestsWithTarget:self selector:@selector(loadingStatusChanged) object:nil];
    }
    
    return should;
}


- (void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self clearCache];
    
    if ([self.delegate respondsToSelector:@selector(webViewDidFinishLoad:)])
    {
        [self.delegate webViewDidFinishLoad:self];
    }
    
    self.requestCount--;
    if (self.requestCount == 0)
    {
        [self loadingStatusChanged];
    }
    
    
}

#pragma mark - 清理缓存
- (void)clearCache
{
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.lastRequest];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache *sharedCache = [[NSURLCache alloc] initWithMemoryCapacity:0
                                                            diskCapacity:0
                                                                diskPath:nil];
    [NSURLCache setSharedURLCache:sharedCache];
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        [storage deleteCookie:cookie];
    }
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    if ([self.delegate respondsToSelector:@selector(webViewDidStartLoad:)])
    {
        [self.delegate webViewDidStartLoad:self];
    }
    self.requestCount++;
}

@end
