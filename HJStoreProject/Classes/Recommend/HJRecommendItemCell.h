//
//  HJRecommendItemCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/19.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJRecommendItemModel.h"


@interface HJRecommendItemCell : UITableViewCell <UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageV;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *shareView;
@property (weak, nonatomic) IBOutlet UILabel *shareCountLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet UILabel *earningLabel;
@property (nonatomic, strong) HJRecommendItemModel *model;

@property (nonatomic,copy) void(^itemDidSelected)(GoodsItem *item);
@property (nonatomic,copy) void(^shareClickBlock)(GoodsItem *item);
@end


