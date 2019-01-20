//
//  HJRecommendRequest.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/19.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJRecommendCategorys.h"
#import "HJRecommendItemModel.h"

@interface HJRecommendRequest : NSObject
+ (instancetype)shared;


- (void)getRecommendCategorysWithId:(NSString *)categoryId
                            success:(CompletionSuccessBlock)success
                               fail:(CompletionFailBlock)fail;

- (void)getRecommendListWithId:(NSString *)categoryId
                        pageNo:(NSInteger)pageNo
                      pageSize:(NSInteger)pageSize
                       success:(CompletionSuccessBlock)success
                          fail:(CompletionFailBlock)fail;
@end


