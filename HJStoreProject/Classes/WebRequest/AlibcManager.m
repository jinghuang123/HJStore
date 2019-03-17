//
//  AlibcManager.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "AlibcManager.h"





@interface AlibcManager()
@property (nonatomic, strong) AlibcTradeTaokeParams *taokeParams;
@end

@implementation AlibcManager

+ (instancetype)shared {
    static dispatch_once_t once;
    static AlibcManager *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
        [[AlibcTradeSDK sharedInstance] setDebugLogOpen:NO];//开发阶段打开日志开关，方便排查错误信息
        
        [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
            
        } failure:^(NSError *error) {
            
        }];
        // 设置全局配置，是否强制使用h5
        [[AlibcTradeSDK sharedInstance] setIsForceH5:NO];
        
        [self setTaokeWithPid:@"mm_12549758_288100257_78712850490"];
    }
    return self;
}


- (void)setTaokeWithPid:(NSString *)pid {
    //////淘客账号pid服务端给
    AlibcTradeTaokeParams *taokeParams = [[AlibcTradeTaokeParams alloc] init];
    _taokeParams = taokeParams;
    taokeParams.pid = pid; //mm_XXXXX为你自己申请的阿里妈妈淘客pid
    [[AlibcTradeSDK sharedInstance] setTaokeParams:taokeParams];
}

- (void)showWithAliSDKByParamsType:(NSInteger)type
                  parentController:(UIViewController *)parentController
                           webView:(UIWebView *)webView
                               url:(NSString *)url
                           success:(AlibcTradeProcessSuccessCallback)success
                              fail:(AlibcTradeProcessFailedCallback)fail {
    AlibcTradeShowParams* showParam = [[AlibcTradeShowParams alloc] init];
    if (webView) {
        showParam.openType = AlibcOpenTypeH5;
    }else{
        if(type == 0){
            showParam.openType = AlibcOpenTypeNative;
            showParam.backUrl = aliopenId;
            showParam.isNeedPush = YES;
            showParam.linkKey = @"taobao_scheme";//拉起淘宝
            showParam.nativeFailMode=AlibcNativeFailModeJumpH5;
        }else{
            showParam.openType = AlibcOpenTypeNative;
            showParam.backUrl = aliopenId;
            showParam.isNeedPush = YES;
            showParam.linkKey = @"tmall_scheme";//拉起天猫
            showParam.nativeFailMode=AlibcNativeFailModeJumpH5;
        }
    }

    NSLog(@"showParam %@",showParam);
    NSString *targetUrl = [url containsString:@"https"] ? url : [NSString stringWithFormat:@"https:%@",url];
    id<AlibcTradePage> page = [AlibcTradePageFactory page:targetUrl];

    NSDictionary *trackParam = [NSDictionary dictionary];
    AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
    taoKeParams.pid=@"mm_12549758_288100257_78712850490";
    if (webView) {
        ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
        view.hidesBottomBarWhenPushed = YES;
        NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:view webView:view.webView page:page showParams:showParam taoKeParams:taoKeParams trackParam:trackParam tradeProcessSuccessCallback:success tradeProcessFailedCallback:fail];
        if (res == 1) {
            [parentController.navigationController pushViewController:view animated:YES];
        }
    }else{
        [[AlibcTradeSDK sharedInstance].tradeService show:parentController page:page showParams:showParam taoKeParams:taoKeParams trackParam:trackParam tradeProcessSuccessCallback:success tradeProcessFailedCallback:fail];
    }
    
}
@end
