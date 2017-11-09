//
//  SecViewController.m
//  Rosan
//
//  Created by Levante on 2017/10/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "SecViewController.h"
#import "UIViewController+ZJScrollPageController.h"
#import "QuotationTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "FirstViewController.h"

@interface SecViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic)NSInteger tags;

@end

@implementation SecViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatTableView];
    self.zj_scrollViewController.title  = @"行情";
}

- (void)creatTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[QuotationTableViewCell class] forCellReuseIdentifier:@"cell"];
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


// 使用系统的生命周期方法
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear------%ld", self.zj_currentIndex);

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"viewDidAppear-----%ld", self.zj_currentIndex);
    self.tags = self.zj_currentIndex+1;
    [self requestShopData];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear-----%ld", self.zj_currentIndex);
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"viewDidDisappear--------%ld", self.zj_currentIndex);
    
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
