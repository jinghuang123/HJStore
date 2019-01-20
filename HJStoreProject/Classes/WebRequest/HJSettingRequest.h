//
//  HJSettingRequest.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJSettingRequest : NSObject

+ (instancetype)shared;


- (void)getApplyCashListSuccess:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;
@end


