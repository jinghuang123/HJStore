//
//  HJSettingRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSettingRequest.h"

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

- (void)getApplyCashListSuccess:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    [kHTTPManager tryPost:kURLGetApplyCashList parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}
@end
