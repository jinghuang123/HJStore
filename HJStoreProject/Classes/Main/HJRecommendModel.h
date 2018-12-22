//
//  HJRecommendModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJRecommendModel : NSObject
@property (nonatomic, assign) NSInteger channel_id;
@property (nonatomic, strong) NSString *coupon;
@property (nonatomic, strong) NSString *earnSum;
@property (nonatomic, strong) NSString *image;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, assign) NSInteger product_id;
@property (nonatomic, strong) NSString *rebate_price;
@property (nonatomic, assign) NSInteger sold_count;
@property (nonatomic, strong) NSString *store_name;
@property (nonatomic, strong) NSString *stote_logo;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *updatetime;
@end

