//
//  RMYViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RMYViewController.h"
#import "RLoginViewController.h"
#import "RegiftViewController.h"
#import "AboutWeViewController.h"
#import "ContactWeViewController.h"
#import "FeedbackViewController.h"

@interface RMYViewController ()
@property (strong, nonatomic) IBOutlet UIView *view_bg;

@end

@implementation RMYViewController
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view_bg.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.30];
}
- (IBAction)loginClick:(UIButton *)sender {
    RLoginViewController *login = [[RLoginViewController alloc] init];
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
}
- (IBAction)registers:(UIButton *)sender {
    RegiftViewController *registers = [[RegiftViewController alloc] init];
    registers.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:registers animated:YES];
}

- (IBAction)Click:(UIButton *)sender {
    if (sender.tag == 0) {
        AboutWeViewController *aboutWe = [[AboutWeViewController alloc] init];
        aboutWe.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutWe animated:YES];
    }else if (sender.tag == 1) {
        ContactWeViewController *aboutWe = [[ContactWeViewController alloc] init];
        aboutWe.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:aboutWe animated:YES];
    }else if (sender.tag == 2) {
        
    }else if (sender.tag == 3) {
        FeedbackViewController *feedBack = [[FeedbackViewController alloc] init];
        feedBack.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedBack animated:YES];
    }else if (sender.tag == 4) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
