//
//  HJNetworkType.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJNetworkType.h"


@implementation HJNetworkType

+(NSInteger)isNetworkType{
    Reachability *reach = [Reachability reachabilityForInternetConnection];
    NetworkStatus status = [reach currentReachabilityStatus];
    switch (status)
    {
            
        case NotReachable:
//            NSLog(@"====当前网络状态不可达=======");
            //其他处理
            return 0;
            break;
            
        case ReachableViaWiFi:
//            NSLog(@"====当前网络状态为Wifi=======");
            
            //其他处理
            return 1;
            break;
        case ReachableViaWWAN:
//            NSLog(@"====当前网络状态为移动数据网络=======");
            return 2;
            break;
       
        default:
//            NSLog(@"你是外星来的吗？");
            //其他处理
           
            break;
    }
    
 
}

+ (NSInteger)getNetconnType{
    
    NSInteger netconnType = 1;
    
    Reachability *reach = [Reachability reachabilityWithHostName:@"www.apple.com"];
    
    switch ([reach currentReachabilityStatus]) {
        case NotReachable:// 没有网络
        {
            
            netconnType = 0;
        }
            break;
            
        case ReachableViaWiFi:// Wifi
        {
            netconnType = 1;
        }
            break;
            
        case ReachableViaWWAN:// 手机自带网络
        {
            // 获取手机网络类型
            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
            
            NSString *currentStatus = info.currentRadioAccessTechnology;
            
            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
                
                netconnType = 2;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
                
                netconnType = 2;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
                
                netconnType = 3;
            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
                
                netconnType = 4;
            }
        }
            break;
            
        default:
            break;
    }
    
    return netconnType;
}

+(BOOL)isConnected{
    return [self isNetworkType]==ReachableViaWWAN || [self isNetworkType]==ReachableViaWiFi;
}





@end
