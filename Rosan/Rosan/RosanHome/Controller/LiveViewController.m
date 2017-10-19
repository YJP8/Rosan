//
//  LiveViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "LiveViewController.h"
#import "LiveTableViewCell.h"
#import "FirstViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>

@interface LiveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic)NSInteger page;
@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"财经直播";
    [self creatTableView];
    [self requestData];
    [self backButton];
    
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

- (void)creatTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
}

- (void)requestData {
    _page = 10;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://appapi.kxt.com/Video/list_video?system=ios&version=5.3.2&idfv=051936F6-0200-4995-8BE3-9D1891DDAFE6&cid=144&markid=0&num=10" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict);
        self.dataArray = [dict objectForKey:@"data"];
        [self.tableView reloadData];
        [_tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView.mj_header endRefreshing];
    }];
    
}

- (void) requestUpDate {
    _page = _page + 10;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *str = [NSString stringWithFormat:@"http://appapi.kxt.com/Video/list_video?system=ios&version=5.3.2&idfv=051936F6-0200-4995-8BE3-9D1891DDAFE6&cid=144&markid=0&num=%ld",_page];
    [manager GET:str parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict);
        NSMutableArray *result = [[NSMutableArray alloc]initWithArray:_dataArray];
        [result addObjectsFromArray: [dict objectForKey:@"data"]];
        _dataArray = result;
        [self.tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [_tableView.mj_footer endRefreshing];
    }];
}
    

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LiveTableViewCell description]];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LiveTableViewCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    NSDictionary *dic = _dataArray[indexPath.row];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"picture"]]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"publish_time"] doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    cell.time.text = dateString;
    cell.title.text = [dic objectForKey:@"title"];
    cell.count.text = [dic objectForKey:@"play_count"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstViewController *first = [[FirstViewController alloc] init];
    NSDictionary *dic = _dataArray[indexPath.row];
    first.urlStr = [dic objectForKey:@"url"];
    first.titleStr = @"财经直播";
    first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:first animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
