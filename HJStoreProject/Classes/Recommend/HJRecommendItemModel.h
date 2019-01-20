//
//  HJRecommendItemModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/19.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsItem :NSObject
@property (nonatomic , copy) NSString              * product_id;
@property (nonatomic , copy) NSString              * pict_url_image;
@property (nonatomic , copy) NSString              * coupon_after_price;
@property (nonatomic , assign) NSInteger              max_commission_rate;

@end





@interface HJRecommendItemModel : NSObject
@property (nonatomic , assign) NSInteger              itemId;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , assign) NSInteger              share;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , strong) NSArray <GoodsItem *>              * goods;
@property (nonatomic , copy) NSString              * type;
@property (nonatomic , assign) NSInteger              goods_count;
@end

