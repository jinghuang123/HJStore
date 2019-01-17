//
//  HJRecommendModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJRecommendModel.h"

@implementation HJRecommendModel

- (CGFloat)commission {
    CGFloat commissionvalue = (([self.zk_final_price floatValue] - [self.coupon_value floatValue]) * [self.max_commission_rate floatValue])/10000.0;
    return commissionvalue;
}

- (CGFloat)earning {
    HJEarningModel *earn = [HJEarningModel shared];
    return (self.commission *  (100 - earn.taobao_service_fee)) * (100 - earn.app_service_fee) * earn.user_rate / (100 * 100 * 100);
}
@end
