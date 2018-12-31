//
//  HJRecommendModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJRecommendModel : NSObject
@property (nonatomic , assign) NSInteger          product_id;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * pict_url_image; //商品主图
@property (nonatomic , assign) NSInteger            user_type; //卖家类型:0=淘宝,1=天猫
@property (nonatomic , copy) NSString              * reserve_price; //商品一口价格
@property (nonatomic , copy) NSString              * zk_final_price; //商品折扣价格
@property (nonatomic , assign) NSInteger              volume; //销量
@property (nonatomic , copy) NSString              * max_commission_rate; //佣金比率
@property (nonatomic , copy) NSString              * coupon_value; //优惠券金额
@end

