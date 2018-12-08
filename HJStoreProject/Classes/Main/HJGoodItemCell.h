//
//  HJGoodItemCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGridItem.h"


@interface HJGoodItemCell : UICollectionViewCell
/* 相同 */
@property (strong , nonatomic)UIButton *sameButton;

/** 找相似点击回调 */
@property (nonatomic, copy) dispatch_block_t lookSameBlock;

- (void)setItemCellWithItem:(HJRecommendItem *)item;
@end


