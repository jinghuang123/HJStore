//
//  HJLoginRegistRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJLoginRegistRequest.h"


@implementation HJLoginRegistRequest
+ (instancetype)shared {
    static dispatch_once_t once;
    static HJLoginRegistRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (void)checkMobileOrCode:(NSString *)code
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"code":code,
                            };
    [kHTTPManager tryPost:kUrlCheckModbileCode parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"checkMobileOrCode:%@",responseObject);
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
    
}

- (void)getCodeWithMobile:(NSString *)mobile
                    event:(NSString *)event
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"mobile":mobile,
                            @"event":event,
                            };
    [kHTTPManager tryPost:kUrlGetCode parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"getCodeWithMobile:%@",responseObject);
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
    
}

- (void)checkInviteCodeWithMobile:(NSString *)mobile
                            event:(NSString *)event
                             code:(NSString *)code
                          success:(CompletionSuccessBlock)success
                             fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"mobile":mobile,
                            @"event":event,
                            @"captcha":code
                            };
    [kHTTPManager tryPost:kUrlCheckCode parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"getCodeWithMobile:%@",responseObject);
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}


- (void)registWithMobileNum:(NSString *)mobile
                        psw:(NSString *)password
                       Code:(NSString *)code
                   userName:(NSString *)username
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"code":code,
                            @"mobile":mobile,
                            @"password":password,
                            @"username":username,
                            };
    [kHTTPManager tryPost:kUrlRegist parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"registWithMobileNum:%@",responseObject);
        HJUserInfoModel *userInfo = [HJUserInfoModel mj_objectWithKeyValues:responseObject];
        [userInfo saveUserInfo2Phone];
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}

- (void)loginWithPsw:(NSString *)account
                        psw:(NSString *)password
                    success:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"account":account,
                            @"password":password,
                            };
    [kHTTPManager tryPost:kUrlLogin parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"registWithMobileNum:%@",responseObject);
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}


@end