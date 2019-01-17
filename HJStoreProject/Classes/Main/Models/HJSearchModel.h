//
//  HJSearchModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//



#import <Foundation/Foundation.h>

@interface HJSmallImageModel :NSObject
@property (nonatomic , strong) NSArray <NSString *>              *string;
@end

@interface HJSearchModel : NSObject
@property (nonatomic , assign) NSInteger              category_id;
@property (nonatomic , copy) NSString              * category_name;
@property (nonatomic , copy) NSString              * commission_rate;
@property (nonatomic , copy) NSString              * commission_type;
@property (nonatomic , copy) NSString              * coupon_end_time;
@property (nonatomic , copy) NSString              * coupon_id;
@property (nonatomic , copy) NSString              * coupon_info;
@property (nonatomic , assign) NSInteger              coupon_remain_count;
@property (nonatomic , copy) NSString              * coupon_share_url;
@property (nonatomic , copy) NSString              * coupon_start_time;
@property (nonatomic , assign) NSInteger              coupon_total_count;
@property (nonatomic , copy) NSString              * include_dxjh;
@property (nonatomic , copy) NSString              * include_mkt;
@property (nonatomic , copy) NSString              * info_dxjh;
@property (nonatomic , copy) NSString              * item_url;
@property (nonatomic , assign) NSInteger              level_one_category_id;
@property (nonatomic , copy) NSString              * level_one_category_name;
@property (nonatomic , assign) NSInteger              num_iid;
@property (nonatomic , copy) NSString              * pict_url;
@property (nonatomic , copy) NSString              * provcity;
@property (nonatomic , copy) NSString              * reserve_price;
@property (nonatomic , assign) NSInteger              seller_id;
@property (nonatomic , assign) NSInteger              shop_dsr;
@property (nonatomic , copy) NSString              * shop_title;
@property (nonatomic , copy) NSString              * short_title;
@property (nonatomic , strong) HJSmallImageModel        *small_images;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * tk_total_commi;
@property (nonatomic , copy) NSString              * tk_total_sales;
@property (nonatomic , copy) NSString              * url;
@property (nonatomic , assign) NSInteger              user_type;
@property (nonatomic , assign) NSInteger              volume;
@property (nonatomic , copy) NSString              * white_image;
@property (nonatomic , copy) NSString              * zk_final_price;
@property (nonatomic , copy) NSString  *coupon_value;

@property (nonatomic , assign) CGFloat    commission; ///佣金
@property (nonatomic , assign) CGFloat    earning; ///收益
@end

