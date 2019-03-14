//
//  HJMainVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJMainRequest.h"
#import "HJSuperView.h"
#import "HJMainPodVC.h"

@interface HJMainVC : HJSuperViewController

/* collectionView */
@property (strong , nonatomic) UICollectionView *collectionView;
/* nav */

/* banners */
@property (strong , nonatomic) NSMutableArray<HJBannerModel *> *banners;
@property (strong , nonatomic) NSMutableArray<NSString *> *bannerImages;

/* activitys */
@property (strong , nonatomic) NSMutableArray *activitys;
/* rollings */
@property (strong , nonatomic) NSMutableArray<HJRollingModel *> *rollings;
/* recommends */
@property (strong , nonatomic) NSMutableArray<HJRecommendModel *> *recommends;
/* hosts */
@property (strong , nonatomic) NSMutableArray *hosts;


@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@property (assign , nonatomic) HJSortType sort;


@property (nonatomic,assign) HJMainVCProductListHeadType headType;
@property (nonatomic,assign) HJMainVCProductListType listType;
@property (nonatomic,assign) NSInteger catteryId;
@property (nonatomic,assign) NSInteger activityId;
@property (assign , nonatomic) GoodsListShowType showType;
@property (nonatomic,assign) BOOL isSearch;
@end


