//
//  HJRecommendVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJRecommendRequest.h"


@interface HJRecommendVC : HJSuperViewController
@property (nonatomic,strong) HJRecommendCategorys *category;
@property (nonatomic,copy) void(^itemDidSelected)(GoodsItem *item);

@end

