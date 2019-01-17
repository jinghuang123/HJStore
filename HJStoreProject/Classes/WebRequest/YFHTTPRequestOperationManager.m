//
//  YFHTTPRequestOperationManager.m
//
//  Created by luo liying on 14-8-19.
//  Copyright (c) 2014年 luo liying. All rights reserved.
//

#define BASE_URL @""
#import "YFHTTPRequestOperationManager.h"



@implementation YFHTTPRequestOperationManager

+ (instancetype)shared {
    static dispatch_once_t once;
    static YFHTTPRequestOperationManager *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
        self.manager = [AFHTTPSessionManager manager];
        [self.manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer.timeoutInterval = REQ_TIMEOUT;
        [self.manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        self.manager.requestSerializer = [AFJSONRequestSerializer serializer];
        [self.manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html"]];
    }
    return self;
}


- (NSURLSessionDataTask *)tryPost:(NSString *)URLString
                    parameters:(id)parameters
                       success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error, NSString *code))failure {
    NSLog(@"request url:%@",URLString);
    NSLog(@"request params:%@",parameters);
    NSURLSessionDataTask * operation = [self POST:URLString
                                         parameters:parameters
                                           progress:nil
                                            success:^(NSURLSessionDataTask *task, id responseObject) {
                                                [self YFSuccess:responseObject
                                                      operation:operation
                                                        success:success
                                                        failure:failure];
                                            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                if (error) {
                                                    if (failure) {
                                                        failure(nil,error,nil);
                                                    }
//                                                    CYLog(@"网络请求错误%@", error);
                                                }
                                            }];
    return operation;
}





- (NSURLSessionDataTask* )tryGet:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                        failure:(void (^)(NSURLSessionDataTask *task, NSError *error,NSString *yfErrCode))failure {
    NSURLSessionDataTask *getTask = [self GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject%@",responseObject);
        success(task,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (task.state == NSURLSessionTaskStateCanceling) {
            //CYLog(@"网络请求错误%@", error);
            failure(task, error, @"9999");
        }
    }];
    return getTask;
    
}


- (void)YFSuccess:(NSDictionary *)responseObject
        operation:(NSURLSessionDataTask *)operation
          success:(void (^)(NSURLSessionDataTask *operation, id responseObject))success
          failure:(void (^)(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode))failure {
    NSNumber *resultCode = [responseObject objectForKey:@"code"];
    
    if ([resultCode integerValue] == 1) {
        NSDictionary *result = [responseObject objectForKey:@"data"];
        success(operation, result);
    }
    else {
        NSString *errorMsg = [responseObject objectForKey:@"msg"];
//        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIScreen mainScreen].focusedView animated:YES];
//        hud.label.text = errorMsg;
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [MBProgressHUD hideHUDForView:[UIScreen mainScreen].focusedView animated:YES];
//        });
        failure(operation, nil, errorMsg);
    }
}

@end
