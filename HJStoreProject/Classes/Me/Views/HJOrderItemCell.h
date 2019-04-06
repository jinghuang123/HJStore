//
//  HJOrderItemCell.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJOrderListItemModel.h"


@interface HJOrderItemCell : UITableViewCell
- (void)updateWithOrderItem:(HJOrderListItemModel *)order;
@end


