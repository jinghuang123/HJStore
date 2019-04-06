//
//  HJFenceRequest.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJFenceModel.h"


@interface HJFenceRequest : NSObject
+ (instancetype)shared;
- (void)getFenceListWithType:(NSInteger)type
                     success:(CompletionSuccessBlock)success
                        fail:(CompletionFailBlock)fail;
@end


