//
//  HJSearchModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSearchModel.h"
@implementation HJSmallImageModel
@end



@implementation HJSearchModel
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"small_images":[HJSmallImageModel class],
             };
}

- (NSString *)coupon_value {
    if (self.coupon_info.length > 0) {
        NSString *numberPattern = @"[+-]?\\d+(\\.\\d+)?";
        NSError *error = NULL;
        NSRegularExpression *regex =
        [NSRegularExpression regularExpressionWithPattern:numberPattern
                                                  options:NSRegularExpressionCaseInsensitive
                                                    error:&error];
        NSArray *matches = [regex matchesInString:self.coupon_info options:0 range:NSMakeRange(0, self.coupon_info.length)];
        NSString *matStr = @"0";
        for (NSTextCheckingResult *match in matches) {
            NSRange matchRange = [match range];
            NSLog(@"%@:%ld:%ld",self.coupon_info,matchRange.location,matchRange.length);
            matStr = [self.coupon_info substringWithRange:matchRange];
        }
        return matStr;
    }else{
        return @"0";
    }
    
}


- (CGFloat)commission {
    return (([self.zk_final_price floatValue] - [self.coupon_value floatValue]) * [self.commission_rate floatValue])/10000;
}

- (CGFloat)earning {
    HJEarningModel *earn = [HJEarningModel shared];
    return (self.commission *  (100 - earn.taobao_service_fee)) * (100 - earn.app_service_fee) * earn.user_rate / (100 * 100 * 100);
}
@end
