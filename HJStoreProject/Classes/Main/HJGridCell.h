//
//  HJGridCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCategoryModel.h"
#import "HJActivityModel.h"


#define itemsize  MaxWidth == ENM_SCREEN_W_5S ? 35 : 42

@interface HJGridCell : UICollectionViewCell

- (void)updeteCellWithGridItem:(HJSubCategoryModel *)category;

- (void)updeteCellWithActivityItem:(HJActivityModel *)activity;

@end


