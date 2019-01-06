//
//  HJShareInstance.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#define qqAppID @""
#define qqKey @""

#define wechatAppID @""
#define wechatSecret @""

#define sinaKey @""
#define sinaSecret @""

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

- (void)registerShareSDK {
    [ShareSDK registPlatforms:^(SSDKRegister *platformsRegister) {
        //QQ
        [platformsRegister setupQQWithAppId:qqAppID appkey:qqKey];
        
        //微信
        [platformsRegister setupWeChatWithAppId:wechatAppID appSecret:wechatSecret];
        
        //新浪
        [platformsRegister setupSinaWeiboWithAppkey:sinaKey appSecret:@"38a4f8204cc784f81f9f0daaf31e02e3" redirectUrl:sinaSecret];
        
    }];
}

@end
