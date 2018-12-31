//
//  HJCategoryModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/14.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJCategoryModel.h"

@implementation HJCategoryModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"categoryId":@"id",
             };
}

@end

