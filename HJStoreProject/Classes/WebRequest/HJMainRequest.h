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
#import "HJProductDetailModel.h"
#import "HJSearchModel.h"
#import "HJShareModel.h"


@interface HJMainRequest : NSObject

+ (instancetype)shared;

- (void)getMainCategoryCache:(BOOL)cache success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

- (void)getMainListCache:(BOOL)cache
              categoryId:(NSInteger)categoryId
                    sort:(NSInteger)sort
                  pageNo:(NSInteger)pageNo
                pageSize:(NSInteger)pangeSize
                 success:(CompletionSuccessBlock)success
                    fail:(CompletionFailBlock)fail;

- (void)getMainListByCategoryIdCache:(BOOL)cache
                          categoryId:(NSInteger)categoryId
                              pageNo:(NSInteger)pageNo
                            pageSize:(NSInteger)pageSize
                                sort:(NSInteger)sort
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail;


- (void)getProductDetailCache:(BOOL)cache
                    productId:(NSInteger)productId
                      success:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail;

- (void)getRandomListCache:(BOOL)cache
                  pageSize:(NSInteger)pageSize
                   success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock)fail ;

- (void)getActivityListCache:(BOOL)cache
                  activityId:(NSInteger)activityId
                      pageNo:(NSInteger)pageNo
                    pageSize:(NSInteger)pageSize
                        sort:(NSInteger)sort
                     success:(CompletionSuccessBlock)success
                        fail:(CompletionFailBlock)fail;


- (void)getListBySearchCodeCache:(BOOL)cache
                            code:(NSString *)code
                          pageNo:(NSInteger)pageNo
                        pageSize:(NSInteger)pangeSize
                            sort:(NSInteger)sort
                         success:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail ;


- (void)getShareDataCache:(BOOL)cache
                productId:(NSInteger )productId
                    title:(NSString *)title
                      url:(NSString *)url
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock)fail;
@end

