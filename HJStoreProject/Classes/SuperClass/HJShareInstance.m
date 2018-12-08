//
//  HJShareInstance.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJShareInstance.h"

@implementation HJShareInstance

+ (instancetype)shareInstance {
    static HJShareInstance *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[HJShareInstance alloc] init];
    });
    return instance;
}

@end
