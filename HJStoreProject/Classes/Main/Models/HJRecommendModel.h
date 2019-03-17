//
//  HJRecommendModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJSmallImageModel : NSObject
@property (nonatomic , strong) NSArray <NSString *>              *string;
@end


@interface HJRecommendModel : NSObject
//@property (nonatomic , assign) NSInteger          product_id;
//@property (nonatomic , copy) NSString              * title;
//@property (nonatomic , copy) NSString              * pict_url_image; //商品主图
//@property (nonatomic , assign) NSInteger            user_type; //卖家类型:0=淘宝,1=天猫
//@property (nonatomic , copy) NSString              * reserve_price; //商品一口价格
//@property (nonatomic , copy) NSString              * zk_final_price; //商品折扣价格
//@property (nonatomic , assign) NSInteger              volume; //销量
//@property (nonatomic , copy) NSString              * max_commission_rate; //佣金比率
//@property (nonatomic , copy) NSString              * coupon_value; //优惠券金额
//@property (nonatomic , copy) NSString              * coupon_after_price; //卷后价格
//
//
//@property (nonatomic , assign) CGFloat    commission; ///佣金
//@property (nonatomic , assign) CGFloat    earning; ///收益


@property (nonatomic , copy) NSString              * item_id; //商品信息-宝贝id
@property (nonatomic , copy) NSString              * coupon_start_time; //优惠券信息-优惠券开始时间
@property (nonatomic , copy) NSString              * coupon_end_time;  //优惠券信息-优惠券结束时间
@property (nonatomic , copy) NSString              * info_dxjh;  //商品信息-定向计划信息
@property (nonatomic , assign) NSInteger              tk_total_sales; //商品信息-淘客30天推广量
@property (nonatomic , copy) NSString              * coupon_id; //优惠券信息-优惠券id
@property (nonatomic , copy) NSString              * title;  //商品信息-商品标题
@property (nonatomic , copy) NSString              * pict_url; //商品信息-商品主图
@property (nonatomic , strong) NSArray <NSString *>              *small_images; //商品信息-商品小图列表
@property (nonatomic , copy) NSString              * reserve_price;  //商品信息-商品一口价格
@property (nonatomic , copy) NSString              * zk_final_price;  //商品信息-商品折扣价格
@property (nonatomic , copy) NSString              * user_type;  //店铺信息-卖家类型。0表示集市，1表示天猫
@property (nonatomic , copy) NSString              * provcity; //商品信息-宝贝所在地
@property (nonatomic , copy) NSString              * item_url; //链接-宝贝地址
@property (nonatomic , copy) NSString              * include_mkt; //商品信息-是否包含营销计划
@property (nonatomic , copy) NSString              * include_dxjh;  //商品信息-是否包含定向计划
@property (nonatomic , assign) NSInteger              commission_rate;  //商品信息-佣金比率。1550表示15.5%
@property (nonatomic , assign) NSInteger              volume;  //商品信息-30天销量
@property (nonatomic , copy) NSString              * seller_id;  //店铺信息-卖家id
@property (nonatomic , assign) NSInteger              coupon_total_count; //优惠券信息-优惠券总量
@property (nonatomic , assign) NSInteger              coupon_remain_count;  //优惠券信息-优惠券剩余量
@property (nonatomic , copy) NSString              * coupon_info;  //优惠券信息-优惠券满减信息
@property (nonatomic , copy) NSString              * commission_type;  ///商品信息-佣金类型。MKT表示营销计划，SP表示定向计划，COMMON表示通用计划
@property (nonatomic , copy) NSString              * shop_title; //店铺信息-店铺名称
@property (nonatomic , assign) NSInteger              shop_dsr; //店铺信息-店铺dsr评分
@property (nonatomic , copy) NSString              * level_one_category_name; //商品信息-一级类目名称
@property (nonatomic , copy) NSString              * category_name; //商品信息-一级类目ID
@property (nonatomic , copy) NSString              * coupon_start_fee; //优惠券信息-优惠券起用门槛，满X元可用。如：满299元减20元
@property (nonatomic , copy) NSString              * coupon_amount; //优惠券信息-优惠券面额。如：满299元减20元
@property (nonatomic , copy) NSString              * item_description; //商品信息-宝贝描述(推荐理由)
@property (nonatomic , copy) NSString              * nick; //店铺信息-卖家昵称
@property (nonatomic , copy) NSString              *coupon_share_url; //链接-宝贝+券二合一页面链接
@property (nonatomic , assign) NSInteger              taobao_category_id;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , assign) CGFloat             coupon_after_price;
@property (nonatomic , assign) CGFloat    earning; ///收益
@property (nonatomic , assign) CGFloat    commission; ///佣金
@end

