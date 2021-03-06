//
//  HJSearchListVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSearchListVC.h"
#import "HJMainRequest.h"
#import "HJGoodItemCell.h"
#import "HJMainListHeadView.h"
#import "HJProductDetailVC.h"
#import "HJMainPodVC.h"

static NSString *const HJGoodItemCellIdentifier = @"HJGoodItemSearchCell";
static NSString *const HJGoodItemSingleCellIdentifier =  @"HJGoodItemSingleSearchCell";
static NSString *const HJMainListHeadViewIdentifier2 = @"HJMainListHeadViewList2";

@interface HJSearchListVC () <UISearchBarDelegate,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UISearchBar *searchBar;
/* collectionView */
@property (strong , nonatomic) UICollectionView *collectionView;
/* recommends */
@property (strong , nonatomic) NSMutableArray<HJRecommendModel *> *searchmodels;


@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@property (assign , nonatomic) NSInteger sort;
@property (strong , nonatomic) NSString *showCouponsOnly;

@property (assign , nonatomic) GoodsListShowType showType;
@property(nonatomic,strong)  HJMainPodVC *sortTypePopVC;

@property(nonatomic,strong)  HJMainListHeadViewList *headerView;

@end

@implementation HJSearchListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarButtonItem];
    self.showCouponsOnly = @"false";
    self.showType = signleLineShowDoubleGoods;
    self.collectionView.backgroundColor = RGB(245, 245, 245);
    [self.collectionView.mj_header beginRefreshing];
}

- (NSMutableArray<HJRecommendModel *> *)searchmodels {
    if (!_searchmodels) {
        _searchmodels = [[NSMutableArray alloc] init];
    }
    return _searchmodels;
}

- (void)switchChange:(BOOL)on {
    self.showCouponsOnly = on ? @"true" : @"false";
    [self.collectionView.mj_header beginRefreshing];
}

- (void)headRefresh {
    self.pageNo = 1;
    weakify(self)
    [self refreshActionSuccess:^(id responseObject) {
        [weak_self.collectionView.mj_header endRefreshing];
    }];
}

- (void)footRefresh {
    self.pageNo++;
    weakify(self)
    [self refreshActionSuccess:^(id responseObject) {
        [weak_self.collectionView.mj_footer endRefreshing];
    }];
}


- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    [[HJMainRequest shared] getListBySearchCodeCache:YES soreType:self.search_type code:self.searchTip pageNo:self.pageNo pageSize:self.pageSize has_coupon:self.showCouponsOnly sort:self.sort success:^(NSDictionary *response) {
        if (self.pageNo > 1) {
            [self.searchmodels addObjectsFromArray:[response objectForKey:@"searchModel"]];
            if (self.searchmodels.count < 20) {
                [self.collectionView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
            }
        }else{
            self.searchmodels = [response objectForKey:@"searchModel"];
        }
        [self.collectionView reloadData];
        success(nil);
    } fail:^(NSError *error) {
        success(nil);
    }];
}

- (void)setBarButtonItem {
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width - 40, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 40, 30)];
    _searchBar = searchBar;
    searchBar.placeholder = @"搜索内容";
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    UITextField *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
    searchTextField.backgroundColor = RGBA(234, 235, 237, 1.0);
    [searchTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    searchTextField.font = [UIFont systemFontOfSize:14];
    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    [titleView addSubview:searchBar];
    self.searchBar.text = self.searchTip;
    self.searchBar = searchBar;
    self.navigationItem.titleView = titleView;
    

 
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    cancleBtn.hidden = YES;
    
    UIButton *rightNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNav setBackgroundImage:[UIImage imageNamed:@"search_Nav_right"] forState:UIControlStateNormal];
    [rightNav setTitle:@"搜索" forState:UIControlStateNormal];
    rightNav.titleLabel.font = [UIFont systemFontOfSize:11];
    rightNav.titleLabel.textColor = [UIColor whiteColor];
    [rightNav addTarget:self action:@selector(onClickSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNav];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        [layout setSectionHeadersPinToVisibleBounds:YES];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
 
        _collectionView.frame = CGRectMake(0, 0, MaxWidth, MaxHeight);
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.alwaysBounceVertical = YES;
        
        [_collectionView registerClass:[HJGoodItemCell class] forCellWithReuseIdentifier:HJGoodItemCellIdentifier];
        [_collectionView registerClass:[HJGoodItemSingleCell class] forCellWithReuseIdentifier:HJGoodItemSingleCellIdentifier];
        
        [_collectionView registerClass:[HJMainListHeadViewList class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier2];
        
        _collectionView.mj_footer.ignoredScrollViewContentInsetBottom = MaxHeight >= ENM_SCREEN_H_X ? 34 : 0;
        
        _collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
        _collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
        
        [self.view addSubview:_collectionView];
    }
    
    return _collectionView;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self onClickSearch];
}

- (void)onClickSearch {
    [self.searchBar resignFirstResponder];
    self.searchTip = _searchBar.text;
    [self headRefresh];
}

- (void)backButtonClick {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.searchmodels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *gridcell = [[UICollectionViewCell alloc] init];
    if (self.showType == signleLineShowDoubleGoods) {
        HJGoodItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodItemCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        HJRecommendModel *item = [self.searchmodels objectAtIndex:indexPath.row];
        [cell setItemCellWithItem:item];
        gridcell = cell;
    }else{
        HJGoodItemSingleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGoodItemSingleCellIdentifier forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        HJRecommendModel *item = [self.searchmodels objectAtIndex:indexPath.row];
        [cell setItemCellWithItem:item];
        gridcell = cell;
    }
    return gridcell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
 
    HJMainListHeadViewList *headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJMainListHeadViewIdentifier2 forIndexPath:indexPath];
    _headerView = headerView;
    headerView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    headerView.layer.borderWidth = 0.5;
    headerView.backgroundColor = [UIColor whiteColor];
    weakify(self)
    headerView.switchChangeBlock = ^(BOOL on) {
        [weak_self switchChange:on];
    };
    weakify(headerView)
    headerView.sortTypeChengBlock = ^(NSNumber *index) {
        if ([index integerValue] == 0) {
            [weak_self podSortTypeView];
        }else if([index integerValue] == 1) {
            weak_self.sort = weak_self.sort == HJSortTypePriceHtoL ? HJSortTypePriceLtoH  : HJSortTypePriceHtoL;
            [weak_self headRefresh];
             [weak_headerView setSortImageWithType:weak_self.sort];
        }else if([index integerValue] == 2) {
            weak_self.sort = weak_self.sort == HJSortTypeShellCountHtoL ? HJSortTypeShellCountLtoH : HJSortTypeShellCountHtoL;
            [weak_self headRefresh];
             [weak_headerView setSortImageWithType:weak_self.sort];
        }
       
    };
    headerView.showModeChangedBlock = ^(id obj) {
        if (weak_self.showType == singleLineShowOneGoods) {
            [weak_headerView.rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_wangge"] forState:UIControlStateNormal];
            weak_self.showType = signleLineShowDoubleGoods;
        }else{
            [weak_headerView.rightBtn setBackgroundImage:[UIImage imageNamed:@"nav_list_single"] forState:UIControlStateNormal];
            weak_self.showType = singleLineShowOneGoods;
        }
        [weak_self.collectionView reloadData];
    };
    return headerView;
}


- (void)podSortTypeView {
    if (self.showPopPoint.y == 0) {
        CGFloat pointY = MaxHeight >= ENM_SCREEN_H_X ? 128 : 103;
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
            [weak_self.headerView setSortImageWithType:weak_self.sort];
            [weak_self.sortTypePopVC dismissViewControllerAnimated:YES completion:nil];
        };
        self.sortTypePopVC.isPopState = YES;
        [self presentViewController:self.sortTypePopVC animated:YES completion:nil];
    }else{
        self.sortTypePopVC.isPopState = NO;
        [self.sortTypePopVC dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.showType == signleLineShowDoubleGoods) {
        return CGSizeMake((MaxWidth - 15)/2, (MaxWidth - 5)/2 + 110);
    }else{
        return CGSizeMake(MaxWidth, 150);
    }
}

#pragma mark - X间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.showType == signleLineShowDoubleGoods ? 5 : 0;
}
#pragma mark - Y间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.showType == signleLineShowDoubleGoods ? 5 : 0;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return self.showType == signleLineShowDoubleGoods ? UIEdgeInsetsMake(5, 5, 0, 5) : UIEdgeInsetsZero;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(MaxWidth, 80); //section3高
}

//#pragma mark - foot宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJRecommendModel *item = [self.searchmodels objectAtIndex:indexPath.row];
    [self pushToProductDetailWithItem:item];
    
}

- (void)pushToProductDetailWithItem:(HJRecommendModel *)item {
    HJProductDetailVC *productDetailVC = [[HJProductDetailVC alloc] init];
    productDetailVC.productId = item.item_id;
    productDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

@end
