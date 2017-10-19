//
//  RClassTableViewCell.m
//  Rosan
//
//  Created by Levante on 2017/9/27.
//  Copyright © 2017年 Levante. All rights reserved.
//

#import "RClassTableViewCell.h"
#import "RClassCollectionViewCell.h"
#define kCollectionViewCell @"cell"

@implementation RClassTableViewCell
{
    UICollectionViewFlowLayout *_flowLayout;
    NSArray *imageArray;
    NSArray *titleArray;
    NSString *inforID;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self creatCollectionView];
        imageArray = [NSArray arrayWithObjects:@"icon1",@"223",@"224",@"225",@"2251",@"226",@"227",@"228", nil];
        titleArray = [NSArray arrayWithObjects:@"全球资讯",@"财经日历",@"财经直播",@"数据中心",@"行情中心",@"外汇汇率",@"上证指数",@"恒生指数",nil];
    }
    return self;
    
}
-(void)creatCollectionView
{
    _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _flowLayout.minimumLineSpacing = 0;
    _flowLayout.minimumInteritemSpacing = 0;
    _flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    CGRect collectioViewFrame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 150);
    self.collectionview = [[UICollectionView alloc] initWithFrame:collectioViewFrame collectionViewLayout:_flowLayout];
    self.collectionview.backgroundColor = [UIColor whiteColor];
    [self.collectionview registerClass:[RClassCollectionViewCell class] forCellWithReuseIdentifier:kCollectionViewCell];
    self.collectionview.showsVerticalScrollIndicator = NO;
    self.collectionview.delegate= self;
    self.collectionview.dataSource = self;
    [self.contentView addSubview:self.collectionview];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(93.75*[UIScreen mainScreen].bounds.size.width/375,75);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    RClassCollectionViewCell *cell = (RClassCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    NSString *image_icon = imageArray[indexPath.row];
    cell.icon_img.image = [UIImage imageNamed:image_icon];
    cell.name_title.text = titleArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_classCellBlock) {
        _classCellBlock(indexPath.row);
    };
}
- (void)awakeFromNib {
    [super awakeFromNib];

}

@end
