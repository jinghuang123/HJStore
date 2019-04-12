//
//  HJMainRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/18.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainRequest.h"
#import "HJUserInfoModel.h"
#import "HJSettingRequest.h"

@interface HJMainRequest ()
@property (nonatomic,strong) NSMutableArray *categorys;
@property (nonatomic,strong) HJEarningModel *earnningModel;
@end

@implementation HJMainRequest

+ (instancetype)shared {
    static dispatch_once_t once;
    static HJMainRequest *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

- (NSMutableArray *)categorys {
    if (!_categorys) {
        _categorys = [[NSMutableArray alloc] init];
    }
    return _categorys;
}

- (void)getMainCategoryCache:(BOOL)cache success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail {
    if (self.categorys.count == 0 || !cache) {
        [kHTTPManager tryPost:kUrlGetCategorys parameters:[NSDictionary dictionary] success:^(NSURLSessionDataTask *operation, id responseObject) {
            NSArray *categorys = [HJCategoryModel mj_objectArrayWithKeyValuesArray:responseObject];
            [self.categorys setArray:categorys];
            success(self.categorys);
        } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
            fail(error);
        }];
    }else{
        success(self.categorys);
    }

}

- (void)getMainListCache:(BOOL)cache
              categoryId:(NSString *)categoryId
                    sort:(NSInteger)sort
                 pageNo:(NSInteger)pageNo
               pageSize:(NSInteger)pangeSize
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock)fail {
    //排序方式，1->综合，2->优惠券面值由低到高，3->优惠券面值由高到低，4->预估收益由高到低，5->卷后价由低到高，6->卷后价由高到低，7->销量由低到高，8->销量由高到低
    NSDictionary *parms = @{
                            @"categoryId":@([categoryId integerValue]),
                            @"sort":@(sort),
                            @"pageNo" :@(pageNo),
                            @"pageSize":@(20),
                            };
    [kHTTPManager tryPost:kUrlGetMainList parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *bannerDic = [responseObject objectForKey:@"banner"];
        NSDictionary *activityDic = [responseObject objectForKey:@"activity"];
        NSDictionary *categoryDic = [responseObject objectForKey:@"category"];
        NSDictionary *rollingDic = [responseObject objectForKey:@"toutiao"];
        NSDictionary *recommendDic = [responseObject objectForKey:@"recommend"];
        NSDictionary *hostDic = [responseObject objectForKey:@"host"];
        NSArray *banners = [HJBannerModel mj_objectArrayWithKeyValuesArray:bannerDic];
        NSArray *activitys = [HJActivityModel mj_objectArrayWithKeyValuesArray:activityDic];
        NSArray *rollings = [HJRollingModel mj_objectArrayWithKeyValuesArray:rollingDic];
        NSArray *recommends = [HJRecommendModel mj_objectArrayWithKeyValuesArray:recommendDic];
        NSArray *categorys = [HJCategoryModel mj_objectArrayWithKeyValuesArray:categoryDic];
        rollings  = rollings ? rollings : [NSArray array];
        activitys  = activitys ? activitys : [NSArray array];
        banners  = banners ? banners : [NSArray array];
        recommends  = recommends ? recommends : [NSArray array];
        categorys  = categorys ? categorys : [NSArray array];

        NSMutableArray *bannerImages = [[NSMutableArray alloc] init];
        for (HJBannerModel *banner in banners) {
            NSString *url = [NSString stringWithFormat:@"%@%@",kHHWebServerBaseURL,banner.banner_image];
            [bannerImages addObject:url];
        }
        NSDictionary *response = @{
                                   @"banners":banners,
                                   @"activitys":activitys,
                                   @"rollings":rollings,
                                   @"recommends":recommends,
                                   @"host":@"",
                                   @"bannerImages":bannerImages,
                                   @"category":categorys
                                   };
        success(response);
        NSLog(@">>>>>>>>>>>>>>%@",response);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}


- (void)getCellBannersSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail {
    [[HJSettingRequest shared] getBannersWithType:5 Success:^(NSArray *banners) {
        NSMutableArray *bannerImages = [[NSMutableArray alloc] init];
        for (HJBannerModel *banner in banners) {
            NSString *url = [NSString stringWithFormat:@"%@%@",kHHWebServerBaseURL,banner.banner_image];
            [bannerImages addObject:url];
        }
        NSDictionary *response = @{
                                   @"cellBanners":banners,
                                   @"cellbannerImages":bannerImages,
                                   };
        success(response);
    } fail:^(NSError *error) {
        fail(error);
    }];
}



- (void)getMainListByCategoryIdCache:(BOOL)cache
                          categoryId:(NSString *)categoryId
                              pageNo:(NSInteger)pageNo
                            pageSize:(NSInteger)pageSize
                                sort:(NSInteger)sort
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail {
    //排序方式，1->综合，2->优惠券面值由低到高，3->优惠券面值由高到低，4->预估收益由高到低，5->卷后价由低到高，6->卷后价由高到低，7->销量由低到高，8->销量由高到低
    NSDictionary *parms = @{
                            @"categoryId":@([categoryId integerValue]),
                            @"pageNo" :@(pageNo),
                            @"pageSize":@(pageSize),
                            @"sort":@(sort)
                            };
    [kHTTPManager tryPost:kUrlGetCategoryMainList parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *recommends = [HJRecommendModel mj_objectArrayWithKeyValuesArray:responseObject];

        NSDictionary *response = @{
                                   @"recommends":recommends,
                                   };
        success(response);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}




- (void)getProductDetailCache:(BOOL)cache
                  productId:(NSString *)productId
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock)fail {
    NSDictionary *parms = @{@"productId":@([productId integerValue])};
    [kHTTPManager tryPost:kUrlGetProductDetail parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        HJRecommendModel *model = [HJRecommendModel mj_objectWithKeyValues:responseObject];
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:model.small_images];
        for (NSArray *str in model.small_images) {
            if ([str isEqual:@""]) {
                [array removeObject:str];
            }
        }
        model.small_images = array;
        success(model);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}

- (void)getRandomListCache:(BOOL)cache
                 pageSize:(NSInteger)pageSize
                   success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{@"pageSize":@(pageSize)};
    [kHTTPManager tryPost:kUrlGetRandomList parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *recommends = [HJRecommendModel mj_objectArrayWithKeyValuesArray:responseObject];

        success(recommends);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getActivityListCache:(BOOL)cache
                  activityId:(NSInteger)activityId
                      pageNo:(NSInteger)pageNo
                    pageSize:(NSInteger)pageSize
                        sort:(NSInteger)sort
                   success:(CompletionSuccessBlock)success
                      fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{
                            @"activityId":@(activityId),
                            @"pageNo" :@(pageNo),
                            @"pageSize":@(pageSize),
                            @"sort":@(sort)
                            };
    [kHTTPManager tryPost:kUrlGetActivityList parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *recommends = [HJRecommendModel mj_objectArrayWithKeyValuesArray:responseObject];
        NSDictionary *response = @{
                                   @"recommends":recommends,
                                   };
        success(response);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}




- (void)getListBySearchCodeCache:(BOOL)cache
                          code:(NSString *)code
                              pageNo:(NSInteger)pageNo
                            pageSize:(NSInteger)pangeSize
                          has_coupon:(NSString *)has_coupon
                                sort:(NSInteger)sort
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail {
    //排序方式，1->综合，2->优惠券面值由低到高，3->优惠券面值由高到低，4->预估收益由高到低，5->卷后价由低到高，6->卷后价由高到低，7->销量由低到高，8->销量由高到低
    NSDictionary *parms = @{
                            @"q":code,
                            @"pageNo" :@(pageNo),
                            @"pageSize":@(pangeSize),
                            @"has_coupon":has_coupon,
                            @"sort":@(sort)
                            };
    [kHTTPManager tryPost:kUrlGetListSearch parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *map_data = [responseObject objectForKey:@"data"];
        NSArray *searchModel = [HJRecommendModel mj_objectArrayWithKeyValuesArray:map_data];
        searchModel = searchModel ? searchModel : [NSArray array];
        NSDictionary *response = @{
                                   @"searchModel":searchModel,
                                   };
        success(response);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}

- (void)getShareDataCache:(BOOL)cache
                productId:(NSString *)productId
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{
                            @"item_id":productId,
                            };
    NSString *requestUrl = [kHTTPManager getTokenUrl:kUrlGetShareData];
    [kHTTPManager tryPost:requestUrl parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        HJShareModel *shareModel = [HJShareModel mj_objectWithKeyValues:responseObject];
        success(shareModel);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getIfFavouriteWithItemId:(NSString *)productId
                         success:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{
                            @"item_id":productId,
                            };
    NSString *requestUrl = [kHTTPManager getTokenUrl:kUrlGetIfFavorite];
    [kHTTPManager tryPost:requestUrl parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        id status =  [responseObject objectForKey:@"status"];
        success(status);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)postFavouriteWithItemId:(NSString *)productId
                         status:(NSString *)statu
                         success:(CompletionSuccessBlock)success
                            fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{
                            @"item_id":productId,
                            @"status":statu,
                            };
    NSString *requestUrl = [kHTTPManager getTokenUrl:kUrlFavoriteGoods];
    [kHTTPManager tryPost:requestUrl parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}

- (void)getFavouriteListWithPage:(NSInteger)page
                        PageSize:(NSInteger)pageSize
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{
                            @"page":@(page),
                            @"pageSize":@(pageSize),
                            };
    NSString *requestUrl = [kHTTPManager getTokenUrl:kUrlGetFavoriteGoods];
    [kHTTPManager tryPost:requestUrl parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *map_data = responseObject;
        NSArray *favourites = [HJRecommendModel mj_objectArrayWithKeyValuesArray:map_data];
        favourites = favourites ? favourites : [NSArray array];
        success(favourites);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}



- (void)getEarningConfigerSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail {
    NSString *url = [kHTTPManager getTokenUrl:kUrlEarningConfiger];
    if(self.earnningModel) {
        success(self.earnningModel);
    }else{
        [kHTTPManager tryPost:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
            NSLog(@"getEarningConfigerSuccess:%@",responseObject);
            HJEarningModel *model = [[HJEarningModel alloc] init];
            model = [HJEarningModel mj_objectWithKeyValues:responseObject];
            [model saveEarnConfiger2Phone];
            success(model);
        } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
            fail(error);
        }];
    }
}



@end
