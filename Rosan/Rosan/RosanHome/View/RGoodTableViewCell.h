//
//  RGoodTableViewCell.h
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RGoodTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *thumb;
@property (strong, nonatomic) IBOutlet UILabel *addtime;
@property (strong, nonatomic) IBOutlet UILabel *titles;
@property (strong, nonatomic) IBOutlet UILabel *tags;

@end
