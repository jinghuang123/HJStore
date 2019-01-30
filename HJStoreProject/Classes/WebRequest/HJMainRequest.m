//
//  HJMainRequest.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/18.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainRequest.h"
#import "HJUserInfoModel.h"

@interface HJMainRequest ()
@property (nonatomic,strong) NSMutableArray *categorys;
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
              categoryId:(NSInteger)categoryId
                    sort:(NSInteger)sort
                 pageNo:(NSInteger)pageNo
               pageSize:(NSInteger)pangeSize
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock)fail {
    //排序方式，1->综合，2->优惠券面值由低到高，3->优惠券面值由高到低，4->预估收益由高到低，5->卷后价由低到高，6->卷后价由高到低，7->销量由低到高，8->销量由高到低
    NSDictionary *parms = @{
                            @"categoryId":@(categoryId),
                            @"sort":@(sort),
                            @"pageNo" :@(pageNo),
                            @"pageSize":@(20),
                            };
    [kHTTPManager tryPost:kUrlGetMainList parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSDictionary *bannerDic = [responseObject objectForKey:@"banner"];
        NSDictionary *activityDic = [responseObject objectForKey:@"activity"];
        NSDictionary *rollingDic = [responseObject objectForKey:@"toutiao"];
        NSDictionary *recommendDic = [responseObject objectForKey:@"recommend"];
        
        NSDictionary *hostDic = [responseObject objectForKey:@"host"];
        NSArray *banners = [HJBannerModel mj_objectArrayWithKeyValuesArray:bannerDic];
        NSArray *activitys = [HJActivityModel mj_objectArrayWithKeyValuesArray:activityDic];
        NSArray *rollings = [HJRollingModel mj_objectArrayWithKeyValuesArray:rollingDic];
        NSArray *recommends = [HJRecommendModel mj_objectArrayWithKeyValuesArray:recommendDic];
        rollings  = rollings ? rollings : [NSArray array];
        activitys  = activitys ? activitys : [NSArray array];
        banners  = banners ? banners : [NSArray array];
        recommends  = recommends ? recommends : [NSArray array];

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
                                   @"bannerImages":bannerImages
                                   };
        success(response);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}

- (void)getMainListByCategoryIdCache:(BOOL)cache
                          categoryId:(NSInteger)categoryId
                              pageNo:(NSInteger)pageNo
                            pageSize:(NSInteger)pageSize
                                sort:(NSInteger)sort
                             success:(CompletionSuccessBlock)success
                                fail:(CompletionFailBlock)fail {
    //排序方式，1->综合，2->优惠券面值由低到高，3->优惠券面值由高到低，4->预估收益由高到低，5->卷后价由低到高，6->卷后价由高到低，7->销量由低到高，8->销量由高到低
    NSDictionary *parms = @{
                            @"categoryId":@(categoryId),
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
                  productId:(NSInteger)productId
                        success:(CompletionSuccessBlock)success
                           fail:(CompletionFailBlock)fail {
    NSDictionary *parms = @{@"productId":@(productId)};
    [kHTTPManager tryPost:kUrlGetProductDetail parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        HJProductDetailModel *model = [HJProductDetailModel mj_objectWithKeyValues:responseObject];
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
        NSDictionary *result = [responseObject objectForKey:@"result_list"];
        NSArray *map_data = [result objectForKey:@"map_data"];
        NSArray *searchModel = [HJSearchModel mj_objectArrayWithKeyValuesArray:map_data];
        
        NSDictionary *response = @{
                                   @"searchModel":searchModel,
                                   };
        success(response);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}

- (void)getShareDataCache:(BOOL)cache
                productId:(NSInteger )productId
                    title:(NSString *)title
                      url:(NSString *)url
                  success:(CompletionSuccessBlock)success
                     fail:(CompletionFailBlock)fail  {
    NSDictionary *parms = @{
                            @"product_id":@(productId),
                            @"text" :title,
                            @"url":url,
                            };
    [kHTTPManager tryPost:kUrlGetShareData parameters:parms success:^(NSURLSessionDataTask *operation, id responseObject) {
        HJShareModel *shareModel = [HJShareModel mj_objectWithKeyValues:responseObject];
        success(shareModel);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
    
}



- (void)getEarningConfigerSuccess:(CompletionSuccessBlock)success
                         fail:(CompletionFailBlock)fail {
    NSString *url = [self getTokenUrl:kUrlEarningConfiger];
    [kHTTPManager tryPost:url parameters:nil success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSLog(@"getEarningConfigerSuccess:%@",responseObject);
        HJEarningModel *model = [HJEarningModel shared];
        model = [HJEarningModel mj_objectWithKeyValues:responseObject];
        success(model);
    } failure:^(NSURLSessionDataTask *operation, NSError *error, NSString *yfErrCode) {
        fail(error);
    }];
}

- (NSString *)getTokenUrl:(NSString *)baseUrl {
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    NSString *url = [NSString stringWithFormat:@"%@?token=%@",baseUrl,userInfo.token];
    return url;
}

@end
