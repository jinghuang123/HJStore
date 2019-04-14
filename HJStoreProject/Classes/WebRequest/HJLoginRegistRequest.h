//
//  HJLoginRegistRequest.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJUserInfoModel.h"


@interface HJLoginRegistRequest : NSObject
+ (instancetype)shared;

- (void)checkMobileOrCode:(NSString *)code
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock2)fail ;

-(void)getCodeWithMobile:(NSString *)mobile
                    event:(NSString *)event
                    success:(CompletionSuccessBlock)success
                    fail:(CompletionFailBlock2)fail ;

- (void)checkInviteCodeWithMobile:(NSString *)mobile
                            event:(NSString *)event
                             code:(NSString *)code
                          success:(CompletionSuccessBlock)success
                             fail:(CompletionFailBlock2)fail;

- (void)registWithMobileNum:(NSString *)mobile
                        psw:(NSString *)password
                       Code:(NSString *)code
                     openId:(NSString *)openid
                      token:(NSString *)token
                   userName:(NSString *)username
                    success:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock2)fail;



- (void)loginWithSMS:(NSString *)account
                code:(NSString *)code
             success:(CompletionSuccessBlock)success
                fail:(CompletionFailBlock2)fail;


- (void)loginWithPsw:(NSString *)account
                 psw:(NSString *)password
             success:(CompletionSuccessBlock)success
                fail:(CompletionFailBlock2)fail;

- (void)loginWithWechatInfo:(NSString *)openId
                    success:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock2)fail;

- (void)bondingWithWechatInfo:(NSString *)openId
                        token:(NSString *)access_token
                      success:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock2)fail;

- (void)bondingZFBWithName:(NSString *)name
                   account:(NSString *)account
                    mobile:(NSString *)mobile
                   captcha:(NSString *)code
                   success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock2)fail;

- (void)reSetPasswordWithMobileNum:(NSString *)mobile
                               psw:(NSString *)password
                              Code:(NSString *)code
                           success:(CompletionSuccessBlock)success
                              fail:(CompletionFailBlock2)fail;

- (void)getInvitationInfoSuccess:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail;

- (void)logOutActionSuccess:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock)fail;

- (void)postNewMobileWithMobile:(NSString *)mobile
                           code:(NSString *)code
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock2)fail;
@end


