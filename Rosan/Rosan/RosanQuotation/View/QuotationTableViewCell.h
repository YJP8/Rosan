//
//  QuotationTableViewCell.h
//  Rosan
//
//  Created by Levante on 2017/10/23.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuotationTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *change;
@property (strong, nonatomic) IBOutlet UILabel *changeRage;
@property (strong, nonatomic) IBOutlet UILabel *yesterday;

@end
