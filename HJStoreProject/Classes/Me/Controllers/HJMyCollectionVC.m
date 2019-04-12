//
//  HJMyCollectionVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMyCollectionVC.h"
#import "HJMainRequest.h"
#import "HJProductDetailContentCell.h"
#import "HJProductDetailVC.h"



static NSString *HJProductDetailContentCellIdentifier = @"HJProductDetailContentCell";

@interface HJMyCollectionVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@end

@implementation HJMyCollectionVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor jk_colorWithHexString:@"#E32828"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.pageSize = 20;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MaxWidth, MaxHeight - HJTopNavH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#f5f5f5"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];

    [self.tableView.mj_header beginRefreshing];
    
}

- (NSMutableArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)headRefresh {
    self.pageNo = 1;
    weakify(self)
    [self refreshActionSuccess:^(NSArray *fences) {
        [weak_self.tableView.mj_header endRefreshing];
    }];
}

- (void)footRefresh {
    self.pageNo++;
    weakify(self)
    [self refreshActionSuccess:^(id responseObject) {
        [weak_self.tableView.mj_footer endRefreshing];
    }];
}

- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    [[HJMainRequest shared] getFavouriteListWithPage:self.pageNo PageSize:self.pageSize success:^(NSArray *favourites){
        if (self.pageNo == 1) {
            [self.dataSource setArray:favourites];
            favourites.count == 20 ?     self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)] : @"";
        }else{
            [self.dataSource addObjectsFromArray:favourites];
        }
        [self.tableView reloadData];
        success(nil);
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"collectionHeadView"];
    if (!view) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 5)];
        view.backgroundColor = [UIColor clearColor];
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJGoodItemsSingleCell *cell = [tableView dequeueReusableCellWithIdentifier:HJProductDetailContentCellIdentifier];
    if(!cell){
        cell = [[HJGoodItemsSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJProductDetailContentCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HJRecommendModel *recomend = [self.dataSource objectAtIndex:indexPath.section];
    [cell setItemCellWithItem:recomend];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HJRecommendModel *recommend = [self.dataSource objectAtIndex:indexPath.section];
    HJProductDetailVC *detailVc = [[HJProductDetailVC alloc] init];
    detailVc.productId = recommend.item_id;
    [self.navigationController pushViewController:detailVc animated:YES];
}

@end
