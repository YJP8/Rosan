//
//  FeedbackViewController.m
//  Rosan
//
//  Created by Levante on 2017/10/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "FeedbackViewController.h"
#import "CMInputView.h"

@interface FeedbackViewController ()<UITextViewDelegate>

@property (strong, nonatomic) IBOutlet CMInputView *feedBackTextView;

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"意见反馈";
    [self backButton];
    self.feedBackTextView.delegate = self;
    self.feedBackTextView.placeholder = @"请输入您的宝贵意见";
    self.feedBackTextView.placeholderFont = [UIFont systemFontOfSize:14];
    self.feedBackTextView.placeholderColor = [UIColor grayColor];
}

- (IBAction)feedNote:(UIButton *)sender {
    if (NO == _checkBtn.selected) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请先登录" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
        return;
    }
    if (self.feedBackTextView.text.length == 0) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请输入文本内容" preferredStyle:  UIAlertControllerStyleAlert];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
        
        [self presentViewController:alert animated:true completion:nil];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提交成功" message:@"感谢您的支持" preferredStyle:  UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    
    [self presentViewController:alert animated:true completion:nil];
}


- (IBAction)checkBtnClick:(UIButton *)sender {
    UIButton * button = (UIButton *)sender;
    button.selected  = !button.selected;
}
@end
