//
//  RClassTableViewCell.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RClassTableViewCell.h"
#define LCScreenWidth     [[UIScreen mainScreen] bounds].size.width
#define LCScreenHeight    [[UIScreen mainScreen] bounds].size.height

@implementation RClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.with.constant = LCScreenWidth * 19 / 375;
    self.with1.constant = LCScreenWidth * 19 / 375;
    self.with2.constant = LCScreenWidth * 19 / 375;
    self.with3.constant = LCScreenWidth * 19 / 375;
    self.with4.constant = LCScreenWidth * 19 / 375;
    self.viewwith1.constant = LCScreenWidth * 70 / 375;
    self.viewwith2.constant = LCScreenWidth * 70 / 375;
    self.viewwith3.constant = LCScreenWidth * 70 / 375;
    self.viewwith4.constant = LCScreenWidth * 70 / 375;

}


- (IBAction)buttonClick:(UIButton *)sender {
    if (_classCellBlock) {
        _classCellBlock(sender.tag);
    }
}

@end
