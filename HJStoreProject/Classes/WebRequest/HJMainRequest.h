//
//  HJMainRequest.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/18.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJCategoryModel.h"
#import "HJBannerModel.h"
#import "HJActivityModel.h"
#import "HJRecommendModel.h"
#import "HJRollingModel.h"

@interface HJMainRequest : NSObject

+ (instancetype)shared;

- (void)getMainCategoryCache:(BOOL)cache success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

- (void)getMainListCache:(BOOL)cache
                  pageNo:(NSInteger)pageNo
                pageSize:(NSInteger)pangeSize
                 success:(CompletionSuccessBlock)success
                    fail:(CompletionFailBlock)fail;

- (void)getMainListByCategoryIdCache:(BOOL)cache
                          categoryId:(NSInteger)categoryId
                              pageNo:(NSInteger)pageNo
                            pageSize:(NSInteger)pangeSize
                                sort:(NSInteger)sort
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail;

- (void)getMainProductListCache:(BOOL)cache
                       parentId:(NSInteger)parentId
                         pageNo:(NSInteger)pageNo
                       pageSize:(NSInteger)pangeSize
                       sortType:(NSInteger)sort
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock)fail;

- (void)getProductDetailCache:(BOOL)cache
                    productId:(NSInteger)productId
                      success:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail;
@end

