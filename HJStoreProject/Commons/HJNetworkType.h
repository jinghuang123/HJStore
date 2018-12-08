//
//  HJNetworkType.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

@interface HJNetworkType : NSObject

+ (NSInteger)isNetworkType;

+ (NSInteger)getNetconnType;

+ (BOOL)isConnected;

@end
