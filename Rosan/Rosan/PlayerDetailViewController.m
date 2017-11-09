//
//  PlayerDetailViewController.m
//  Rosan
//
//  Created by Levante on 2017/10/31.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "PlayerDetailViewController.h"
#import "ZFPlayerView.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AFNetworking/AFNetworking.h>
#import "LiveTableViewCell.h"
#import "LiveViewController.h"
#import "Masonry.h"

//重写NSLog,Debug模式下打印日志和当前行数
#ifdef DEBUG
#define NetworkLog(s, ... ) NSLog( @"[%@ line:%d]=> %@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define NetworkLog(s, ... )
#endif

// 网络状态，初始值-1：未知网络状态
static NSInteger networkStatus = -1;

@interface PlayerDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) ZFPlayerView *playerView;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dateArray;
@property (nonatomic, copy) NSString *viewString;

@end

@implementation PlayerDetailViewController


- (void)viewWillAppear:(BOOL)animated {
    [self creatTableView];
}

- (void)requestData {
    _dateArray = [NSMutableArray array];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"http://106.14.114.49:8085/api/video?limit=10&offset=0" parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",dict);
        NSArray *dateArr = [dict objectForKey:@"list"];
        
        for (NSDictionary *dic in dateArr) {
            if ([self.idStr isEqualToString:dic[@"id"]]) {
                
            }else {
                [self.dateArray addObject:dic];
            }
        }
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    [_playerView moviePlayStop];
    if (_playerView) {
        [_playerView removeFromSuperview];
    }
}

- (void)creatTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor whiteColor];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *HostStr = [NSString stringWithFormat:@"http://api.4004003.com/api/video/info?id=%@",self.idStr];
    [manager GET:HostStr parameters:@"" progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves error:nil];
        NSDictionary *dicData= [dict objectForKey:@"data"];
        NSURL *videoURL = [NSURL URLWithString:[dicData objectForKey:@"video"]];
        self.titleLabel.text = [dicData objectForKey:@"title"];
        self.viewString = [dicData objectForKey:@"view"];
        [self playVideoWithURL:videoURL];
        [self requestData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"财经直播";
    [self backButton];
    [self creatTableView];
    
}

-(void)backButton{
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickbackButton)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftButton;
    
}
-(void)clickbackButton{
    
    
    NSArray *temArray = self.navigationController.viewControllers;
    for (UIViewController *termVC in temArray) {
        if ([termVC isKindOfClass:[LiveViewController class]]) {
            [self.navigationController popToViewController:termVC animated:YES];
        }
    }
    
    
}

- (void)playVideoWithURL:(NSURL *)url
{
    
    _playerView = [ZFPlayerView setupZFPlayer];
    self.tableView.tableHeaderView = _playerView;
    _playerView.frame = CGRectMake(0, 25, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width*9/16);
//    [_playerView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(@0);
//        make.right.equalTo(@0);
//        make.top.equalTo(@20);
//        make.height.equalTo(_playerView.mas_width).multipliedBy(9.0/16);
//
//    }];
    
    _playerView.videoURL = url;
    
    __weak typeof(self) weakSelf = self;
    self.playerView.goBackBlock = ^{
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dateArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *viewbg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 60)];
    viewbg.backgroundColor = [UIColor whiteColor];
    UILabel *titleone = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
    titleone.font = [UIFont systemFontOfSize:13];
    titleone.textColor = [UIColor lightGrayColor];
    [viewbg addSubview:titleone];
    UILabel *titletwo = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width - 120, 0, 120, 20)];
    titletwo.font = [UIFont systemFontOfSize:13];
    titletwo.textAlignment = NSTextAlignmentRight;
    titletwo.textColor = [UIColor lightGrayColor];
    [viewbg addSubview:titletwo];
    UIView *shopPriceView = [[UIView alloc] initWithFrame:CGRectMake(0, 30, [UIScreen mainScreen].bounds.size.width, 30)];
    shopPriceView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 70, 25)];
    title.text = @"推荐视频";
    //1.创建网络状态监测管理者
    AFNetworkReachabilityManager *reachability = [AFNetworkReachabilityManager sharedManager];
    //2.监听改变
    [reachability setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        /*
         AFNetworkReachabilityStatusUnknown          = -1,
         AFNetworkReachabilityStatusNotReachable     = 0,
         AFNetworkReachabilityStatusReachableViaWWAN = 1,
         AFNetworkReachabilityStatusReachableViaWiFi = 2,
         */
        networkStatus = status;
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NetworkLog(@"未知");
                title.text = @"";
                titleone.text = @"";
                titletwo.text = @"";
                shopPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NetworkLog(@"没有网络");
                title.text = @"";
                titleone.text = @"";
                titletwo.text = @"";
                shopPriceView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5];
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NetworkLog(@"3G|4G");
                titleone.text = @"视频来源：国金财经资讯";
                titletwo.text = [NSString stringWithFormat:@"播放次数: %@次",self.viewString];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                titleone.text = @"视频来源：国金财经资讯";
                titletwo.text = [NSString stringWithFormat:@"播放次数: %@次",self.viewString];
                NetworkLog(@"WiFi");
                break;
            default:
                break;
        }
    }];
    [reachability startMonitoring];

    [shopPriceView addSubview:title];
    [viewbg addSubview:shopPriceView];
    return viewbg;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[LiveTableViewCell description]];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"LiveTableViewCell" owner:self options:nil] firstObject];
    }
    cell.selectionStyle = UITableViewCellAccessoryNone;
    NSDictionary *dic = _dateArray[indexPath.row];
    [cell.picture sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"picture"]]];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[[dic objectForKey:@"publishTime"] doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    cell.time.text = dateString;
    cell.title.text = [dic objectForKey:@"title"];
    cell.count.text = [dic objectForKey:@"playCount"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dic = _dateArray[indexPath.row];
    PlayerDetailViewController *player = [[PlayerDetailViewController alloc] init];
    player.hidesBottomBarWhenPushed = YES;
    player.idStr = [dic objectForKey:@"id"];
    [self.navigationController pushViewController:player animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
