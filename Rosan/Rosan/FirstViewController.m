//
//  FirstViewController.m
//  AAA
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *actIv;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, retain)UIView *loadingView;
@property (nonatomic, strong)NSMutableURLRequest *request;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.titleStr;
    _loadingView = [[UIView alloc] init];
    [self.view addSubview:self.loadingView];
    
    NSString *str = self.urlStr;
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
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeSystem];
    backButton.frame = CGRectMake(10, 20, 20, 20);
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
}
- (void)back:(UIBarButtonItem *)btn
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else {
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
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
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('logowrapper')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('inside-head')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('head-link')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('baidugg')[0].style.display = 'none'"];
    [self.webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.getElementsByClassName('main-nav')[0].style.display = 'none'"];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {

    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
    self.bgView.hidden = YES;
    self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
