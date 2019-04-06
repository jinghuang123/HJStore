//
//  HJEarnDetailVC.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"

typedef enum : NSUInteger {
    HJEarnDetailListTypeEarn,
    HJEarnDetailListTypeOrder,
} HJEarnDetailListType;


@interface HJWeiquanCell : UITableViewCell

@end

@interface HJSettlementCell : UITableViewCell

@end

@interface HJEarnDetailVC : HJSuperViewController
@property (nonatomic, assign) HJEarnDetailListType type;
@end


