//
//  RLoginViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RLoginViewController.h"
#import "RegiftViewController.h"
#import "ForgetViewController.h"

@interface RLoginViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *user_phone;
@property (strong, nonatomic) IBOutlet UITextField *user_password;

@end

@implementation RLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self backButton];
    self.navigationItem.title = @"我的";
    self.user_phone.clearButtonMode = UITextFieldViewModeAlways;
    self.user_phone.delegate = self;
    [self.user_phone addTarget:self action:@selector(phoneTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 45, 45)];
    [rightButton setTitle:@"注册" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(sidebar) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}
- (void)phoneTextFieldChange:(UITextField *)phoneTextField {
    //手机为11位
    if (phoneTextField.text.length > 11){
        phoneTextField.text = [phoneTextField.text substringToIndex:11];
    }else  if(phoneTextField.text.length == 11) {
    }
}
- (IBAction)login:(UIButton *)sender {
    if (self.user_phone.text.length < 11) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    if (self.user_password.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确的密码" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"用户名密码不正确" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (void)sidebar {
    RegiftViewController *re = [[RegiftViewController alloc] init];
    re.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:re animated:YES];
}
- (IBAction)forget:(UIButton *)sender {
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    forget.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:forget  animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
