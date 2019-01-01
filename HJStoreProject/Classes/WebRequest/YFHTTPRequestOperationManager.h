//
//  YFHTTPRequestOperationManager.h
//
//  Created by luo liying on 14-8-19.
//  Copyright (c) 2014年 luo liying. All rights reserved.
//

#define kHTTPManager [YFHTTPRequestOperationManager shared]

#define PRODUCTDETAILHEAD @"https://hws.m.taobao.com/cache/wdesc/5.0/"
#define PRODUCTDETAILTAIL @"&qq-pf-to=pcqq.group"

@interface YFHTTPRequestOperationManager : AFHTTPSessionManager


typedef void (^CompletionSuccessBlock)(id responseObject);
typedef void (^CompletionSuccessBlock2)(id data1, id data2, NSInteger count);
typedef void (^CompletionFailBlock)(NSError *error);
typedef void (^CompletionFailBlock2)(NSError *error,int errorCode);

@property (nonatomic, strong) AFHTTPSessionManager *manager;
+ (instancetype)shared;

- (AFHTTPSessionManager *)tryPost:(NSString *)URLString
                        parameters:(id)parameters
                           success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                           failure:(void (^)(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode))failure;


- (AFHTTPSessionManager * )tryGet:(NSString *)URLString
                   parameters:(id)parameters
                      success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                      failure:(void (^)(NSURLSessionDataTask *task, NSError *error,NSString *yfErrCode))failure;

@end
