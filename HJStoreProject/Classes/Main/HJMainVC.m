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
#import "HJMainSliderHeadView.h"
#import "HJGoodItemCell.h"
#import "HJMainGridSectionFootView.h"
#import "HJMainTopToolView.h"
#import "HJGoodsCountDownCell.h"

@interface HJMainVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

/* collectionView */
@property (strong , nonatomic) UICollectionView *collectionView;
/* nav */
@property (strong , nonatomic) HJMainTopToolView *topToolView;
/* 10个属性 */
@property (strong , nonatomic) NSMutableArray<HJGridItem *> *gridItems;
/* 推荐商品属性 */
@property (strong , nonatomic)NSMutableArray<HJRecommendItem *> *youLikeItems;
@end


/* cell */
static NSString *const HJGridCellIdentifier = @"HJGridCell";
static NSString *const HJGoodItemCellIdentifier = @"HJGoodItemCell";
static NSString *const HJMainSliderHeadViewIdentifier = @"HJMainSliderHeadView";
static NSString *const HJMainGridSectionFootViewIdentifier = @"HJMainGridSectionFootView";
static NSString *const HJGoodsCountDownCellIdentifier = @"HJGoodsCountDownCell";

@implementation HJMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [HJNetworkType isConnected];
    [self setupUI];
    NSLog(@"maxw:%f  maxh:%f",MaxWidth,MaxHeight);
    // Do any additional setup after loading the view.
}

- (void)setupUI {
    self.collectionView.backgroundColor = RGB(245, 245, 245);
    [self setupNavView];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.frame = CGRectMake(0, HJTopNavH, MaxWidth, MaxHeight - HJTabH - HJTopNavH);
        _collectionView.showsVerticalScrollIndicator = NO;
        
        [_collectionView registerClass:[HJGridCell class] forCellWithReuseIdentifier:HJGridCellIdentifier];
        [_collectionView registerClass:[HJGoodItemCell class] forCellWithReuseIdentifier:HJGoodItemCellIdentifier];
        [_collectionView registerClass:[HJGoodsCountDownCell class] forCellWithReuseIdentifier:HJGoodsCountDownCellIdentifier];


        [_collectionView registerClass:[HJMainGridSectionFootView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HJMainGridSectionFootViewIdentifier];
        [_collectionView registerClass:[HJMainSliderHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainSliderHeadViewIdentifier];
        [self.view addSubview:_collectionView];
    }
    _collectionView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collectionView.mj_header endRefreshing];
        });
    }];
    _collectionView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [_collectionView.mj_footer endRefreshing];
        });
    }];
    return _collectionView;
}


- (void)setupNavView {
    _topToolView = [[HJMainTopToolView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 64)];
    _topToolView.leftItemClickBlock = ^{
        NSLog(@"点击了首页扫一扫");

    };
    _topToolView.rightItemClickBlock = ^{
        NSLog(@"点击了首页分类");
    };
    [self.view addSubview:self.topToolView];
}

- (NSMutableArray<HJGridItem *> *)gridItems {
    if (!_gridItems) {
        _gridItems = [[NSMutableArray alloc] init];
        _gridItems = [HJGridItem mj_objectArrayWithFilename:@"GoodsGrid.plist"];
    }
    return _gridItems;
}

- (NSMutableArray<HJRecommendItem *> *)youLikeItems {
    if (!_youLikeItems) {
        _youLikeItems = [[NSMutableArray alloc] init];
        _youLikeItems = [HJRecommendItem mj_objectArrayWithFilename:@"HomeHighGoods.plist"];
    }
    return _youLikeItems;
}


#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y > HJNavH) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }else{
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    }
}


#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if(section == HJMainVCSectionTypeSection0){
        return self.gridItems.count;
    }
    if(section == HJMainVCSectionTypeSection1){
        return 1;
    }
    if(section == HJMainVCSectionTypeSection2){
        return self.youLikeItems.count;
    }

    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = [[UICollectionViewCell alloc] init];
    if (indexPath.section == HJMainVCSectionTypeSection0) {
        HJGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGridCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        HJGridItem *item = [self.gridItems objectAtIndex:indexPath.row];
        [cell updeteCellWithGridItem:item];
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection1) {
        HJGoodsCountDownCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodsCountDownCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        gridcell = cell;
    }else if (indexPath.section == HJMainVCSectionTypeSection2) {
        HJGoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodItemCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        HJRecommendItem *item = [self.youLikeItems objectAtIndex:indexPath.row];
        [cell setItemCellWithItem:item];
        gridcell = cell;
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] init];
    
    if (kind == UICollectionElementKindSectionHeader){
        if (indexPath.section == HJMainVCSectionTypeSection0) {
            HJMainSliderHeadView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainSliderHeadViewIdentifier forIndexPath:indexPath];
            headerView.imageGroupArray = GoodsHomeSilderImagesArray;
            reusableview = headerView;
        }
    }else{
        if (indexPath.section == HJMainVCSectionTypeSection0) {
            HJMainGridSectionFootView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:HJMainGridSectionFootViewIdentifier forIndexPath:indexPath];
            reusableview = footerView;
        }
    }
    return reusableview;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == HJMainVCSectionTypeSection0) {//9宫格组
        return CGSizeMake(MaxWidth/5 , MaxWidth/5 + 10);
    }
    if (indexPath.section == HJMainVCSectionTypeSection1) {//广告
        return CGSizeMake(MaxWidth, 180);
    }
    if (indexPath.section == HJMainVCSectionTypeSection2) {//计时
        return CGSizeMake((MaxWidth - 4)/2, (MaxWidth - 4)/2 + 40);
    }

    return CGSizeZero;
}

#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (section == HJMainVCSectionTypeSection2) ? 4 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (section == HJMainVCSectionTypeSection2) ? 4 : 0;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == HJMainVCSectionTypeSection0) {
        return CGSizeMake(MaxWidth, 230); //图片滚动的宽高
    }
    return CGSizeZero;
}

//#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == HJMainVCSectionTypeSection0) {
        return CGSizeMake(MaxWidth, 140);  //Top头条的宽高
    }
    return CGSizeZero;
}

@end
