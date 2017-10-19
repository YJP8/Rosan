//
//  RHomeViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RHomeViewController.h"
#import "RClassTableViewCell.h"
#import "RCalendarTableViewCell.h"
#import "RGoodTableViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "FirstViewController.h"
#import "LiveViewController.h"
#define __homeCellId @"__homeCellId"
#define __classCellId @"__classCellId"
#define __goodsCellId @"__goodsCellId"
@interface RHomeViewController ()<UITableViewDelegate,UITableViewDataSource> {
    SDCycleScrollView *_sdc;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;

@end

@implementation RHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    [self creatScroll];
    [self creatTableView];
    [self requestData];
}

- (void)creatScroll {
    NSArray *images = @[[UIImage imageNamed:@"banner1"],[UIImage imageNamed:@"banner2"],[UIImage imageNamed:@"banner3"]];
    _sdc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) imageNamesGroup:images];
    [self.view addSubview:_sdc];
}

- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://appapi.kxt.com/data/jianwen2?system=ios&version=5.3.2&idfv=CB8DA917-210E-45C0-8CB1-D2049A6B11A2&markid=0&num=10&tagid=0" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.dataArray = [dict objectForKey:@"data"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)creatTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.tableHeaderView = _sdc;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    [_tableView registerClass:[RClassTableViewCell class] forCellReuseIdentifier:__classCellId];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:__homeCellId];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 8;
    }else if (section == 2){
        return 44;
    }else{
        return 0.1;
    };
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *shopPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 8)];
        shopPriceView.backgroundColor = [UIColor grayColor];
        shopPriceView.alpha = 0.2;
        return shopPriceView;
    }else if (section == 2){
        UIView *shopPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52)];
        shopPriceView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
        UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 375*[UIScreen mainScreen].bounds.size.width/375, 44)];
        bannerImageView.image = [UIImage imageNamed:@"bg_view"];
        [shopPriceView addSubview:bannerImageView];
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 375*[UIScreen mainScreen].bounds.size.width/375, 44)];
        [button addTarget:self action:@selector(mapBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [shopPriceView addSubview:button];
        return shopPriceView;
    }else{
        return nil;
    }
}

- (void)mapBtnClick {
    FirstViewController *first = [[FirstViewController alloc] init];
    first.urlStr = @"http://m.kxt.com/";
    first.titleStr = @"资讯";
    first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:first animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2){
        return _dataArray.count;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 150;
    }else if (indexPath.section == 1){
        return 195;
    }else{
        return 100;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:__classCellId];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        
        [cell setClassCellBlock:^(NSInteger infoID) {
            if (infoID == 0) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://m.kxt.com/";
                first.titleStr = @"全球资讯";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 1) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://m.kxt.com/rili/";
                first.titleStr = @"财经日历";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 2) {
                LiveViewController *liveVc = [[LiveViewController alloc] init];
                liveVc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:liveVc animated:YES];
            }else if (infoID == 3) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://viewapi.kxt.com/Data/index/code/INJCJC%2BIndex.html";
                first.titleStr = @"数据中心";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 4) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://m.kxt.com/quotes/";
                first.titleStr = @"行情中心";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 5) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://m.kxt.com/hQuotes/quotes?code=wh";
                first.titleStr = @"外汇汇率";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 6) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://m.kxt.com/hQuotes/chart?code=shicom";
                first.titleStr = @"上证指数";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 7) {
                FirstViewController *first = [[FirstViewController alloc] init];
                first.urlStr = @"http://m.kxt.com/hQuotes/chart?code=hsi";
                first.titleStr = @"恒生指数";
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }
            
        }];
        return cell;
    } else if (indexPath.section == 1){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:__homeCellId];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375*[UIScreen mainScreen].bounds.size.width/375, 195)];
        bannerImageView.image = [UIImage imageNamed:@"XXXX"];
        bannerImageView.contentMode = UIViewContentModeScaleAspectFit;   //图片的比例自动适应
        [cell.contentView addSubview:bannerImageView];
        return cell;
        
    } else if (indexPath.section == 2){
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
            cell.tags.text = [dic objectForKey:@"tags"][0];
            // 格式化时间
            NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
            formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
            [formatter setDateStyle:NSDateFormatterMediumStyle];
            [formatter setTimeStyle:NSDateFormatterShortStyle];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            
            // 毫秒值转化为秒
            NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"addtime"] doubleValue]];
            NSString* dateString = [formatter stringFromDate:date];
            cell.addtime.text = dateString;
        }
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        FirstViewController *first = [[FirstViewController alloc] init];
        first.urlStr = @"http://m.kxt.com/rili/";
        first.titleStr = @"财经日历";
        first.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:first animated:YES];
    }else if (indexPath.section == 2) {
        FirstViewController *first = [[FirstViewController alloc] init];
        NSDictionary *dic = _dataArray[indexPath.row];
        first.urlStr = [dic objectForKey:@"url"];
        first.titleStr = @"资讯";
        first.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:first animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
