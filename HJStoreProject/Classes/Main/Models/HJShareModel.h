//
//  HJShareModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJShareModel : NSObject
@property (nonatomic , copy) NSString *product_id;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *url;
@property (nonatomic , copy) NSString *reserve_price;
@property (nonatomic , copy) NSString *zk_final_price;
@property (nonatomic , copy) NSString *coupon_value;
@property (nonatomic , copy) NSString *model;
@property (nonatomic, assign) BOOL showCoupon;
@property (nonatomic, strong) UIImage *mainImage;
@property (nonatomic, strong) NSArray *images;
@end


