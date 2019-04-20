//
//  HJMainVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainVC.h"
#import "HJGridCell.h"
#import "HJGridItem.h"
#import "HJMainSliderCell.h"
#import "HJGoodItemCell.h"
#import "HJMainGridSectionFootView.h"
#import "HJGoodsCountDownCell.h"
#import "HJMainListHeadView.h"
#import "HJProductDetailVC.h"
#import "HJSegemengVC.h"
#import "AlibcManager.h"
#import "YFPolicyWebVC.h"
#import "HJLoginVC.h"
#import "HJNavigationVC.h"
#import "HJUserInfoModel.h"


@interface HJMainVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong)  HJMainPodVC *sortTypePopVC;
@end


/* cell */
static NSString *const HJGridCellIdentifier = @"HJGridCell";
static NSString *const HJGoodItemCellIdentifier = @"HJGoodItemCell";
static NSString *const HJGoodItemSingleCellIdentifier =  @"HJGoodItemSingleCell";

static NSString *const HJMainSliderCellIdentifier = @"HJMainSliderCellI";
static NSString *const HJMainSliderBannerCellIdentifier = @"HJMainSliderBannerCell";

static NSString *const HJMainListHeadViewIdentifier = @"HJMainListHeadView";
static NSString *const HJMainListHeadViewIdentifier2 = @"HJMainListHeadViewList2";
static NSString *const HJMainGridSectionFootViewIdentifier = @"HJMainGridSectionFootView";
static NSString *const HJGoodsCountDownCellIdentifier = @"HJGoodsCountDownCell";

@implementation HJMainVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.recommends.count == 0) {
        [self.collectionView.mj_header beginRefreshing];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sort = HJSortTypeTotal;
    self.pageSize = 30;
    [HJNetworkType isConnected];
    [self setupUI];
    NSLog(@"maxw:%f  maxh:%f",MaxWidth,MaxHeight);

    // Do any additional setup after loading the view.
    
//    UIButton *topButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [topButton setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
//    [topButton setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateSelected];
//
//    [self.view insertSubview:topButton atIndex:0];
//    [topButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_offset(-12);
//        make.bottom.mas_offset(-100);
//        make.width.height.mas_equalTo(28);
//    }];
}

- (void)headRefresh {
    weakify(self)
    self.pageNo = 1;
    [self refreshActionSuccess:^(id responseObject) {
        [weak_self.collectionView.mj_header endRefreshing];
    }];
}
- (void)footRefresh {
    weakify(self)
    self.pageNo++;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshActionSuccess:^(id responseObject) {
            [weak_self.collectionView.mj_footer endRefreshing];
        }];
    });
}


- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    if (self.listType == HJMainVCProductListTypeList) {
        if(self.catteryId > 0){
            [[HJMainRequest shared] getMainListByCategoryIdCache:YES categoryId:self.catteryId pageNo:self.pageNo pageSize:self.pageSize sort:self.sort success:^(NSDictionary *response) {
                NSArray *recommends = [response objectForKey:@"recommends"];
                if (self.pageNo > 1) {
                    [self.recommends addObjectsFromArray:[response objectForKey:@"recommends"]];
                }else{
                    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
                    self.recommends = [response objectForKey:@"recommends"];
                }
                if (recommends.count < 20) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                }
                success(nil);
                [self.collectionView reloadData];
                
                
            } fail:^(NSError *error) {
                success(nil);
            }];
        }else{
            [[HJMainRequest shared] getActivityListCache:YES activityId:self.activityId pageNo:self.pageNo pageSize:self.pageSize sort:self.sort success:^(NSDictionary *response) {
                if (self.pageNo > 1) {
                    [self.recommends addObjectsFromArray:[response objectForKey:@"recommends"]];
                    if (self.recommends.count < 20) {
                        [self.collectionView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                    }
                }else{
                    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
                    self.recommends = [response objectForKey:@"recommends"];
                }
                success(nil);
                [self.collectionView reloadData];
            } fail:^(NSError *error) {
                success(nil);
            }];
        }
    }else if(self.listType == HJMainVCProductListTypeMain){
        [[HJMainRequest shared] getMainListCache:NO categoryId:self.catteryId sort:self.sort pageNo:self.pageNo pageSize:self.pageSize success:^(NSDictionary *response) {
            if (self.pageNo > 1) {
                [self.recommends addObjectsFromArray:[response objectForKey:@"recommends"]];
                if (self.recommends.count < 20) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                }
            }else{
                self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
                self.banners = [response objectForKey:@"banners"];
                self.bannerImages = [response objectForKey:@"bannerImages"];
                self.activitys = [response objectForKey:@"activitys"];
                self.rollings = [response objectForKey:@"rollings"];
                self.recommends = [response objectForKey:@"recommends"];
                self.activitys = self.activitys.count > 0 ? self.activitys : [response objectForKey:@"category"];
            }
            success(nil);
            [self getCellBanners];
            [self.collectionView reloadData];
        } fail:^(NSError *error) {
            success(nil);
        }];
 
    }

}

- (void)getCellBanners {
    if(self.catteryId == 0) {
        [[HJMainRequest shared] getCellBannersSuccess:^(NSDictionary *response) {
            self.cellBanners = [response objectForKey:@"cellBanners"];
            self.cellBannerImages = [response objectForKey:@"cellbannerImages"];
            [self.collectionView reloadData];
        } fail:^(NSError *error) {
            
        }];
    }
}


- (void)setSort:(HJSortType)sort {
    _sort = sort;
}

- (void)setupUI {
    self.collectionView.backgroundColor =  [UIColor whiteColor];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        [layout setSectionHeadersPinToVisibleBounds:self.catteryId > 0 || self.activityId > 0];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;

        CGFloat collectionH = self.listType == HJMainVCProductListTypeMain ? MaxHeight - HJTabH - HJTopNavH - 41 - 5 : MaxHeight;
        _collectionView.frame = CGRectMake(0, 0, MaxWidth, collectionH);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        [_collectionView registerClass:[HJMainSliderCell class] forCellWithReuseIdentifier:HJMainSliderCellIdentifier];
        [_collectionView registerClass:[HJMainSliderCell class] forCellWithReuseIdentifier:HJMainSliderBannerCellIdentifier];
        [_collectionView registerClass:[HJGridCell class] forCellWithReuseIdentifier:HJGridCellIdentifier];
        [_collectionView registerClass:[HJGoodItemCell class] forCellWithReuseIdentifier:HJGoodItemCellIdentifier];
        [_collectionView registerClass:[HJGoodItemSingleCell class] forCellWithReuseIdentifier:HJGoodItemSingleCellIdentifier];

        [_collectionView registerClass:[HJGoodsCountDownCell class] forCellWithReuseIdentifier:HJGoodsCountDownCellIdentifier];
   

        [_collectionView registerClass:[HJMainGridSectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HJMainGridSectionFootViewIdentifier];
        
        [_collectionView registerClass:[HJMainListHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier];
        [_collectionView registerClass:[HJMainListHeadViewList class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier2];
        
        _collectionView.mj_footer.ignoredScrollViewContentInsetBottom = MaxHeight >= ENM_SCREEN_H_X ? 34 : 0;
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        
        [self.view addSubview:_collectionView];
    }
   
    return _collectionView;
}

- (NSMutableArray<HJBannerModel *> *)banners {
    if(!_banners){
        _banners = [[NSMutableArray alloc] init];
    }
    return _banners;
}

- (NSMutableArray<HJBannerModel *> *)cellBanners {
    if(!_cellBanners){
        _cellBanners = [[NSMutableArray alloc] init];
    }
    return _cellBanners;
}

- (NSMutableArray<NSString *> *)bannerImages {
    if(!_bannerImages){
        _bannerImages = [[NSMutableArray alloc] init];
    }
    return _bannerImages;
}

- (NSMutableArray<NSString *> *)cellBannerImages {
    if(!_cellBannerImages){
        _cellBannerImages = [[NSMutableArray alloc] init];
    }
    return _cellBannerImages;
}

- (NSMutableArray *)activitys {
    if(!_activitys){
        _activitys = [[NSMutableArray alloc] init];
    }
    return _activitys;
}

- (NSMutableArray<HJRollingModel *> *)rollings {
    if(!_rollings){
        _rollings = [[NSMutableArray alloc] init];
    }
    return _rollings;
}

- (NSMutableArray<HJRecommendModel *> *)recommends {
    if(!_recommends){
        _rollings = [[NSMutableArray alloc] init];
    }
    return _recommends;
}

- (NSMutableArray *)hosts {
    if (!_hosts) {
        _hosts = [[NSMutableArray alloc] init];
    }
    return _hosts;
}

- (void)podSortTypeView {
    if (self.showPopPoint.y == 0) {
        CGFloat pointY = MaxHeight >= ENM_SCREEN_H_X ? 165 : 145;
        self.showPopPoint = CGPointMake(0, pointY);
    }
    if(!self.sortTypePopVC.isPopState) {
        weakify(self)
        self.sortTypePopVC = [[HJMainPodVC alloc] initWithShowFrame:CGRectMake(0, 0 ,MaxWidth, MaxHeight)
                                                                    ShowStyle:MYPresentedViewShowStyleSuddenStyle
                                                                     callback:^(id obj) {
                                                                         weak_self.sortTypePopVC.isPopState = NO;
                                                                         [weak_self.sortTypePopVC dismissViewControllerAnimated:YES completion:nil];
                                                                     }];
        self.sortTypePopVC.clearBack = YES;
        NSArray *data = @[@"综合排序",@"优惠券面值由高到低",@"优惠券面值由低到高",@"预估收益由高到低"];
        self.sortTypePopVC.dataSource = data;
        self.sortTypePopVC.showViewPoint = self.showPopPoint;
        self.sortTypePopVC.viewSize = CGSizeMake(MaxWidth, 4 * 40);
        self.sortTypePopVC.selectedIndex = self.sort--;
        
        self.sortTypePopVC.popDismissBlock = ^(BOOL state) {
            weak_self.sortTypePopVC.isPopState = NO;
            [weak_self.sortTypePopVC dismissViewControllerAnimated:YES completion:nil];
        };
        self.sortTypePopVC.didSelectedRowBlock = ^(NSInteger row) {
            weak_self.sort = row++;
            [weak_self headRefresh];
            weak_self.sortTypePopVC.isPopState = NO;
            [weak_self.sortTypePopVC dismissViewControllerAnimated:YES completion:nil];
        };
        self.sortTypePopVC.isPopState = YES;
        [self presentViewController:self.sortTypePopVC animated:YES completion:nil];
    }else{
        self.sortTypePopVC.isPopState = NO;
        [self.sortTypePopVC dismissViewControllerAnimated:YES completion:nil];
    }
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == HJMainVCSectionTypeSection0){
        return self.banners.count > 0 ?  1 : 0;
    }
    if(section == HJMainVCSectionTypeSection1){
        return self.activitys.count > 10 ? 10 : self.activitys.count;
    }
    if(section == HJMainVCSectionTypeSection2){
        return self.cellBanners.count > 0 ?  1 : 0;
    }
    if(section == HJMainVCSectionTypeSection3){
        return self.recommends.count;
    }

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = [[UICollectionViewCell alloc] init];
    if (indexPath.section == HJMainVCSectionTypeSection0) {
        HJMainSliderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJMainSliderCellIdentifier forIndexPath:indexPath];
        cell.imageGroupArray = self.bannerImages;
        cell.bannerItems = self.banners;
        weakify(self)
        cell.bannerCellItemClick = ^(HJBannerModel *banner) {
            if (banner.typedata == HJNavPushTypeUrl) {
                [weak_self pushToWebWithUrl:banner.content_url];
            }else if (banner.typedata == HJNavPushTypeDetail) {
                [weak_self pushToProductDetailWithId:banner.item_id];
            }else if (banner.typedata == HJNavPushTypeList) {
                [weak_self pushToProductListWithId:banner.content_product activityId:banner.taobao_activity_id];
            }
        };
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection1) {
        HJGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGridCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        NSObject *obj = [self.activitys objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[HJActivityModel class]]) {
            HJActivityModel *item = (HJActivityModel *)obj;
            [cell updeteCellWithActivityItem:item];
        }else if([obj isKindOfClass:[HJCategoryModel class]]){
            HJCategoryModel *item = (HJCategoryModel *)obj;
            [cell updeteCellWithGridItem:item];
        }
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection2) {
        HJMainSliderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJMainSliderBannerCellIdentifier forIndexPath:indexPath];
        cell.imageGroupArray = self.cellBannerImages;
        cell.bannerItems = self.cellBanners;
        weakify(self)
        cell.bannerCellItemClick = ^(HJBannerModel *banner) {
            if (banner.typedata == HJNavPushTypeUrl) {
                [weak_self pushToWebWithUrl:banner.content_url];
            }else if (banner.typedata == HJNavPushTypeDetail) {
                [weak_self pushToProductDetailWithId:banner.item_id];
            }else if (banner.typedata == HJNavPushTypeList) {
                [weak_self pushToProductListWithId:banner.content_product activityId:banner.taobao_activity_id];
            }
        };
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection3) {
        if (self.showType == signleLineShowDoubleGoods) {
            HJGoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodItemCellIdentifier forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            HJRecommendModel *item = [self.recommends objectAtIndex:indexPath.row];
            [cell setItemCellWithItem:item];
            gridcell = cell;
        }else{
            HJGoodItemSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodItemSingleCellIdentifier forIndexPath:indexPath];
            cell.backgroundColor = [UIColor whiteColor];
            HJRecommendModel *item = [self.recommends objectAtIndex:indexPath.row];
            [cell setItemCellWithItem:item];
            gridcell = cell;
        }
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] init];
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == HJMainVCSectionTypeSection3) {
            if(self.headType == HJMainVCProductListHeadTypeMain){
                HJMainListHeadView *headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier forIndexPath:indexPath];
                headerView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
                headerView.layer.borderWidth = (self.catteryId > 0 || self.activityId > 0) ? 0.5 : 0;
                headerView.backgroundColor = [UIColor whiteColor];
                reusableview = headerView;
            }else{
                HJMainListHeadViewList *headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier2 forIndexPath:indexPath];
                headerView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
                headerView.layer.borderWidth = (self.catteryId > 0 || self.activityId > 0) ? 0.5 : 0;
                headerView.backgroundColor = [UIColor whiteColor];
                
                
                weakify(self)
                weakify(headerView)
                headerView.sortTypeChengBlock = ^(NSNumber *index) {
                    if ([index integerValue] == 0) {
                        NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:3];
                        [weak_self.collectionView scrollToItemAtIndexPath:path atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
                        [weak_self podSortTypeView];
                    }else if([index integerValue] == 1) {
                        weak_self.sort = weak_self.sort == HJSortTypePriceHtoL ? HJSortTypePriceLtoH  : HJSortTypePriceHtoL;
                        [weak_self headRefresh];
                    }else if([index integerValue] == 2) {
                        weak_self.sort = weak_self.sort == HJSortTypeShellCountHtoL ? HJSortTypeShellCountLtoH : HJSortTypeShellCountHtoL;
                        [weak_self headRefresh];
                    }
                    [weak_headerView setSortImageWithType:weak_self.sort];
                };
                
                headerView.showModeChangedBlock = ^(id obj) {
                    if (weak_self.showType == singleLineShowOneGoods) {
                        [weak_headerView.rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_list_single"] forState:UIControlStateNormal];
                        weak_self.showType = signleLineShowDoubleGoods;
                    }else{
                        [weak_headerView.rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_wangge"] forState:UIControlStateNormal];
                        weak_self.showType = singleLineShowOneGoods;
                    }
                    [weak_self.collectionView reloadData];
                };
                reusableview = headerView;
            }
        }
    }else{
        if (indexPath.section == HJMainVCSectionTypeSection1) {
            HJMainGridSectionFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HJMainGridSectionFootViewIdentifier forIndexPath:indexPath];
            footerView.rollingDidSelected = ^(NSInteger index) {
                HJRollingModel *rol = [self.rollings objectAtIndex:index];
                [self pushToProductDetailWithId:rol.item_id];
            };
            NSMutableArray *titles = [[NSMutableArray alloc] init];
            for (HJRollingModel *rol in self.rollings) {
                [titles addObject:rol.title];
            }
            footerView.titles = titles;
            reusableview = footerView;
        }
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == HJMainVCSectionTypeSection0 && self.banners.count > 0) { //
        return CGSizeMake(MaxWidth, 180); ;
    }
    if (indexPath.section == HJMainVCSectionTypeSection1) {//9宫格组
        return CGSizeMake(MaxWidth/5 , MaxWidth/5 + 10);
    }
    if (indexPath.section == HJMainVCSectionTypeSection2) {//广告
        return CGSizeMake(MaxWidth, 100);
    }
    if (indexPath.section == HJMainVCSectionTypeSection3) {//列表
        if (self.showType == signleLineShowDoubleGoods) {
            return CGSizeMake((MaxWidth - 15)/2, (MaxWidth - 5)/2 + 110);
        }else{
            return CGSizeMake(MaxWidth, 150);
        }
    }

    return CGSizeZero;
}

#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == HJMainVCSectionTypeSection3 && self.showType == signleLineShowDoubleGoods) ? 5 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection1) {
        return 0;
    }else if(section == HJMainVCSectionTypeSection2){
        return 0;
    }else if(section == HJMainVCSectionTypeSection3){
        return self.showType == signleLineShowDoubleGoods ? 5 : 0;
    }else{
        return 0;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection1) {

        return UIEdgeInsetsZero;
    }else if(section == HJMainVCSectionTypeSection2){
        if (self.catteryId == 0 && self.activityId == 0) {
            return UIEdgeInsetsMake(0, 0, 8, 0);
        }
        return UIEdgeInsetsZero;
    }else if(section == HJMainVCSectionTypeSection3){
        return self.showType == signleLineShowDoubleGoods ? UIEdgeInsetsMake(5, 5, 0, 5) : UIEdgeInsetsZero;
    }else{
        return UIEdgeInsetsZero;
    }
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection3 && self.recommends.count > 0) {
        return CGSizeMake(MaxWidth, 40); //section3高
    }
    return CGSizeZero;
}

//#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection1 && self.rollings.count > 0) {
        return CGSizeMake(MaxWidth,30);  //Top头条的宽高
    }
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectItemAtIndexPath sectiion = %ld",indexPath.section);
    if (indexPath.section == HJMainVCSectionTypeSection0) {
        HJBannerModel *banner = [self.banners objectAtIndex:indexPath.row];
        if (banner.typedata == HJNavPushTypeUrl) {
            [self pushToWebWithUrl:banner.content_url];
        }else if (banner.typedata == HJNavPushTypeDetail) {
            [self pushToProductDetailWithId:banner.item_id];
        }else if (banner.typedata == HJNavPushTypeList) {
            [self pushToProductListWithId:0 activityId:banner.taobao_activity_id];
        }
    }else if (indexPath.section == HJMainVCSectionTypeSection1){
        id obj = [self.activitys objectAtIndex:indexPath.row];
        HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
        if([obj isKindOfClass:[HJActivityModel class]]){
            HJActivityModel *model = (HJActivityModel *)obj;
            if (model.typedata == HJNavPushTypeUrl) {
                [self pushToWebWithUrl:model.content_url];
            }else if (model.typedata == HJNavPushTypeDetail) {
                if (model.islist) {
                    [self pushToProductListWithId:0 activityId:model.activityId];
                }else{
                    model.item_id ? [self pushToProductDetailWithId:model.item_id] : @"";
                }
            }
        }else{
            HJCategoryModel *model = (HJCategoryModel *)obj;
            [self pushToProductListWithId:model.categoryId activityId:0];
        }
    
       
    }else if(indexPath.section == HJMainVCSectionTypeSection2){
        HJBannerModel *banner = [self.cellBanners objectAtIndex:indexPath.row];
        if (banner.typedata == HJNavPushTypeUrl) {
            [self pushToWebWithUrl:banner.content_url];
        }else if (banner.typedata == HJNavPushTypeDetail) {
            [self pushToProductDetailWithId:banner.item_id];
        }else if (banner.typedata == HJNavPushTypeList) {
            [self pushToProductListWithId:0 activityId:banner.taobao_activity_id];
        }
    }else if(indexPath.section == HJMainVCSectionTypeSection3){
        HJRecommendModel *item = [self.recommends objectAtIndex:indexPath.row];
        [self pushToProductDetailWithId:item.item_id];
    }
}


- (void)pushToProductListWithId:(NSString *)categoryId activityId:(NSInteger)activityId{
    HJMainVC *productListVC = [[HJMainVC alloc] init];
    productListVC.hidesBottomBarWhenPushed = YES;
    productListVC.catteryId = categoryId;
    productListVC.activityId = activityId;
    CGFloat pointY = MaxHeight >= ENM_SCREEN_H_X ? 128 : 103;
    productListVC.showPopPoint = CGPointMake(0, pointY);
    productListVC.headType  = HJMainVCProductListHeadTypeList;
    productListVC.listType = HJMainVCProductListTypeList;
    [self.navigationController pushViewController:productListVC animated:YES];
    
}

- (void)pushToProductDetailWithId:(NSString *)productId {
    if ([productId isEqualToString:@""]) {
        return;
    }
    HJProductDetailVC *productDetailVC = [[HJProductDetailVC alloc] init];
    productDetailVC.productId = productId;
    productDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

- (void)pushToWebWithUrl:(NSString *)url {
    if ([url isEqualToString:@""]) {
        return;
    }
    if (![url containsString:@"http"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if(!userInfo.token || userInfo.token.length == 0){
        [self pushToLoginVC:NO closeBlock:nil];
    }else {
        [self showTaobaoAuthorDailogSuccess:^(id responseObject) {
            ALiTradeWebViewController *webVC = [[ALiTradeWebViewController alloc] init];
            [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:self webView:webVC.webView url:url productid:@"" success:nil fail:nil];
        }];
    }


}



@end
