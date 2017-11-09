//
//  RCShopView.m
//  Rosan
//
//  Created by Levante on 2017/10/23.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RCShopView.h"

@implementation RCShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)moreClick:(UIButton *)sender {
    if (_moreBlock) {
        _moreBlock();
    }
}

@end
