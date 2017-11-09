//
//  RegiftViewController.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RegiftViewController.h"
#import "ForgetViewController.h"
#define YZM_NUM_CODE        4                   //验证码位数
#define YZM_TIME_CODE       60                  //验证码时间
#define Empty_Str(param)            (nil == param || param.length < 1)
#define ToastCenter  @"CSToastPositionCenter"
#define ToastTop     @"CSToastPositionTop"
#define ToastBottom  @"CSToastPositionBottom"

#define TimeDuration  2.0f

@interface RegiftViewController ()<UITextFieldDelegate>
{
    dispatch_queue_t queue ;
    dispatch_source_t _timer;
}
@property (strong, nonatomic) IBOutlet UITextField *user_phone;
@property (strong, nonatomic) IBOutlet UITextField *ver_code;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *passwordt;
@property (strong, nonatomic) IBOutlet UIButton *ver_but;

@end

@implementation RegiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册";
    [self backButton];
    self.user_phone.clearButtonMode = UITextFieldViewModeAlways;
    self.user_phone.delegate = self;
    [self.user_phone addTarget:self action:@selector(phoneTextFieldChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)phoneTextFieldChange:(UITextField *)phoneTextField {
    //手机为11位
    if (phoneTextField.text.length > 11){
        phoneTextField.text = [phoneTextField.text substringToIndex:11];
    }else  if(phoneTextField.text.length == 11) {
    }
}

//验证码跳秒方法
- (void)timerFireMethod
{
    self.ver_but.userInteractionEnabled = NO;
    __block int timeout = YZM_TIME_CODE-1; //倒计时时间
    queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.ver_but.userInteractionEnabled = YES;
                [self.ver_but setTitle:@"获取验证码" forState:0];
            });
        }else{
            int seconds = timeout % YZM_TIME_CODE;
            NSString *strTime = [NSString stringWithFormat:@"获取中%.2d秒", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.ver_but setTitle:[NSString stringWithFormat:@"%@",strTime] forState:0];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)verClick:(UIButton *)sender {
    if (self.user_phone.text.length < 11){
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    [self timerFireMethod];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"获取验证码成功" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
}
- (IBAction)registers:(UIButton *)sender {
    if (self.user_phone.text.length < 11) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入正确手机号" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    if (Empty_Str(self.password.text)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入密码" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    if (![_passwordt.text isEqualToString:_password.text]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"两次输入不一致" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    if (Empty_Str(self.ver_code.text)) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入验证码" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"验证码错误" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
    
}
- (IBAction)forget:(UIButton *)sender {
    ForgetViewController *forget = [[ForgetViewController alloc] init];
    [self.navigationController pushViewController:forget animated:YES];
}

@end
