//
//  RClassTableViewCell.h
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RClassTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *with4;

@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewwith1;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewwith2;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewwith3;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *viewwith4;
@property (nonatomic, strong)void(^classCellBlock)(NSInteger infoID);

@end
