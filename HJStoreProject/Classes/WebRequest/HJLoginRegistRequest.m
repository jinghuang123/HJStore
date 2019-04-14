//
//  HJLoginRegistRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJLoginRegistRequest.h"
#import "HJMainRequest.h"

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
        success(responseObject);
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
                     openId:(NSString *)openid
                      token:(NSString *)token
                   userName:(NSString *)username
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"code":code,
                            @"mobile":mobile,
                            @"password":password,
                            @"username":username,
                            };
    if (openid && openid.length > 0) {
        parms = @{
                  @"code":code,
                  @"mobile":mobile,
                  @"password":password,
                  @"username":username,
                  @"openid":openid,
                  @"access_token":token,
                  };
    }
    [kHTTPManager tryPost:kUrlRegist parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"registWithMobileNum:%@",responseObject);
        NSDictionary *userInfo = [responseObject objectForKey:@"userinfo"];
        HJUserInfoModel *userInfoModel = [HJUserInfoModel mj_objectWithKeyValues:userInfo];
        [userInfoModel saveUserInfo2Phone];
        [[HJMainRequest shared] getEarningConfigerSuccess:^(id responseObject) {
        } fail:^(NSError *error) {
        }];
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
        NSLog(@"loginWithPsw:%@",responseObject);
        NSDictionary *userInfo = [responseObject objectForKey:@"userinfo"];
        HJUserInfoModel *userInfoModel = [HJUserInfoModel mj_objectWithKeyValues:userInfo];
        [userInfoModel saveUserInfo2Phone];
        [[HJMainRequest shared] getEarningConfigerSuccess:^(id responseObject) {
        } fail:^(NSError *error) {
        }];
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}

- (void)loginWithSMS:(NSString *)account
                 code:(NSString *)code
             success:(CompletionSuccessBlock)success
                fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"mobile":account,
                            @"captcha":code,
                            };
    [kHTTPManager tryPost:kUrlLoginSMS parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"loginWithSMS:%@",responseObject);
        NSDictionary *userInfo = [responseObject objectForKey:@"userinfo"];
        HJUserInfoModel *userInfoModel = [HJUserInfoModel mj_objectWithKeyValues:userInfo];
        [userInfoModel saveUserInfo2Phone];
        [[HJMainRequest shared] getEarningConfigerSuccess:^(id responseObject) {
        } fail:^(NSError *error) {
        }];
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}

- (void)loginWithWechatInfo:(NSString *)openId
                    success:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock2)fail {
//    kUrlWechatLogin
    NSDictionary *parms = @{
                            @"openid":openId,
                            };
    [kHTTPManager tryPost:kUrlWechatLogin parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *userInfo = [responseObject objectForKey:@"userinfo"];
        NSLog(@"userInfo>>%@",userInfo);
        HJUserInfoModel *userInfoModel = [HJUserInfoModel mj_objectWithKeyValues:userInfo];
        [userInfoModel saveUserInfo2Phone];
        [[HJMainRequest shared] getEarningConfigerSuccess:^(id responseObject) {
        } fail:^(NSError *error) {
        }];
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}

- (void)bondingWithWechatInfo:(NSString *)openId
                        token:(NSString *)access_token
                    success:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock2)fail {
    //    kUrlWechatLogin
    NSDictionary *parms = @{
                            @"openid":openId,
                            @"access_token":access_token
                            };
    NSString *url = [kHTTPManager getTokenUrl:kUrlWechatBonding];
    [kHTTPManager tryPost:url parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *userInfo = [responseObject objectForKey:@"userinfo"];
        NSLog(@"userInfo>>%@",userInfo);
        HJUserInfoModel *userInfoModel = [HJUserInfoModel mj_objectWithKeyValues:userInfo];
        [userInfoModel saveUserInfo2Phone];
        [[HJMainRequest shared] getEarningConfigerSuccess:^(id responseObject) {
        } fail:^(NSError *error) {
        }];
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}
//

- (void)bondingZFBWithName:(NSString *)name
                   account:(NSString *)account
                    mobile:(NSString *)mobile
                   captcha:(NSString *)code
                      success:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock2)fail {
    NSDictionary *parms = @{
                            @"name":name,
                            @"account":account,
                            @"mobile":mobile,
                            @"captcha":code
                            };
    NSString *url = [kHTTPManager getTokenUrl:kURLBindAlipay];
    [kHTTPManager tryPost:url parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
  
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}


- (void)reSetPasswordWithMobileNum:(NSString *)mobile
                               psw:(NSString *)password
                              Code:(NSString *)code
                           success:(CompletionSuccessBlock)success
                              fail:(CompletionFailBlock2)fail  {
    NSDictionary *parms = @{
                            @"captcha":code,
                            @"mobile":mobile,
                            @"newpassword":password,
                            };
    [kHTTPManager tryPost:kUrlPassworldReset parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"reSetPasswordWithMobileNum:%@",responseObject);
        success(nil);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *errorMsg) {
        fail(error,errorMsg);
    }];
}

- (void)logOutActionSuccess:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kUrlLogout];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}




- (void)getInvitationInfoSuccess:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail {
    NSDictionary *dic = @{};
    NSString *url = [kHTTPManager getTokenUrl:kURLGetInvitationInfo];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}


- (void)postNewMobileWithMobile:(NSString *)mobile
                           code:(NSString *)code
                        success:(CompletionSuccessBlock)success
                             fail:(CompletionFailBlock2)fail {
    NSDictionary *dic = @{@"mobile":mobile,@"captcha":code};
    NSString *url = [kHTTPManager getTokenUrl:kUrlMobileUpdate];
    [kHTTPManager tryPost:url parameters:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error,yfErrCode);
    }];
}

@end
