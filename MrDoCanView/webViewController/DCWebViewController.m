//
//  DCWebViewController.m
//  MrDoCanView
//
//  Created by 王灿 on 2/8/16.
//  Copyright © 2016 MrDoCan. All rights reserved.
//

#import "DCWebViewController.h"

#import <MessageUI/MessageUI.h>

@interface DCWebViewController () <UIActionSheetDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, readonly) UIActivityIndicatorView *indicatorView;
@property (nonatomic, readonly) UIBarButtonItem *backBarButtonItem;
@property (nonatomic, readonly) UIBarButtonItem *forwardBarButtonItem;
@property (nonatomic, strong) NSString * titleString;

@end

@implementation DCWebViewController

@synthesize webView = _webView;
@synthesize toolbarHidden = _toolbarHidden;
@synthesize indicatorView = _indicatorView;
@synthesize backBarButtonItem = _backBarButtonItem;
@synthesize forwardBarButtonItem = _forwardBarButtonItem;

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    
    if ( !self.isViewLoaded && title )
    {
        self.titleString = title;
    }
}

- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 22.0f, 22.0f)];
        _indicatorView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _indicatorView.hidesWhenStopped = YES;
    }
    return _indicatorView;
}

- (UIBarButtonItem *)backBarButtonItem {
    if (!_backBarButtonItem) {
        _backBarButtonItem = [[UIBarButtonItem alloc]
                              initWithImage:[UIImage imageNamed:@"webview_forward_up"]
                              landscapeImagePhone:[UIImage imageNamed:@"webview_forward_up"]
                              style:UIBarButtonItemStylePlain
                              target:self.webView
                              action:@selector(goBack)];
    }
    return _backBarButtonItem;
}

- (UIBarButtonItem *)forwardBarButtonItem {
    if (!_forwardBarButtonItem) {
        _forwardBarButtonItem = [[UIBarButtonItem alloc]
                                 initWithImage:[UIImage imageNamed:@"webview_back_up"]
                                 landscapeImagePhone:[UIImage imageNamed:@"webview_back_up"]
                                 style:UIBarButtonItemStylePlain
                                 target:self.webView
                                 action:@selector(goForward)];
    }
    return _forwardBarButtonItem;
}

#pragma mark - NSObject

- (id)init {
    if ((self = [super init])) {
        self.toolbarHidden = NO;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    __weak typeof( self ) weakSelf = self;
    self.navigationItem.leftBarButtonItems = @[[AppTheme backItemWithHandler:^(id sender) {
        
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }], [AppTheme itemWithContent:@"" handler:nil]];
    
    if ( !self.navigationItem.rightBarButtonItem ) {
        UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.indicatorView];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStylePlain target:self action:@selector(close:)];
    }
    
    self.webView.frame = self.view.bounds;
    [self.view addSubview:self.webView];
    [self setupToolbar2];
}

- (void)setupToolbar2
{
    UIBarButtonItem * popBarButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back_up"] landscapeImagePhone:[UIImage imageNamed:@"back_up"] style:UIBarButtonItemStylePlain target:self action:@selector(isGoBack)];
    
    UIBarButtonItem * refreshBarButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"webview_forward_up"] landscapeImagePhone:[UIImage imageNamed:@"webview_forward_up"] style:UIBarButtonItemStylePlain target:self.webView action:@selector(goBack)];
    
    UIBarButtonItem *reloadBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"webview_refresh_up"] landscapeImagePhone:[UIImage imageNamed:@"webview_refresh_up"] style:UIBarButtonItemStylePlain target:self.webView action:@selector(reload)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    self.toolbarItems = @[flexibleSpace, popBarButton, flexibleSpace, refreshBarButton,flexibleSpace, reloadBarButtonItem, flexibleSpace];
}

- (void)isGoBack
{
    if ( self.webView.canGoBack )
    {
        [self.webView goBack];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)setupToolbar1
{
    // Toolbar buttons
    
    UIBarButtonItem *popBarButtonItem = [[UIBarButtonItem alloc]
                                         initWithImage:[UIImage imageNamed:@"back_up"]
                                         landscapeImagePhone:[UIImage imageNamed:@"back_up"]
                                         style:UIBarButtonItemStylePlain
                                         target:self
                                         action:@selector(close:)];
    
    UIBarButtonItem *reloadBarButtonItem = [[UIBarButtonItem alloc]
                                            initWithImage:[UIImage imageNamed:@"webview_refresh_up"]
                                            landscapeImagePhone:[UIImage imageNamed:@"webview_refresh_up"]
                                            style:UIBarButtonItemStylePlain
                                            target:self.webView
                                            action:@selector(reload)];
    
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                   target:nil action:nil];
    fixedSpace.width = 10.0;
    
    self.toolbarItems = @[fixedSpace, popBarButtonItem, flexibleSpace, self.backBarButtonItem, flexibleSpace, self.forwardBarButtonItem, flexibleSpace,
                          reloadBarButtonItem, flexibleSpace];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (!self.toolbarHidden && ![self.currentURL isFileURL])
    {
        [self.navigationController setToolbarHidden:NO animated:animated];
        //修改****Bar背景颜色*****
        [self.navigationController.toolbar setTintColor:[UIColor whiteColor]];
        self.navigationController.toolbar.backgroundColor = [UIColor blackColor];
    }
    
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (!self.toolbarHidden)
    {
        [self.navigationController setToolbarHidden:YES animated:animated];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return YES;
    }
    
    return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
}

#pragma mark - URL Loading

- (NSURL *)currentURL
{
    return [self.webView.lastRequest mainDocumentURL];
}

#pragma mark - Accessors

- (DCWebView *)webView
{
    if (_webView == nil)
    {
        _webView = [[DCWebView alloc] init];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        _webView.delegate = self;
        _webView.scalesPageToFit = YES;
    }
    return _webView;
}


#pragma mark - Actions

- (void)close:(id)sender
{
    int n = (int)[self.navigationController.childViewControllers count];
    if (n>1)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)openSafari:(id)sender {
    [[UIApplication sharedApplication] openURL:self.currentURL];
    
}

- (void)openActionSheet:(id)sender
{
    UIActionSheet *actionSheet = nil;
    
    if (![MFMailComposeViewController canSendMail])
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy URL", nil];
    }
    else
    {
        actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Copy URL", @"Email URL", nil];
    }
    
    if (self.navigationController)
    {
        actionSheet.actionSheetStyle = (UIActionSheetStyle)self.navigationController.navigationBar.barStyle;
    }
    
    [actionSheet showInView:self.navigationController.view];
}


- (void)copyURL:(id)sender
{
    [[UIPasteboard generalPasteboard] setURL:self.currentURL];
}


- (void)emailURL:(id)sender
{
    if (![MFMailComposeViewController canSendMail])
    {
        return;
    }
    
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.subject = self.title;
    controller.mailComposeDelegate = self;
    [controller setMessageBody:self.webView.lastRequest.mainDocumentURL.absoluteString isHTML:NO];
    
    [self presentViewController:controller animated:YES completion:nil];
}


#pragma mark - Private

- (void)updateBrowserUI
{
    self.backBarButtonItem.enabled = [self.webView canGoBack];
    self.forwardBarButtonItem.enabled = [self.webView canGoForward];
    
    UIBarButtonItem *reloadButton = nil;
    
    if ([self.webView isLoadingPage])
    {
        [self.indicatorView startAnimating];
        reloadButton = [[UIBarButtonItem alloc]
                        initWithImage:[UIImage imageNamed:@"close_up"]
                        landscapeImagePhone:[UIImage imageNamed:@"close_up"]
                        style:UIBarButtonItemStylePlain
                        target:self.webView
                        action:@selector(stopLoading)];
    }
    else
    {
        [self.indicatorView stopAnimating];
        reloadButton = [[UIBarButtonItem alloc]
                        initWithImage:[UIImage imageNamed:@""]
                        landscapeImagePhone:[UIImage imageNamed:@""]
                        style:UIBarButtonItemStylePlain
                        target:self.webView
                        action:@selector(reload)];
    }
    
    NSMutableArray *items = [self.toolbarItems mutableCopy];
    //    [items replaceObjectAtIndex:7 withObject:reloadButton];
    self.toolbarItems = items;
}


#pragma mark - SAMWebViewDelegate

- (void)webViewDidStartLoadingPage:(DCWebView *)webView
{
    NSURL *URL = self.currentURL;
    
    //	if ( !self.title )
    //	{
    //		self.title = URL.absoluteString;
    //	}
    
    [self updateBrowserUI];
    
    if (!self.toolbarHidden)
    {
        [self.navigationController setToolbarHidden:[URL isFileURL] animated:YES];
    }
}

- (void)webViewDidFinishLoadingPage:(DCWebView *)webView
{
    [self updateBrowserUI];
    
    if ( !self.titleString )
    {
        NSString *title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
        
        if ([title length] > 0)
        {
            self.title = title;
        }
    }
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        [self copyURL:actionSheet];
    }
    else if (buttonIndex == 1)
    {
        [self emailURL:actionSheet];
    }
}

#pragma mark - MFMailComposeViewControllerDelegate

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
