//
//  HJSearchHotModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSearchHotModel.h"

@implementation HJSearchHotModel


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"hot_id":@"id",
             };
}
@end
