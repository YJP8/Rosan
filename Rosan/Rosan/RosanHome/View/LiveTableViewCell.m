//
//  LiveTableViewCell.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "LiveTableViewCell.h"

@implementation LiveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.view.backgroundColor = [[UIColor lightGrayColor]colorWithAlphaComponent:0.5];
}

@end
