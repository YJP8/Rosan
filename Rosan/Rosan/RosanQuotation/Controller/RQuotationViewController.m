//
//  RQuotationViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RQuotationViewController.h"
#import "FirstViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface RQuotationViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic)NSInteger tags;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation RQuotationViewController


- (void)viewWillAppear:(BOOL)animated {
    if (self.titleStr) {
        self.navigationItem.title = self.titleStr;
    }else {
        self.navigationItem.title = @"股票";
    }
    [self creatTableView];
    if ([self.titleStr isEqualToString:@"外汇"]){
        _tags = 1;
    }else if ([self.titleStr isEqualToString:@"债券"]){
        _tags = 5;
    }else if ([self.titleStr isEqualToString:@"沪深"]){
        _tags = 6;
    }else if ([self.titleStr isEqualToString:@"股指"]){
        _tags = 4;
    }else if ([self.titleStr isEqualToString:@"商品"]){
        _tags = 3;
    }else {
        _tags = 2;
    }
    [self requestShopData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.inter == 1) {
        [self backButton];
    }else {
        
    }
    self.timer = [NSTimer timerWithTimeInterval:10 target:self selector:@selector(updateTimer)userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    [NSThread detachNewThreadSelector:@selector(bannerStart)toTarget:self withObject:nil];
}
- (void)bannerStart{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(updateTimer)userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
}
- (void)updateTimer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self requestShopData];
    });
}
- (void)viewDidAppear:(BOOL)animated {
    [self.timer invalidate];
}
- (void)requestShopData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:@"http://106.14.114.49:8085/api/list?type=%ld",_tags];
    [manager GET:url parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.dataArray = [dict objectForKey:@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)creatTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[QuotationTableViewCell class] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QuotationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[QuotationTableViewCell description]];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"QuotationTableViewCell" owner:self options:nil] firstObject];
    }
    if (_dataArray.count == 0) {
        
    }else {
        NSDictionary *dic = _dataArray[indexPath.row];
        cell.name.text = [dic objectForKey:@"prodName"];
        cell.price.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"lastPx"]floatValue]];
        cell.change.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"pxChange"]floatValue]];
        cell.changeRage.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"pxChangeRate"]floatValue]];
        cell.yesterday.text = [NSString stringWithFormat:@"%.2f",[[dic objectForKey:@"preclosePx"]floatValue]];
        if ([cell.change.text floatValue] > 0) {
            cell.price.textColor = [UIColor redColor];
            cell.change.textColor = [UIColor redColor];
            cell.changeRage.textColor = [UIColor redColor];
            cell.yesterday.textColor = [UIColor redColor];
        }else if ([cell.change.text floatValue] == 0){
            cell.price.textColor = [UIColor grayColor];
            cell.change.textColor = [UIColor grayColor];
            cell.changeRage.textColor = [UIColor grayColor];
            cell.yesterday.textColor = [UIColor grayColor];
        }else {
            cell.price.textColor = [UIColor greenColor];
            cell.change.textColor = [UIColor greenColor];
            cell.changeRage.textColor = [UIColor greenColor];
            cell.yesterday.textColor = [UIColor greenColor];
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstViewController *first = [[FirstViewController alloc] init];
    NSDictionary *dic = _dataArray[indexPath.row];
    first.urlStr = [NSString stringWithFormat:@"http://106.14.114.49:8085/info.html?symbol=%@",[dic objectForKey:@"code"]];
    first.titleStr = [dic objectForKey:@"prodName"];
    first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:first animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
