//
//  HJCategoryRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/18.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJCategoryRequest.h"


@interface HJCategoryRequest ()
@property (nonatomic,strong) NSArray *categorys;
@end



@implementation HJCategoryRequest
+ (instancetype)shared {
    static dispatch_once_t once;
    static HJCategoryRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)getCategoryCache:(BOOL)cache success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail {
    if (self.categorys.count == 0 || !cache) {
        [kHTTPManager tryPost:kUrlGetCategorys parameters:[NSDictionary dictionary] success:^(NSURLSessionDataTask *operation, id responseObject) {
            NSLog(@"getCategoryCache:%@",responseObject);
            NSArray *categorys = [HJCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
            self.categorys = categorys;
            success(self.categorys);
        } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
            fail(error);
        }];
    }else{
        success(self.categorys);
    }
    
}


- (void)getSubCategoryCache:(BOOL)cache parentId:(NSInteger)parentId success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{@"categoryId": @(parentId)};
    [kHTTPManager tryPost:kUrlGetSubCategorys parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"getSubCategoryCache:%@",responseObject);
        NSArray *categorys = [HJCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
        success(categorys);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}
@end
