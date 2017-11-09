//
//  RosanBsaeViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RosanBsaeViewController.h"

@interface RosanBsaeViewController ()

@end

@implementation RosanBsaeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *attributes=[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:attributes];
    UINavigationBar *navbar = self.navigationController.navigationBar;
    [navbar setBackgroundImage:[UIImage imageNamed:@"navi-bar1"] forBarMetrics:UIBarMetricsDefault];

}
- (void)backButton {
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style:UIBarButtonItemStylePlain target:self action:@selector(clickBackButton)];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)clickBackButton
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
