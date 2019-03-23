//
//  HJOrderListRequest.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJOrderListRequest : NSObject
+ (instancetype)shared;


- (void)getOrderListWithStatus:(NSInteger)status
                        PageNo:(NSInteger)pageNo
                      PageSize:(NSInteger)pageSize
                       Success:(CompletionSuccessBlock)success
                          fail:(CompletionFailBlock)fail;
@end


