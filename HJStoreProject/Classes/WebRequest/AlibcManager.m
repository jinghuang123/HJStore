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
        [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];//开发阶段打开日志开关，方便排查错误信息
        
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
    if(type == 0){
        showParam.openType = AlibcOpenTypeNative;
        showParam.backUrl = aliopenId;
        showParam.isNeedPush = NO;
        showParam.linkKey = @"taobao_scheme";//拉起淘宝
        showParam.nativeFailMode=AlibcNativeFailModeJumpDownloadPage;
        
    }else{
        showParam.openType = AlibcOpenTypeNative;
        showParam.backUrl = aliopenId;
        showParam.isNeedPush = YES;
        showParam.linkKey = @"tmall_scheme";//拉起天猫
    }
    NSLog(@"showParam %@",showParam);
    
    //    NSString *itemId = [NSString stringWithFormat:@"%ld",productId];
    
    
    
    //打开商品详情页
    //    id<AlibcTradePage> page = [AlibcTradePageFactory itemDetailPage:itemId];
    
    //    //添加商品到购物车
    //    id<AlibcTradePage> page = [AlibcTradePageFactory addCartPage: @"123456"];
    //
    //    //根据链接打开页面
//    url = @"https://uland.taobao.com/coupon/edetail?e=Hbm1TqAsaYQGQASttHIRqWKEsSqzwJ37%2BRUk6VVcjnFII08hgIYNwANsuTSkScbJevzI%2FQo1T713WG5EOOeoWW02%2F1k20DLubpZO0rSiF%2BIUdBQIEb3K%2BBemP0hpIIPvjDppvlX%2Bob8NlNJBuapvQ2MDg9t1zp0R8pjV3C9qcwRvxnR%2FP9frXPg1JsPjTcvU&traceId=0b14d34615463418465276399e&union_lens=lensId:0b156441_0cf5_16809280e2c_bb25";
    NSString *targetUrl = [NSString stringWithFormat:@"https:%@",url];
    id<AlibcTradePage> page = [AlibcTradePageFactory page:targetUrl];
    //
    //    //打开店铺
    //    id<AlibcTradePage> page = [AlibcTradePageFactory shopPage: @”12333333”];
    //
    //    //打开我的订单页
    //    id<AlibcTradePage> page = [AlibcTradePageFactory myOrdersPage:0 isAllOrder:YES];
    //
    //    //打开我的购物车
    //    id<AlibcTradePage> page = [AlibcTradePageFactory myCartsPage];
    NSDictionary *trackParam = [NSDictionary dictionary];
    AlibcTradeTaokeParams *taoKeParams=[[AlibcTradeTaokeParams alloc] init];
    taoKeParams.pid=@"mm_12549758_288100257_78712850490";
    if (webView) {
        ALiTradeWebViewController* view = [[ALiTradeWebViewController alloc] init];
        NSInteger res = [[AlibcTradeSDK sharedInstance].tradeService show:view webView:view.webView page:page showParams:showParam taoKeParams:taoKeParams trackParam:trackParam tradeProcessSuccessCallback:success tradeProcessFailedCallback:fail];
        if (res == 1) {
            [parentController.navigationController pushViewController:view animated:YES];
        }
    }else{
        [[AlibcTradeSDK sharedInstance].tradeService show:parentController page:page showParams:showParam taoKeParams:taoKeParams trackParam:trackParam tradeProcessSuccessCallback:success tradeProcessFailedCallback:fail];
    }
    
}
@end
