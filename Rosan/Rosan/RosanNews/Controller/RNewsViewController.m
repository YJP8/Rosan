//
//  RNewsViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RNewsViewController.h"

@interface RNewsViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *actIv;
@property (nonatomic, retain)UIView *loadingView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, copy)NSString *titleStr;
@property (nonatomic, strong)NSMutableURLRequest *request;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation RNewsViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯";
    _loadingView = [[UIView alloc] init];
    [self.view addSubview:self.loadingView];
    
    NSString *str = @"http://m.kxt.com/";
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:str];
    self.request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:5.0];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView loadRequest:self.request];
    
    for (UIView * views in [self.webView subviews]) {
        if ([views isKindOfClass:[UIScrollView class]]) {
            [(UIScrollView *)views setShowsHorizontalScrollIndicator:NO];
            [(UIScrollView *)views setShowsVerticalScrollIndicator:NO];
            for (UIView * inScrollView in views.subviews) {
                if ([inScrollView isKindOfClass:[UIImageView class]]) {
                    inScrollView.hidden = YES;
                }
            }
        }
    }
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _loadingView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    self.webView.hidden = YES;
    //清除webView的缓存
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //清除请求
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:self.request];
    //清除cookies
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies]) {
        [storage deleteCookie:cookie];
    }
    return YES;
}


- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.bgView.hidden = NO;
    self.actIv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    self.actIv.frame = CGRectMake(0, 64, 32, 32);
    self.actIv.center = self.loadingView.center;
    [self.loadingView addSubview:self.actIv];
    [self.actIv startAnimating];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('logowrapper')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('inside-head')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('head-link')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('baidugg')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('main-nav')[0].style.display = 'none'"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(action) userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)action {
    self.bgView.hidden = YES;
    self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
}

- (void)viewDidDisappear:(BOOL)animated {
    [self.timer invalidate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
