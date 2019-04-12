//
//  HJShareInstance.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>
#import "HJWechatUserModel.h"

typedef void(^HJShareSDKCallback)(NSString *errorMsg);

@interface HJShareInstance : NSObject
+ (instancetype)shareInstance;
- (void)registerShareSDK;


- (void)shareToWeiboWithImages:(NSArray *)images callback:(HJShareSDKCallback)callback;

- (void)shareToQQ:(BOOL)toQZone images:(NSArray *)images callback:(HJShareSDKCallback)callback;

- (void)shareToWechat:(BOOL)toSession images:(NSArray *)images callback:(HJShareSDKCallback)callback;

- (void)getUserInfoForWechatSuccess:(CompletionSuccessBlock)suc;
@end


