//
//  RClassTableViewCell.h
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RClassTableViewCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong)UICollectionView *collectionview;
@property (nonatomic, strong)void(^classCellBlock)(NSInteger infoID);

@end
