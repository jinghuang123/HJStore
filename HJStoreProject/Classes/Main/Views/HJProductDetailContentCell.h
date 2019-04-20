//
//  HJProductDetailContentCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJProductDetailModel.h"
#import "HJSuperView.h"
#import "HJRecommendModel.h"


@interface HJProductDetailContentCell : UITableViewCell
@property (nonatomic,copy) cellItemClick collectionSaveBlock;
@property (nonatomic,copy) cellItemClick shareToEarnBlock;
@property (nonatomic,copy) cellItemClick conponGetBlock;
- (void)setcontentWithModel:(HJRecommendModel *)item;
- (void)setIffavourite:(BOOL)favourite;
@end


@interface HJProductDetailCell : UITableViewCell
@property (nonatomic,copy) cellItemClick openCellBlock;
@end

@interface HJProductDetailTipCell : UITableViewCell
@end


@interface HJGoodItemsSingleCell : UITableViewCell
- (void)setItemCellWithItem:(HJRecommendModel *)item;
@end
