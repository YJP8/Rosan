//
//  RCalendarTableViewCell.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RCalendarTableViewCell.h"
#define LCScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define LCScreenHeight    [[UIScreen mainScreen] bounds].size.height
@implementation RCalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.with1.constant = LCScreenWidth * 116 / 375;
    self.with2.constant = LCScreenWidth * 116 / 375;
    self.with3.constant = LCScreenWidth * 116 / 375;
    self.with4.constant = LCScreenWidth * 116 / 375;
    self.with5.constant = LCScreenWidth * 116 / 375;
    self.with6.constant = LCScreenWidth * 116 / 375;
    self.with7.constant = LCScreenWidth * 116 / 375;
    self.with8.constant = LCScreenWidth * 116 / 375;
    self.with9.constant = LCScreenWidth * 116 / 375;
    self.with10.constant = LCScreenWidth * 116 / 375;
}
- (IBAction)zhishuClick:(UIButton *)sender {
    if (_classCellBlock) {
        _classCellBlock(sender.tag);
    }
}
- (IBAction)shopClick:(UIButton *)sender {
    if (_classCellBlock) {
        _classCellBlock(sender.tag);
    }
}
- (IBAction)classClick:(UIButton *)sender {

    if (sender.tag == 0) {
        if (_stringCellBlock) {
            _stringCellBlock(@"http://106.14.114.49:8085/info.html?symbol=NASINDEX",@"纳斯达克");
        }
    }else if (sender.tag == 1) {
        if (_stringCellBlock) {
            _stringCellBlock(@"http://106.14.114.49:8085/info.html?symbol=HKG33INDEX",@"恒生指数");
        }
    }else if (sender.tag == 2) {
        if (_stringCellBlock) {
            _stringCellBlock(@"http://106.14.114.49:8085/info.html?symbol=000001",@"上证指数");
        }
    }else if (sender.tag == 3) {
        if (_stringCellBlock) {
            _stringCellBlock(@"http://106.14.114.49:8085/info.html?symbol=XAUUSD",@"黄金");
        }
    }else if (sender.tag == 4) {
        if (_stringCellBlock) {
            _stringCellBlock(@"http://106.14.114.49:8085/info.html?symbol=XAGUSD",@"白银");
        }
    }else if (sender.tag == 5) {
        if (_stringCellBlock) {
            _stringCellBlock(@"http://106.14.114.49:8085/info.html?symbol=XPTUSD",@"铂金");
        }
    }
}

- (void)setDataDic:(NSMutableDictionary *)dataDic {
    if (dataDic) {
        NSDictionary *dic1 = [dataDic objectForKey:@"NASINDEX"];
        NSDictionary *dic2 = [dataDic objectForKey:@"HKG33INDEX"];
        NSDictionary *dic3 = [dataDic objectForKey:@"000001"];
        
        self.name.text = [dic1 objectForKey:@"prodName"];
        self.price.text = [NSString stringWithFormat:@"%.2f",[[dic1 objectForKey:@"lastPx"]floatValue]];
        self.changeRate.text = [NSString stringWithFormat:@"%.2f",[[dic1 objectForKey:@"pxChangeRate"]floatValue]];
        
        self.name1.text = [dic2 objectForKey:@"prodName"];
        self.price1.text = [NSString stringWithFormat:@"%.2f",[[dic2 objectForKey:@"lastPx"]floatValue]];
        self.changeRate1.text = [NSString stringWithFormat:@"%.2f",[[dic2 objectForKey:@"pxChangeRate"]floatValue]];
        
        self.name2.text = [dic3 objectForKey:@"prodName"];
        self.price2.text = [NSString stringWithFormat:@"%.2f",[[dic3 objectForKey:@"lastPx"]floatValue]];
        self.changeRate2.text = [NSString stringWithFormat:@"%.2f",[[dic3 objectForKey:@"pxChangeRate"]floatValue]];
        
    }
    
}

- (void)setDataaDic:(NSMutableDictionary *)dataaDic {
    if (dataaDic) {
        NSDictionary *dic1 = [dataaDic objectForKey:@"XAUUSD"];
        NSDictionary *dic2 = [dataaDic objectForKey:@"XAGUSD"];
        NSDictionary *dic3 = [dataaDic objectForKey:@"XPTUSD"];
        
        self.name3.text = [dic1 objectForKey:@"prodName"];
        self.price3.text = [NSString stringWithFormat:@"%.2f",[[dic1 objectForKey:@"lastPx"]floatValue]];
        self.changeRate3.text = [NSString stringWithFormat:@"%.2f",[[dic1 objectForKey:@"pxChangeRate"]floatValue]];
        
        self.name4.text = [dic2 objectForKey:@"prodName"];
        self.price4.text = [NSString stringWithFormat:@"%.2f",[[dic2 objectForKey:@"lastPx"]floatValue]];
        self.changeRate4.text = [NSString stringWithFormat:@"%.2f",[[dic2 objectForKey:@"pxChangeRate"]floatValue]];
        
        self.name5.text = [dic3 objectForKey:@"prodName"];
        self.price5.text = [NSString stringWithFormat:@"%.2f",[[dic3 objectForKey:@"lastPx"]floatValue]];
        self.changeRate5.text = [NSString stringWithFormat:@"%.2f",[[dic3 objectForKey:@"pxChangeRate"]floatValue]];
    }
}

@end
