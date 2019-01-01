//
//  AlibcManager.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "UTMini/AppMonitor.h"
#import <UTMini/AppMonitor.h>
#import "ALiTradeWebViewController.h"

@interface AlibcManager : NSObject
+ (instancetype)shared;

- (void)setTaokeWithPid:(NSString *)pid;

- (void)showWithAliSDKByParamsType:(NSInteger)type
                  parentController:(UIViewController *)parentController
                           webView:(UIWebView *)webView
                         productId:(NSInteger)productId
                           success:(AlibcTradeProcessSuccessCallback)success
                              fail:(AlibcTradeProcessFailedCallback)fail;
@end

