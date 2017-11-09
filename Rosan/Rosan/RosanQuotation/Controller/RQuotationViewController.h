//
//  RQuotationViewController.h
//  Rosan
//
//  Created by Levante on 2017/9/26.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RosanBsaeViewController.h"
#import "QuotationTableViewCell.h"

@interface RQuotationViewController : RosanBsaeViewController
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, copy)NSString *titleStr;
@property (nonatomic)NSInteger inter;

@end
