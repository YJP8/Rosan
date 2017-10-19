//
//  RCalendarTableViewCell.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RCalendarTableViewCell.h"

@implementation RCalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    UIImageView *images = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    images.image = [UIImage imageNamed:@"XXXX"];
    [self.contentView addSubview:images];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
