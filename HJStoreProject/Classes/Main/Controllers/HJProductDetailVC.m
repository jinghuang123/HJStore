//
//  HJProductDetailVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJProductDetailVC.h"
#import "HJMainRequest.h"
#import "HJMainSliderCell.h"
#import "AlibcManager.h"
#import "HJProductDetailContentCell.h"
#import "HJShareVC.h"
#import "HJShareMainImageView.h"

static NSString *const HJProductDetailContentCellIdentifier = @"HJProductDetailContentCell";
static NSString *const HJProductDetailCellIdentifier = @"HJProductDetailCell";
static NSString *const HJProductDetailTipCellIdentifier = @"HJProductDetailTipCell";
static NSString *const HJGoodItemSingleCellIdentifier = @"HJGoodItemSingleCell";


@interface HJProductDetailVC () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) HJMainSliderView *tableHeadView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *randoms;
@property (nonatomic, strong) HJRecommendModel *detailmodel;
@property (nonatomic, strong) UIButton *couponInfoBtn;
@property (nonatomic, strong) HJShareMainImageView *shareMainImageV;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *earningLabel;
@end

@implementation HJProductDetailVC

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSMutableArray *)randoms {
    if(!_randoms){
        _randoms = [[NSMutableArray alloc] init];
    }
    return _randoms;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self setupNavItems];
    [self setupButtons];
    [[HJMainRequest shared] getProductDetailCache:YES productId:self.productId success:^(HJRecommendModel *recommendModel) {
        self.tableHeadView.imageGroupArray = recommendModel.small_images.count == 0 ? @[recommendModel.pict_url] : recommendModel.small_images;
        self.detailmodel = recommendModel;
        NSString *tip = [NSString stringWithFormat:@"领券 ¥%@",recommendModel.coupon_amount];
        [self.couponInfoBtn setTitle:tip forState:UIControlStateNormal];
        self.earningLabel.text = @"赚¥6.88";
        [self getRamdoms];
    } fail:^(NSError *error) {
        
    }];

}

- (void)getRamdoms {
    
    HJShareMainImageView *imageV = [[HJShareMainImageView alloc] initWithFrame:CGRectMake(MaxWidth, 0, 375, 667) andDetailModel:self.detailmodel];
    self.shareMainImageV = imageV;
    [self.view addSubview:imageV];
    
    [[HJMainRequest shared] getRandomListCache:YES pageSize:10 success:^(NSArray *recommends) {
        [self.randoms setArray:recommends];
        [self.dataSource addObjectsFromArray:@[self.detailmodel,@(NO),@[],self.randoms]];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

- (UITableView *)tableView {
    if (!_tableView) {
        CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? -49 : -20;
        CGFloat tableViewH = MaxHeight >= ENM_SCREEN_H_X ? MaxHeight : MaxHeight - 29;
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, topOffSet, MaxWidth, tableViewH)];
        _tableView = tableView;
        tableView.backgroundColor = [UIColor clearColor];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
        HJMainSliderView *tableHeadView = [[HJMainSliderView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 400)];
        _tableHeadView = tableHeadView;
        tableView.tableHeaderView = tableHeadView;
        
        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    }
    return _tableView;
}

- (void)headRefresh  {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableView.mj_header endRefreshing];
    });
}



- (void)setupNavItems {
    CGFloat navH = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    CGFloat buttonOffset = MaxHeight >= ENM_SCREEN_H_X ? 40 : 20;
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, navH)];
    _navView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _navView.layer.borderWidth = 0.2;
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, buttonOffset, 60, 44)];
    backView.backgroundColor = [UIColor clearColor];
    
    UIButton *backButton = [[UIButton alloc] init];
    _backButton = backButton;
    [backButton setBackgroundImage:[UIImage imageNamed:@"detail_nav_back"] forState:UIControlStateNormal];
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self back];
    }];
    [backButton jk_addActionHandler:^(NSInteger tag) {
        [self back];
    }];
    [backView addSubview:backButton];
    [_navView addSubview:backView];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(11);
    }];
}


- (void)setupButtons {
    UIView *shareView = [[UIView alloc] init];
    shareView.backgroundColor = [UIColor orangeColor];
    UIImageView *earnPreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earn_pre"]];

    
    UILabel *earningLabel =  [[UILabel alloc] init];
    _earningLabel = earningLabel;
    earningLabel.textColor = [UIColor whiteColor];
    earningLabel.font = [UIFont systemFontOfSize:16];
    earningLabel.textAlignment = NSTextAlignmentLeft;

    
    
    UIButton *couponInfoBtn = [[UIButton alloc] init];
    _couponInfoBtn = couponInfoBtn;
    couponInfoBtn.backgroundColor = [UIColor redColor];
    [couponInfoBtn setTitle:@"领券 ¥3" forState:UIControlStateNormal];
    [couponInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    couponInfoBtn.titleLabel.font = PFR16Font;
    [couponInfoBtn addTarget:self action:@selector(couponInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:shareView];
    [shareView addSubview:earnPreIcon];
    [shareView addSubview:earningLabel];
    [self.view addSubview:couponInfoBtn];
 
    [shareView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self shareAction];
    }];

    
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(MaxWidth/3);
    }];
    [earnPreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.height.mas_equalTo(18);
        make.top.mas_equalTo(16);
    }];
    [earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnPreIcon.mas_right).offset(5);
        make.width.mas_equalTo(65);
        make.top.mas_offset(13);
        make.height.mas_equalTo(23);
    }];

    
    [couponInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(MaxWidth * 2/3);
    }];
}

- (void)back {
    [self.navigationController popViewControllerAnimated:YES];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
        return  1;
    }else if(section == 1){
        NSNumber *contain = [self.dataSource objectAtIndex:section];
        return [contain boolValue] ? 1 : 0;
    }else if(section == 2){
        return 1;
    }else{
        NSArray *randoms = [self.dataSource objectAtIndex:section];
        return randoms.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        HJProductDetailContentCell *contentCell = [tableView dequeueReusableCellWithIdentifier:HJProductDetailContentCellIdentifier];
        if (!contentCell) {
            contentCell = [[HJProductDetailContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJProductDetailContentCellIdentifier];
        }
        HJRecommendModel *detailModel = [self.dataSource objectAtIndex:0];
        [contentCell setcontentWithModel:detailModel];
        weakify(self)
        contentCell.conponGetBlock = ^(id obj) {
            [weak_self couponInfo];
        };
        cell = contentCell;
    }else if(indexPath.section == 1){
        HJProductDetailCell *detailcell = [tableView dequeueReusableCellWithIdentifier:HJProductDetailCellIdentifier];
        if (!detailcell) {
            detailcell = [[HJProductDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJProductDetailCellIdentifier];
        }
        cell = detailcell;
    }else if(indexPath.section == 2){
        HJProductDetailTipCell *tipCell = [tableView dequeueReusableCellWithIdentifier:HJProductDetailTipCellIdentifier];
        if (!tipCell) {
            tipCell = [[HJProductDetailTipCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJProductDetailTipCellIdentifier];
        }
        cell = tipCell;
    }else {
        HJRecommendModel *recommend = self.dataSource[indexPath.section][indexPath.row];
        HJGoodItemsSingleCell *listCell = [tableView dequeueReusableCellWithIdentifier:HJGoodItemSingleCellIdentifier];
        if (!listCell) {
            listCell = [[HJGoodItemsSingleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJGoodItemSingleCellIdentifier];
        }
        [listCell setItemCellWithItem:recommend];
        cell = listCell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 230;
    }else if(indexPath.section == 1) {
        return 50;
    }else if(indexPath.section == 2) {
        return 60;
    }else{
        return 150;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        HJRecommendModel *recommend = self.dataSource[indexPath.section][indexPath.row];
        HJProductDetailVC *detailVc = [[HJProductDetailVC alloc] init];
        detailVc.productId = recommend.item_id;
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.mj_offsetY < 200) {
        [_backButton setBackgroundImage:[UIImage imageNamed:@"detail_nav_back"] forState:UIControlStateNormal];
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:scrollView.mj_offsetY/200];
    }else{
        [_backButton setBackgroundImage:[UIImage imageNamed:@"NavBar_backImg"] forState:UIControlStateNormal];
        _navView.backgroundColor = [UIColor whiteColor];
    }

}

- (UIImage *)getShareImage {
    UIGraphicsBeginImageContextWithOptions(self.shareMainImageV.mj_size,NO, 0.0);//设置截屏大小
    [self.shareMainImageV.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)shareAction {
    NSLog(@"shareAction");
    weakify(self)
    NSString *productId = [self.productId integerValue] > 0 ? self.productId : self.searchModel.item_id;
    [[HJMainRequest shared] getShareDataCache:YES productId:productId title:self.detailmodel.title url:self.detailmodel.coupon_share_url success:^(HJShareModel *share) {
        HJShareVC *shareVC = [[HJShareVC alloc] init];
        share.title = self.detailmodel.title;
        share.product_id = self.productId;
        share.reserve_price = self.detailmodel.reserve_price;
        share.zk_final_price = self.detailmodel.zk_final_price;
        share.coupon_value = self.detailmodel.coupon_amount;
        share.images = self.detailmodel.small_images;
        share.mainImage = [weak_self getShareImage];
        share.showCoupon = YES;
        shareVC.shareModel = share;
        [self.navigationController pushViewController:shareVC animated:YES];
    } fail:^(NSError *error) {
    }];
}

- (void)couponInfo {
    [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:self webView:nil url:self.detailmodel.coupon_share_url success:nil fail:nil];
}



@end
