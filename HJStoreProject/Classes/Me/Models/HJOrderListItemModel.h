//
//  HJOrderListItemModel.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJOrderListItemModel :NSObject
@property (nonatomic , assign) NSInteger              adzone_id;
@property (nonatomic , copy) NSString              * adzone_name;
@property (nonatomic , copy) NSString              * alipay_total_price;
@property (nonatomic , copy) NSString              * auction_category;
@property (nonatomic , copy) NSString              * click_time;
@property (nonatomic , copy) NSString              * commission;
@property (nonatomic , copy) NSString              * commission_rate;
@property (nonatomic , copy) NSString              * create_time;
@property (nonatomic , copy) NSString              * earning_time;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * income_rate;
@property (nonatomic , assign) NSInteger              item_num;
@property (nonatomic , copy) NSString              * item_title;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , assign) NSInteger              num_iid;
@property (nonatomic , copy) NSString              * order_type;
@property (nonatomic , copy) NSString              * pay_price;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * pub_share_pre_fee;
@property (nonatomic , copy) NSString              * relation_id;
@property (nonatomic , copy) NSString              * seller_nick;
@property (nonatomic , copy) NSString              * seller_shop_title;
@property (nonatomic , assign) NSInteger              site_id;
@property (nonatomic , copy) NSString              * site_name;
@property (nonatomic , assign) NSInteger              special_id;
@property (nonatomic , copy) NSString              * subsidy_fee;
@property (nonatomic , copy) NSString              * subsidy_rate;
@property (nonatomic , copy) NSString              * subsidy_type;
@property (nonatomic , copy) NSString              * terminal_type;
@property (nonatomic , copy) NSString              * tk3rd_pub_id;
@property (nonatomic , copy) NSString              * tk3rd_type;
@property (nonatomic , assign) NSInteger              tk_status;
@property (nonatomic , copy) NSString              * total_commission_fee;
@property (nonatomic , copy) NSString              * total_commission_rate;
@property (nonatomic , copy) NSString              * trade_id;
@property (nonatomic , assign) NSInteger              trade_parent_id;

@end


