//
//  HJShareInstance.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ShareSDK/ShareSDK.h>


@interface HJShareInstance : NSObject
+ (instancetype)shareInstance;
- (void)registerShareSDK;
@end


