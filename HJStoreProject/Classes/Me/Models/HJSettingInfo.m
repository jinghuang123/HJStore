//
//  HJSettingInfo.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/13.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSettingInfo.h"

@implementation HJZfbInfo
@end

@implementation HJSettingInfo

+ (HJSettingInfo *)shared {
    static dispatch_once_t once;
    static HJSettingInfo *settingInfo;
    dispatch_once( &once, ^{
        settingInfo = [[self alloc] init];
    });
    return settingInfo;
}



+ (NSDictionary *)mj_objectClassInArray {
    return @{@"zfb":[HJZfbInfo class],
             };
}
@end
