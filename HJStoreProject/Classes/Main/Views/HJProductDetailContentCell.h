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

- (void)setcontentWithModel:(HJProductDetailModel *)item;
@end


@interface HJProductDetailCell : UITableViewCell
@property (nonatomic,copy) cellItemClick openCellBlock;
@end

@interface HJProductDetailTipCell : UITableViewCell
@end


@interface HJGoodItemsSingleCell : UITableViewCell
- (void)setItemCellWithItem:(HJRecommendModel *)item;
@end