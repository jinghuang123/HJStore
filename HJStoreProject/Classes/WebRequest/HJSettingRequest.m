//
//  HJSettingRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSettingRequest.h"
#import "HJUserInfoModel.h"

@implementation HJSettingRequest

+ (instancetype)shared {
    static dispatch_once_t once;
    static HJSettingRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)uploadFile:(NSData *)data success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    [kHTTPManager tryPostImg:kURLFileUpload parameters:dic data:data success:^(NSURLSessionDataTask *operation, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        
    }];
}



- (void)getApplyCashListSuccess:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    [kHTTPManager setValueForHead:userInfo.token key:@"token"];
    [kHTTPManager tryPost:kURLGetApplyCashList parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}
@end
