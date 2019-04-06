//
//  HJWeiquanModel.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJWeiquanModel.h"

@implementation HJWeiquanModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"weiquanId":@"id",
             };
}
@end
