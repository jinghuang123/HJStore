//
//  HJProductDetailModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJRecommendModel.h"


@interface HJProductDetailModel : NSObject
@property (nonatomic , assign) NSInteger            product_id;
@property (nonatomic , assign) NSInteger              channel_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * pict_url_image;
@property (nonatomic , assign) NSInteger           user_type;
@property (nonatomic , copy) NSString              * reserve_price;
@property (nonatomic , copy) NSString              * zk_final_price;
@property (nonatomic , assign) NSInteger              volume;
@property (nonatomic , copy) NSString              * nick;
@property (nonatomic , copy) NSString              * max_commission_rate;
@property (nonatomic , copy) NSString              * coupon_type;
@property (nonatomic , copy) NSString              * coupon_value;
@property (nonatomic , copy) NSString              * is_collection;
@property (nonatomic , assign) NSInteger              weigh;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , strong) NSArray <NSString *>              *small_images;
@property (nonatomic , copy) NSString              * item_url;
@property (nonatomic , copy) NSString              * tk_item_url;
@property (nonatomic , copy) NSString              * seller_id;
@property (nonatomic , copy) NSString              * coupon_info;
@property (nonatomic , assign) NSInteger              coupon_total_count;
@property (nonatomic , assign) NSInteger              coupon_remain_count;
@property (nonatomic , copy) NSString              * coupon_click_url;
@property (nonatomic , copy) NSString              * mm_coupon_info;
@property (nonatomic , assign) NSInteger              mm_coupon_remain_count;


@property (nonatomic , assign) CGFloat    commission; ///佣金
@property (nonatomic , assign) CGFloat    earning; ///收益
@end

