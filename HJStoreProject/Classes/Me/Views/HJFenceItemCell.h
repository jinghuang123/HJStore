//
//  HJFenceItemCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJFenceModel.h"


@interface HJFenceItemCell : UITableViewCell
@property (nonatomic,copy) void(^itemDidSelected)(id obj);

- (void)updateContentWithFenceModel:(HJFenceModel *)fence;
@end

