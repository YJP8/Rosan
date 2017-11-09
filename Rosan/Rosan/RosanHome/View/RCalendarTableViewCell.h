//
//  RCalendarTableViewCell.h
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RCalendarTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) IBOutlet UILabel *changeRate;

@property (strong, nonatomic) IBOutlet UILabel *name1;
@property (strong, nonatomic) IBOutlet UILabel *price1;
@property (strong, nonatomic) IBOutlet UILabel *changeRate1;

@property (strong, nonatomic) IBOutlet UILabel *name2;
@property (strong, nonatomic) IBOutlet UILabel *price2;
@property (strong, nonatomic) IBOutlet UILabel *changeRate2;

@property (strong, nonatomic) IBOutlet UILabel *name3;
@property (strong, nonatomic) IBOutlet UILabel *price3;
@property (strong, nonatomic) IBOutlet UILabel *changeRate3;

@property (strong, nonatomic) IBOutlet UILabel *name4;
@property (strong, nonatomic) IBOutlet UILabel *price4;
@property (strong, nonatomic) IBOutlet UILabel *changeRate4;

@property (strong, nonatomic) IBOutlet UILabel *name5;
@property (strong, nonatomic) IBOutlet UILabel *price5;
@property (strong, nonatomic) IBOutlet UILabel *changeRate5;

@property (nonatomic, strong)void(^classCellBlock)(NSInteger infoID);
@property (nonatomic, strong)void(^stringCellBlock)(NSString *url,NSString *name);

@property (nonatomic, strong)NSMutableDictionary *dataDic;
@property (nonatomic, strong)NSMutableDictionary *dataaDic;


@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with4;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with5;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with6;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with7;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with8;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with9;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with10;




@end
