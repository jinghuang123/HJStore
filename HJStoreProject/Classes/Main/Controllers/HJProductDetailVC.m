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
@property (nonatomic, strong) HJProductDetailModel *detailmodel;
@property (nonatomic, strong) UIButton *couponInfoBtn;
@property (nonatomic, strong) HJShareMainImageView *shareMainImageV;
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
    if (self.productId > 0) {
        [[HJMainRequest shared] getProductDetailCache:YES productId:self.productId success:^(HJProductDetailModel *detailModel) {
            self.tableHeadView.imageGroupArray = detailModel.small_images;
            self.detailmodel = detailModel;
            NSString *tip = [NSString stringWithFormat:@"领券 ¥%@",detailModel.coupon_value];
            [self.couponInfoBtn setTitle:tip forState:UIControlStateNormal];
            [self getRamdoms];
        } fail:^(NSError *error) {
            
        }];
    }else if(self.searchModel){
        
        self.detailmodel = [[HJProductDetailModel alloc] init];
        self.tableHeadView.imageGroupArray = self.searchModel.small_images.string;
        self.detailmodel.title = self.searchModel.title;
        self.detailmodel.user_type = self.searchModel.user_type;
        self.detailmodel.zk_final_price = self.searchModel.zk_final_price;
        self.detailmodel.reserve_price = self.searchModel.reserve_price;
        self.detailmodel.pict_url_image = self.searchModel.pict_url;
        self.detailmodel.coupon_click_url = self.searchModel.coupon_share_url ? self.searchModel.coupon_share_url : @"";
        self.detailmodel.nick = self.searchModel.shop_title;
        self.detailmodel.volume = self.searchModel.volume;
        self.detailmodel.coupon_value = self.searchModel.coupon_value;
        NSString *tip = [NSString stringWithFormat:@"领券 ¥%@",self.detailmodel.coupon_value];
        [self.couponInfoBtn setTitle:tip forState:UIControlStateNormal];
        [self getRamdoms];
    }
}

- (void)getRamdoms {
    
    HJShareMainImageView *imageV = [[HJShareMainImageView alloc] initWithFrame:CGRectMake(MaxWidth, MaxHeight, 375, 667) andDetailModel:self.detailmodel];
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
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, MaxWidth, MaxHeight - 29)];
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
    _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 64)];
    _navView.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    _navView.layer.borderWidth = 0.2;
    _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
    [self.view addSubview:_navView];
    
    UIButton *backButton = [[UIButton alloc] init];
    [backButton setBackgroundImage:[UIImage imageNamed:@"NavBar_backImg"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(25);
        make.height.width.mas_equalTo(20);
    }];
}


- (void)setupButtons {
    UIButton *shareBtn = [[UIButton alloc] init];
    shareBtn.backgroundColor = [UIColor orangeColor];
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];

    shareBtn.titleLabel.font = PFR16Font;
    UIButton *couponInfoBtn = [[UIButton alloc] init];
    _couponInfoBtn = couponInfoBtn;
    couponInfoBtn.backgroundColor = [UIColor redColor];
    [couponInfoBtn setTitle:@"领券 ¥3" forState:UIControlStateNormal];
    [couponInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    couponInfoBtn.titleLabel.font = PFR16Font;
    [couponInfoBtn addTarget:self action:@selector(couponInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareBtn];
    [self.view addSubview:couponInfoBtn];
    
    [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.height.mas_equalTo(49);
        make.width.mas_equalTo(MaxWidth/3);
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
        HJProductDetailModel *detailModel = [self.dataSource objectAtIndex:0];
        [contentCell setcontentWithModel:detailModel];
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
        return 175;
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
        detailVc.productId = recommend.product_id;
        [detailVc setNavBackItem];
        [self.navigationController pushViewController:detailVc animated:YES];
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"yOffset = %f",scrollView.mj_offsetY);
    if(scrollView.mj_offsetY < 200) {
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:scrollView.mj_offsetY/200];
    }else{
        _navView.backgroundColor = [UIColor whiteColor];
    }

}

- (UIImage *)getShareImage {
    // 创建拼接头部view
    UIGraphicsBeginImageContextWithOptions(self.shareMainImageV.mj_size,NO, 0.0);//设置截屏大小
    [self.shareMainImageV.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)shareAction {
    NSLog(@"shareAction");
    weakify(self)
    NSInteger productId = self.productId > 0 ? self.productId : self.searchModel.num_iid;
    [[HJMainRequest shared] getShareDataCache:YES productId:productId title:self.detailmodel.title url:self.detailmodel.coupon_click_url success:^(HJShareModel *share) {
        HJShareVC *shareVC = [[HJShareVC alloc] init];
        share.title = self.detailmodel.title;
        share.product_id = self.productId;
        share.reserve_price = self.detailmodel.reserve_price;
        share.zk_final_price = self.detailmodel.zk_final_price;
        share.coupon_value = self.detailmodel.coupon_value;
        share.images = self.detailmodel.small_images;
        share.mainImage = [weak_self getShareImage];
        share.showCoupon = YES;
        shareVC.shareModel = share;
        [shareVC setNavBackItem];
        [self.navigationController pushViewController:shareVC animated:YES];
    } fail:^(NSError *error) {
    }];

    

}

- (void)couponInfo {
    [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:self webView:nil url:self.detailmodel.coupon_click_url success:nil fail:nil];
}



@end
