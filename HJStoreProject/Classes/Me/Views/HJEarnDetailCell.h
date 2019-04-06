//
//  HJEarnDetailCell.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/30.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJDrawalRecordModel.h"


@interface HJEarnDetailCell : UITableViewCell
- (void)updateContentWithModel:(HJDrawalRecordModel *)model;
@end


