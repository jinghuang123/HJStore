//
//  HJFenceRequest.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJFenceRequest.h"


@implementation HJFenceRequest

+ (instancetype)shared {
    static dispatch_once_t once;
    static HJFenceRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)getFenceListWithType:(NSInteger)type
                       success:(CompletionSuccessBlock)success
                          fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlGetAllChildren];
    if (type == 1) {
        url = [kHTTPManager getTokenUrl:kUrlGetChildren];
    }else if(type == 2) {
        url = [kHTTPManager getTokenUrl:kUrlGetRecommendChildren];
    }
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *fences = responseObject;
        NSArray *fenceModels = [HJFenceModel mj_objectArrayWithKeyValuesArray:fences];
        success(fenceModels);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}
@end
