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
#import "RQuotationViewController.h"
#import "RCShopView.h"
#import "RNewsViewController.h"
#import "NewDetailViewController.h"
#define __homeCellId @"__homeCellId"
#define __classCellId @"__classCellId"
#define __goodsCellId @"__goodsCellId"
@interface RHomeViewController ()<UITableViewDelegate,UITableViewDataSource> {
    SDCycleScrollView *_sdc;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSArray *dataArray;
@property (nonatomic, strong)NSArray *shopDataArray;
@property (nonatomic, strong)NSMutableDictionary *zhishuDic;
@property (nonatomic, strong)NSMutableDictionary *zhishuaDic;
@property (nonatomic, strong)NSTimer *timer;
@end

@implementation RHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    _zhishuDic = [NSMutableDictionary dictionary];
    _zhishuaDic = [NSMutableDictionary dictionary];
    [self creatScroll];
    [self creatTableView];
    [self requestData];
    [self requestShopData];
    [self requestzhishuData];
    [self requestzhishuaData];
    
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
        [self requestzhishuData];
        [self requestzhishuaData];
    });
    
}

- (void)viewDidAppear:(BOOL)animated {
    [self.timer invalidate];
}

- (void)creatScroll {
    NSArray *images = @[[UIImage imageNamed:@"banner1"],[UIImage imageNamed:@"banner3"]];
    _sdc = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150) imageNamesGroup:images];
    [self.view addSubview:_sdc];
}

- (void)requestData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://106.14.114.49:8085/api/news?limit=10&offset=1" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.dataArray = [dict objectForKey:@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)requestShopData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://106.14.114.49:8085/api/index" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.shopDataArray = [dict objectForKey:@"list"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];

}

- (void)requestzhishuData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://106.14.114.49:8085/api/info?codes=NASINDEX,HKG33INDEX,000001" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.zhishuDic  = [dict objectForKey:@"data"];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

- (void)requestzhishuaData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://106.14.114.49:8085/api/info?codes=XAGUSD,XAUUSD,XPTUSD" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        self.zhishuaDic  = [dict objectForKey:@"data"];
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
    
    [_tableView registerClass:[RCalendarTableViewCell class] forCellReuseIdentifier:__goodsCellId];
    [_tableView registerClass:[RClassTableViewCell class] forCellReuseIdentifier:__classCellId];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:__homeCellId];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        return 78;
//    }else if (section == 2){
//        return 44;
//    }else{
        return 0.1;
//    };
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    if (section == 1) {
//        UIView *shopPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 78)];
//        shopPriceView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
//        RCShopView *shopView = [[[NSBundle mainBundle]loadNibNamed:@"RCShopView" owner:nil options:nil]lastObject];
//        shopView.frame = CGRectMake(0, 8, 375*[UIScreen mainScreen].bounds.size.width/375, 70);
//        __weak typeof(self) weakSelf = self;
//        [shopView setMoreBlock:^{
//            RQuotationViewController *first = [[RQuotationViewController alloc] init];
//            first.titleStr = @"商品";
//            first.inter = 1;
//            first.hidesBottomBarWhenPushed = YES;
//            [weakSelf.navigationController pushViewController:first animated:YES];
//        }];
//        [shopPriceView addSubview:shopPriceView];
//        return shopPriceView;
//    }else if (section == 2){
//        UIView *shopPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52)];
//        shopPriceView.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.2];
//        UIImageView *bannerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 8, 375*[UIScreen mainScreen].bounds.size.width/375, 44)];
//        bannerImageView.image = [UIImage imageNamed:@"bg_view"];
//        [shopPriceView addSubview:bannerImageView];
//        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 8, 375*[UIScreen mainScreen].bounds.size.width/375, 44)];
//        [button addTarget:self action:@selector(mapBtnClick) forControlEvents:UIControlEventTouchUpInside];
//        [shopPriceView addSubview:button];
//        return shopPriceView;
//    }else{
        return nil;
//    }
}

- (void)mapBtnClick {
    RNewsViewController *first = [[RNewsViewController alloc] init];
    first.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:first animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 2){
        return _dataArray.count;
    }else if (section == 1) {
        return 1;
    }else {
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section == 1){
        return 270;
    }else{
        return 100;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        RClassTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RClassTableViewCell description]];
        cell.selectionStyle = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RClassTableViewCell" owner:self options:nil] firstObject];
        }
        [cell setClassCellBlock:^(NSInteger infoID) {
            if (infoID == 0) {
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"外汇";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 1) {
                LiveViewController *first = [[LiveViewController alloc] init];
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 2) {
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"商品";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 3) {
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"沪深";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 4) {

            }else if (infoID == 5) {

            }else if (infoID == 6) {
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"股票";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 7) {
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"股指";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }
            
        }];
        return cell;
    } else if (indexPath.section == 1){
        RCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[RCalendarTableViewCell description]];
        if (!cell) {
            cell = [[[NSBundle mainBundle]loadNibNamed:@"RCalendarTableViewCell" owner:self options:nil] firstObject];
        }
        [cell setDataDic:_zhishuDic];
        [cell setDataaDic:_zhishuaDic];
        [cell setClassCellBlock:^(NSInteger infoID) {
            if (infoID == 0) {
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"股票";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else if (infoID == 1){
                RQuotationViewController *first = [[RQuotationViewController alloc] init];
                first.titleStr = @"商品";
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
            }else {
                RNewsViewController *first = [[RNewsViewController alloc] init];
                first.inter = 1;
                first.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:first animated:YES];
               
            }
        }];
        [cell setStringCellBlock:^(NSString *url, NSString *name) {
            FirstViewController *first = [[FirstViewController alloc] init];
            first.urlStr = url;
            first.titleStr = name;
            first.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:first animated:YES];

        }];
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
            if (![[dic objectForKey:@"title"]isEqual:[NSNull null]]) {
                cell.titles.text = [dic objectForKey:@"title"];
            }
            if (![[dic objectForKey:@"tags"]isEqual:[NSNull null]]) {
                cell.tags.text = [dic objectForKey:@"tags"];
            }
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
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {

    }else if (indexPath.section == 2) {
        NSDictionary *dic = _dataArray[indexPath.row];
        NewDetailViewController *first = [[NewDetailViewController alloc] init];
        first.idStr = [dic objectForKey:@"id"];
        first.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:first animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
