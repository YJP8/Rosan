//
//  NewDetailViewController.m
//  Rosan
//
//  Created by Levante on 2017/10/30.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "NewDetailViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface NewDetailViewController ()<UIWebViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, retain)UIActivityIndicatorView *actIv;
@property (nonatomic, retain)UIView *loadingView;
@property (nonatomic, strong)NSMutableURLRequest *request;
@end

@implementation NewDetailViewController


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *HostStr = [NSString stringWithFormat:@"http://api.4004003.com/api/news/info?id=%@",self.idStr];
    [manager GET:HostStr parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dicData= [dict objectForKey:@"data"];
        NSString *strData = [NSString stringWithFormat:@"<style type=\"text/css\">img {width:100%%}</style>%@",[dicData objectForKey:@"news-article"]];
        [self.webView loadHTMLString:strData baseURL:nil];
        NSString *strUrl = [[dicData objectForKey:@"time"] stringByReplacingOccurrencesOfString:@"\n               " withString:@""];
        NSString *strUrls = [strUrl stringByReplacingOccurrencesOfString:@"文章来源 : 快讯通财经 " withString:@"文章来源：国金财经资讯"];
        self.dateLabel.text = strUrls;
        self.titleLabel.text = [dicData objectForKey:@"title"];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯";
    _loadingView = [[UIView alloc] init];
    [self backButton];
    [self.view addSubview:self.loadingView];
    self.webView.opaque = NO;
    self.webView.backgroundColor = [UIColor clearColor];
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
    self.actIv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
    self.actIv.frame = CGRectMake(0, 64, 32, 32);
    self.actIv.center = self.loadingView.center;
    [self.loadingView addSubview:self.actIv];
    [self.actIv startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
    self.webView.hidden = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.actIv stopAnimating];
    [self.loadingView removeFromSuperview];
}


@end
