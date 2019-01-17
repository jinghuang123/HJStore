//
//  HJProductDetailModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJProductDetailModel.h"

@implementation HJProductDetailModel

- (CGFloat)commission {
    return (([self.zk_final_price floatValue] - [self.coupon_value floatValue]) * [self.max_commission_rate floatValue])/10000;
}

- (CGFloat)earning {
    HJEarningModel *earn = [HJEarningModel shared];
    return (self.commission *  (100 - earn.taobao_service_fee)) * (100 - earn.app_service_fee) * earn.user_rate / (100 * 100 * 100);
}
@end
