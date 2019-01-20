//
//  HJRecommendRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/19.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJRecommendRequest.h"

@implementation HJRecommendRequest
+ (instancetype)shared {
    static dispatch_once_t once;
    static HJRecommendRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)getRecommendCategorysWithId:(NSString *)categoryId
                            success:(CompletionSuccessBlock)success
                               fail:(CompletionFailBlock)fail {
    NSDictionary *params = @{@"categoryid":categoryId};
    [kHTTPManager tryPost:kUrlRecommendTitles parameters:params success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *categorys = [HJRecommendCategorys mj_objectArrayWithKeyValuesArray:responseObject];
        success(categorys);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}


- (void)getRecommendListWithId:(NSString *)categoryId
                        pageNo:(NSInteger)pageNo
                      pageSize:(NSInteger)pageSize
                            success:(CompletionSuccessBlock)success
                               fail:(CompletionFailBlock)fail {
    NSDictionary *params = @{@"categoryid":categoryId,
                             @"pageNo":@(pageNo),
                             @"pageSize":@(pageSize)
                             };
    [kHTTPManager tryPost:kUrlRecommendList parameters:params success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *items = [HJRecommendItemModel mj_objectArrayWithKeyValuesArray:responseObject];
        success(items);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}
@end
