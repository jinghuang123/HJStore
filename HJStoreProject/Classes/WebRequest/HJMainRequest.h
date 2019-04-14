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
#import "HJRecommendModel.h"
#import "HJShareModel.h"
#import "HJEarningModel.h"
#import "HJSearchHotModel.h"


@interface HJMainRequest : NSObject

+ (instancetype)shared;

- (void)getMainCategoryCache:(BOOL)cache success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

- (void)getMainListCache:(BOOL)cache
              categoryId:(NSString *)categoryId
                    sort:(NSInteger)sort
                  pageNo:(NSInteger)pageNo
                pageSize:(NSInteger)pangeSize
                 success:(CompletionSuccessBlock)success
                    fail:(CompletionFailBlock)fail;

- (void)getMainListByCategoryIdCache:(BOOL)cache
                          categoryId:(NSString *)categoryId
                              pageNo:(NSInteger)pageNo
                            pageSize:(NSInteger)pageSize
                                sort:(NSInteger)sort
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail;


- (void)getProductDetailCache:(BOOL)cache
                    productId:(NSString *)productId
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
                        soreType:(NSInteger)soretype
                            code:(NSString *)code
                          pageNo:(NSInteger)pageNo
                        pageSize:(NSInteger)pangeSize
                      has_coupon:(NSString *)has_coupon
                            sort:(NSInteger)sort
                         success:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail;


- (void)getShareDataCache:(BOOL)cache
                productId:(NSString *)productId
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock)fail;

- (void)getEarningConfigerSuccess:(CompletionSuccessBlock)success
                             fail:(CompletionFailBlock)fail;

- (void)getCellBannersSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail;

- (void)getIfFavouriteWithItemId:(NSString *)productId
                         success:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail;

- (void)postFavouriteWithItemId:(NSString *)productId
                         status:(NSString *)statu
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock)fail;

- (void)getFavouriteListWithPage:(NSInteger)page
                        PageSize:(NSInteger)pageSize
                         success:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail;

- (void)getSearchHotSuccess:(CompletionSuccessBlock)success
                       fail:(CompletionFailBlock)fail;
@end

