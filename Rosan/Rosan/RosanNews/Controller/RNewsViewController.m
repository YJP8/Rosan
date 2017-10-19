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
@end

@implementation RNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯";
    _loadingView = [[UIView alloc] init];
//    _loadingView.backgroundColor = [UIColor blackColor];
//    self.loadingView.alpha = 0.5;
    [self.view addSubview:self.loadingView];
    
    NSString *str = @"http://m.kxt.com/";
    str = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:60];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
    [self.webView loadRequest:request];
    
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

- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.bgView.hidden = NO;
    self.actIv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    self.actIv.frame = CGRectMake(0, 64, 32, 32);
    self.actIv.center = self.loadingView.center;
    [self.loadingView addSubview:self.actIv];
    [self.actIv startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('logowrapper')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('inside-head')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('head-link')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('baidugg')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('main-nav')[0].style.display = 'none'"];
    self.bgView.hidden = YES;
    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
