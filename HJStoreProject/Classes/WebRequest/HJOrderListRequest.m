//
//  HJOrderListRequest.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJOrderListRequest.h"
#import "HJUserInfoModel.h"

@implementation HJOrderListRequest

+ (instancetype)shared {
    static dispatch_once_t once;
    static HJOrderListRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)getOrderListWithStatus:(NSInteger)status
                        PageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                       Success:(CompletionSuccessBlock)success
                          fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{
                          @"status":@(status),
                          @"pageNo":@(pageNo),
                          @"pageSize":@(pageSize),
                          };
    NSString *url = [kHTTPManager getTokenUrl:kURLGetOrderList];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}
@end
