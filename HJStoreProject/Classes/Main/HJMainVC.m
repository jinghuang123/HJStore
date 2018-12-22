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
#import "HJMainTopToolView.h"
#import "HJGoodsCountDownCell.h"
#import "HJMainListHeadView.h"


@interface HJMainVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic) UICollectionView *collectionView;
/* nav */
@property (strong , nonatomic) HJMainTopToolView *topToolView;

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
@property (assign , nonatomic) NSInteger sort;
@end


/* cell */
static NSString *const HJGridCellIdentifier = @"HJGridCell";
static NSString *const HJGoodItemCellIdentifier = @"HJGoodItemCell";
static NSString *const HJMainSliderCellIdentifier = @"HJMainSliderCellI";

static NSString *const HJMainListHeadViewIdentifier = @"HJMainListHeadView";

static NSString *const HJMainGridSectionFootViewIdentifier = @"HJMainGridSectionFootView";
static NSString *const HJGoodsCountDownCellIdentifier = @"HJGoodsCountDownCell";

@implementation HJMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sort = 1;
    self.pageSize = 30;
    [HJNetworkType isConnected];
    [self setupUI];
    NSLog(@"maxw:%f  maxh:%f",MaxWidth,MaxHeight);
    [self.collectionView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self refreshActionSuccess:^(id responseObject) {
            [weak_self.collectionView.mj_footer endRefreshing];
        }];
    });
}


- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    if(self.catteryId > 0){
        [[HJMainRequest shared] getMainListByCategoryIdCache:NO categoryId:self.catteryId pageNo:self.pageNo pageSize:self.pageSize sort:self.sort success:^(NSDictionary *response) {
            if (self.pageNo > 1) {
                [self.recommends addObjectsFromArray:[response objectForKey:@"recommends"]];
                if (self.recommends.count < 20) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                }
            }else{
                self.recommends = [response objectForKey:@"recommends"];
                self.activitys = [response objectForKey:@"categorys"];
            }
            success(nil);
            [self.collectionView reloadData];
        } fail:^(NSError *error) {
            success(nil);
        }];

    }else{
        [[HJMainRequest shared] getMainListCache:NO pageNo:self.pageNo pageSize:self.pageSize success:^(NSDictionary *response) {
            if (self.pageNo > 1) {
                [self.recommends addObjectsFromArray:[response objectForKey:@"recommends"]];
                if (self.recommends.count < 20) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
                }
            }else{
                self.banners = [response objectForKey:@"banners"];
                self.bannerImages = [response objectForKey:@"bannerImages"];
                self.activitys = [response objectForKey:@"activitys"];
                self.rollings = [response objectForKey:@"rollings"];
                self.recommends = [response objectForKey:@"recommends"];
            }
            success(nil);
            [self.collectionView reloadData];
        } fail:^(NSError *error) {
            success(nil);
        }];
    }
}




- (void)setupUI {
    self.collectionView.backgroundColor = RGB(245, 245, 245);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        [layout setSectionHeadersPinToVisibleBounds:self.catteryId > 0];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, 0, MaxWidth, MaxHeight - HJTabH - HJTopNavH - 5);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[HJMainSliderCell class] forCellWithReuseIdentifier:HJMainSliderCellIdentifier];
        [_collectionView registerClass:[HJGridCell class] forCellWithReuseIdentifier:HJGridCellIdentifier];
        [_collectionView registerClass:[HJGoodItemCell class] forCellWithReuseIdentifier:HJGoodItemCellIdentifier];
        [_collectionView registerClass:[HJGoodsCountDownCell class] forCellWithReuseIdentifier:HJGoodsCountDownCellIdentifier];
   

        [_collectionView registerClass:[HJMainGridSectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HJMainGridSectionFootViewIdentifier];
        
        [_collectionView registerClass:[HJMainListHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier];
        
        _collectionView.mj_footer.ignoredScrollViewContentInsetBottom = MaxHeight >= ENM_SCREEN_H_X ? 34 : 0;
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
        
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

- (NSMutableArray<NSString *> *)bannerImages {
    if(!_bannerImages){
        _bannerImages = [[NSMutableArray alloc] init];
    }
    return _bannerImages;
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
        return 0;
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
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection1) {
        HJGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGridCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        NSObject *obj = [self.activitys objectAtIndex:indexPath.row];
        if ([obj isKindOfClass:[HJActivityModel class]]) {
            HJActivityModel *item = (HJActivityModel *)obj;
            [cell updeteCellWithActivityItem:item];
        }else{
            HJSubCategoryModel *item = (HJSubCategoryModel *)obj;
            [cell updeteCellWithGridItem:item];
        }
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection2) {
        HJGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodsCountDownCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection3) {
        HJGoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodItemCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        HJRecommendModel *item = [self.recommends objectAtIndex:indexPath.row];
        [cell setItemCellWithItem:item];
        gridcell = cell;
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] init];
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == HJMainVCSectionTypeSection3) {
            UICollectionReusableView *headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier forIndexPath:indexPath];
            headerView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
            headerView.layer.borderWidth = self.catteryId > 0 ? 0.5 : 0;
            headerView.backgroundColor = [UIColor whiteColor];
            reusableview = headerView;
        }
    }else{
        if (indexPath.section == HJMainVCSectionTypeSection1) {
            HJMainGridSectionFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HJMainGridSectionFootViewIdentifier forIndexPath:indexPath];
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
        return CGSizeMake(MaxWidth, 180);
    }
    if (indexPath.section == HJMainVCSectionTypeSection3) {//列表
        return CGSizeMake((MaxWidth - 15)/2, (MaxWidth - 5)/2 + 90);
    }

    return CGSizeZero;
}

#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == HJMainVCSectionTypeSection3) ? 5 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection1) {
        return 0;
    }else if(section == HJMainVCSectionTypeSection2){
        return 0;
    }else if(section == HJMainVCSectionTypeSection3){
        return 5;
    }else{
        return 0;
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection1) {

        return UIEdgeInsetsZero;
    }else if(section == HJMainVCSectionTypeSection2){
        if (self.catteryId == 0) {
            return UIEdgeInsetsMake(0, 0, 8, 0);
        }
        return UIEdgeInsetsZero;
    }else if(section == HJMainVCSectionTypeSection3){
        return UIEdgeInsetsMake(5, 5, 0, 5);
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

@end
