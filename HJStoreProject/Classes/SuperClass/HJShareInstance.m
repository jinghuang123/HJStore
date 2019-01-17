//
//  HJShareInstance.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#define qqAppID @"1108088074"
#define qqKey @"Ic9hWiOdUmDx4inR"

#define wechatAppID @"wxc5798db4358400b7"
#define wechatSecret @"ceda4cb767a7cf1ff4e759cceb81631e"

#define sinaKey @"3994717529"
#define sinaSecret @"4e1fea2563231b2ecf72c2a8cbcc00c6"


#define shareTitle @"美值"

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
        [platformsRegister setupSinaWeiboWithAppkey:sinaKey appSecret:sinaSecret redirectUrl:@"https://baidu.com"];
        
    }];
}

- (void)shareToWeiboWithImages:(NSArray *)images callback:(HJShareSDKCallback)callback{
    SSDKPlatformType platform = SSDKPlatformTypeSinaWeibo;
    [self shareToSDKPlatformType:platform title:shareTitle text:@"" images:images url:@"https://www.mob.com" callback:callback];
}

- (void)shareToQQ:(BOOL)toQZone images:(NSArray *)images callback:(HJShareSDKCallback)callback{
    SSDKPlatformType platform = toQZone ? SSDKPlatformSubTypeQZone : SSDKPlatformSubTypeQQFriend;
    [self shareToSDKPlatformType:platform title:shareTitle text:@"" images:images url:@"https://www.mob.com" callback:callback];
}

- (void)shareToWechat:(BOOL)toSession images:(NSArray *)images callback:(HJShareSDKCallback)callback{
    SSDKPlatformType platform = toSession ? SSDKPlatformSubTypeWechatSession : SSDKPlatformSubTypeWechatTimeline;
    [self shareToSDKPlatformType:platform title:shareTitle text:@"" images:images url:@"https://www.mob.com" callback:callback];
}

- (void)shareToSDKPlatformType:(SSDKPlatformType)platform
                        title:(NSString *)title
                         text:(NSString *)text
                        images:(NSArray *)images
                          url:(NSString *)urlString
                     callback:(HJShareSDKCallback)callback {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSURL *url = ([urlString length] > 0) ? [NSURL URLWithString:urlString] : nil;
    
    [params SSDKSetupShareParamsByText:text
                                images:images
                                   url:url
                                 title:title
                                  type:SSDKContentTypeImage];
    [self shareToPlatform:platform parameters:params callback:callback];
}

- (void)shareToPlatform:(SSDKPlatformType)platform parameters:(NSMutableDictionary *)parameters callback:(HJShareSDKCallback)callback {
    [ShareSDK share:platform parameters:parameters onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateFail:
                if (error.code == 208) {
                    callback(@"未安装");
                }
                else {
                    NSLog(@"error descriction %@",[error description]);
                    callback(@"分享失败");
                }
                break;
            case SSDKResponseStateCancel:
                callback(@"取消分享");
                break;
            case SSDKResponseStateSuccess:
                callback(nil);
                break;
            case SSDKResponseStateBegin:
                break;
            default:
                break;
        }
    }];
}


@end
