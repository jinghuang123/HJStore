//
//  HJRecommendModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJRecommendModel.h"
#import "HJUserInfoModel.h"

@implementation HJSmallImageModel

@end

@implementation HJRecommendModel


- (CGFloat)commission {
    CGFloat payedMoney = [self coupon_after_price];
    CGFloat commissionvalue = payedMoney * self.commission_rate/10000.0; // 总佣金
    return commissionvalue * 0.9; //////总佣金 - 平台10%
}

- (CGFloat)earning {
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    HJEarningModel *earn = [HJEarningModel getSavedEarnConfiger];
    if(userInfo && userInfo.token.length > 0) {
        if(userInfo.group_id == 1){
            ///超级会员预估收益
            return self.commission * [self rateOfGroup1:earn]/100;
        }else if(userInfo.group_id == 2){
            ///运营商预估收益
            return self.commission * [self rateOfGroup2:earn]/100;
        }else {
            return self.commission * 0.5;
        }
    }else{
        return self.commission * 0.5;
    }
}

- (CGFloat)rateOfGroup1:(HJEarningModel *)earn {
    return earn.user_rate;
}

- (CGFloat)rateOfGroup2:(HJEarningModel *)earn {
    return earn.user_rate + earn.parent_user_rate + earn.parent_parent_user_rate;
}

- (CGFloat)coupon_after_price {
    return [self.zk_final_price floatValue] - [self.coupon_amount floatValue];
}

@end
