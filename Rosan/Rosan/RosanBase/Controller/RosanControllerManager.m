//
//  RosanControllerManager.m
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RosanControllerManager.h"
#import "RosanBsaeViewController.h"
#import "RHomeViewController.h"
#import "RQuotationViewController.h"
#import "RNewsViewController.h"
#import "RMYViewController.h"
#import "UIImage+Cropping.h"
#import "RosanNavigationController.h"
#import "AppDelegate.h"
#import "RLoginViewController.h"

@interface RosanControllerManager ()
{
    NSArray *_controllers;
    NSArray *_titleArray;
    NSArray *_normalImageArray;
    NSArray *_clickImageArray;
}
@property (nonatomic,assign) BOOL isCreatView;

@end

@implementation RosanControllerManager

#define SYSTEM_VERSION [UIDevice currentDevice].systemVersion.floatValue
SYNTHESIZE_SINGLETON_FOR_CLASS(RosanControllerManager)


- (void)popToLogin {
    
}

- (void)createTabbarController {
    _controllers = @[@"RHomeViewController",@"RQuotationViewController",@"RNewsViewController",@"RLoginViewController"];
    _titleArray = @[@"首页",@"行情",@"资讯",@"我的"];
    _normalImageArray = @[@"home1",@"ww1",@"bar1",@"my1"];
    _clickImageArray = @[@"home",@"ww",@"bar",@"my"];
    
    NSDictionary *dic = @{NSForegroundColorAttributeName:[UIColor blackColor], NSFontAttributeName:[UIFont systemFontOfSize:12]};
    NSDictionary *dicSel = @{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:12]};
    NSMutableArray *viewArr = [NSMutableArray array];
    for (int i = 0; i < _controllers.count; i++) {
        Class class = NSClassFromString(_controllers[i]);
        RosanBsaeViewController *vc = [[class alloc] init];
        RosanNavigationController *nav = [[RosanNavigationController alloc] initWithRootViewController:vc];
        UITabBarItem *item = [[UITabBarItem alloc] initWithTitle:_titleArray[i] image:[UIImage imageWithOriginalName:_normalImageArray[i]] selectedImage:[UIImage imageWithOriginalName:_clickImageArray[i]]];
        [item setTitleTextAttributes:dic forState:UIControlStateNormal];
        [item setTitleTextAttributes:dicSel forState:UIControlStateSelected];
        nav.tabBarItem = item;
        [viewArr addObject:nav];
    }
    UITabBarController *mainTBC = [[UITabBarController alloc] init];
    mainTBC.viewControllers = viewArr;
    [mainTBC.tabBar setBackgroundImage:[UIImage new]];// tabber背景替换成一张透明图片
    mainTBC.tabBar.backgroundColor = [UIColor whiteColor];
    [AppDelegate sharedAppDelegate].window.rootViewController = mainTBC;
}
@end
