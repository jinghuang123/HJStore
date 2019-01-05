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
@end
