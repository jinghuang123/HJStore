//
//  HJGoodItemCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGridItem.h"
#import "HJRecommendModel.h"

@interface HJGoodItemCell : UICollectionViewCell

- (void)setItemCellWithItem:(HJRecommendModel *)item;
@end


@interface HJGoodItemSingleCell : UICollectionViewCell
- (void)setItemCellWithItem:(HJRecommendModel *)item;
@end
