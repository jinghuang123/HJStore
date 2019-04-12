//
//  HJSettingRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSettingRequest.h"
#import "HJUserInfoModel.h"
#import "HJBannerModel.h"
#import <MJExtension.h>


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
    NSString *url = [kHTTPManager getTokenUrl:kURLGetApplyCashList];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *models = [HJDrawalRecordModel mj_objectArrayWithKeyValuesArray:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}


- (void)getBannersWithType:(NSInteger)type
                   Success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{@"status":@(type)};
    [kHTTPManager tryPost:kURLGetBanners parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *models = [HJBannerModel mj_objectArrayWithKeyValuesArray:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}


- (void)getGeneralInfoSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlGetGeneralInfo];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        HJGeneralInfo *info = [HJGeneralInfo mj_objectWithKeyValues:responseObject];
        success(info);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getWeiquanOrderSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlGetWeiquanOrders];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *models = [HJWeiquanModel mj_objectArrayWithKeyValuesArray:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getCommissionInfoSuccess:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlGetCommissionInfo];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *infosArray = [responseObject objectForKey:@"details"];
        NSArray *infos = [HJCommissionInfo mj_objectArrayWithKeyValuesArray:infosArray];
        success(infos);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getServiceInfoSuccess:(CompletionSuccessBlock)success
                        fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlGetServiceInfo];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        HJServiceInfoModel *model = [HJServiceInfoModel mj_objectWithKeyValues:responseObject];
        success(model);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getUpdateGroupSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlUpdateGroup];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *dic = [responseObject objectForKey:@"data"];
        NSNumber *code = [responseObject objectForKey:@"code"];
        NSString *msg = [responseObject objectForKey:@"msg"];
        if ([code integerValue] == 1) {
            success(msg);
        }else if([code integerValue] == 2) {
            success(msg);
        }else {
            HJUpdateGroupModel *model = [HJUpdateGroupModel mj_objectWithKeyValues:dic];
            success(model);
        }

    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)updeteUserInfoWithAvater:(NSString *)avatar
                        username:(NSString *)username
                        nickname:(NSString *)nickname
                   Success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{@"avatar":avatar,@"username":username,@"nickname":nickname};
    NSString *url = [kHTTPManager getTokenUrl:kUrlUserUpdate];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *models = [HJBannerModel mj_objectArrayWithKeyValuesArray:responseObject];
        success(models);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

//

@end
