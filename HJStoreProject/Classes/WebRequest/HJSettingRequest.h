//
//  HJSettingRequest.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJGeneralInfo.h"
#import "HJCommissionInfo.h"
#import "HJWeiquanModel.h"
#import "HJDrawalRecordModel.h"
#import "HJServiceInfoModel.h"
#import "HJUpdateGroupModel.h"

@interface HJSettingRequest : NSObject

+ (instancetype)shared;

- (void)uploadFile:(NSData *)data success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

- (void)getApplyCashListSuccess:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

- (void)getBannersWithType:(NSInteger)type
                   Success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock)fail;

- (void)getGeneralInfoSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail;

- (void)getCommissionInfoSuccess:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail;

- (void)getWeiquanOrderSuccess:(CompletionSuccessBlock)success
                          fail:(CompletionFailBlock)fail;

- (void)getServiceInfoSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail;

- (void)getUpdateGroupSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail;

@end


