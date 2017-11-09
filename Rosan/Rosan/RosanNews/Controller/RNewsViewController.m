//
//  RNewsViewController.m
//  Rosan
//
//  Created by Levante on 2017/10/24.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RNewsViewController.h"
#import "RGoodTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "FirstViewController.h"
#import <MJRefresh/MJRefresh.h>
#import "NewDetailViewController.h"

@interface RNewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic)NSInteger page;
@end

@implementation RNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    [self creatTableView];
    [self requestData];
    self.navigationItem.title = @"资讯";
    if (self.inter == 1) {
        [self backButton];
    }
    
    // 刷新
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self requestData];
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    // 设置文字
    [header setTitle:@"下拉刷新数据" forState:MJRefreshStateIdle];
    [header setTitle:@"松手立即刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
    self.tableView.mj_header = header;
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self requestUpDate];
    }];
    [footer setTitle:@"上拉加载数据" forState:MJRefreshStateIdle];
    [footer setTitle:@"松手立即加载" forState:MJRefreshStatePulling];
    [footer setTitle:@"正在加载" forState:MJRefreshStateRefreshing];
    self.tableView.mj_footer = footer;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)creatTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
}

- (void)requestData {
    _page = 0;
     [_dataArray removeAllObjects];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://106.14.114.49:8085/api/news?limit=10&offset=0" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        [_dataArray addObjectsFromArray:[dict objectForKey:@"list"]];
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView.mj_header endRefreshing];
    }];
    
}

- (void)requestUpDate {
    _page = _page + 1;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        NSString *str = [NSString stringWithFormat:@"http://106.14.114.49:8085/api/news?limit=10&offset=%ld",_page];
    [manager GET:str parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        [_dataArray addObjectsFromArray:[dict objectForKey:@"list"]];
        [self.tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView.mj_footer endRefreshing];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RGoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RGoodTableViewCell description]];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"RGoodTableViewCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    cell.backgroundColor = [UIColor whiteColor];
    if (_dataArray.count == 0) {
        
    }else {
        NSDictionary *dic = _dataArray[indexPath.row];
        [cell.thumb sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"thumb"]]];
        cell.titles.text = [dic objectForKey:@"title"];
        cell.tags.text = [dic objectForKey:@"tags"];
        // 格式化时间
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
        [formatter setDateStyle:NSDateFormatterMediumStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        
        // 毫秒值转化为秒
        NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"addTime"] doubleValue]];
        NSString* dateString = [formatter stringFromDate:date];
        cell.addtime.text = dateString;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dataArray[indexPath.row];
    NewDetailViewController *first = [[NewDetailViewController alloc] init];
    first.idStr = [dic objectForKey:@"id"];
    first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:first animated:YES];
}

@end
