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

static NSString *const HJProductDetailContentCellIdentifier = @"HJProductDetailContentCell";

@interface HJProductDetailVC () <UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *navView;
@property (nonatomic, strong) HJMainSliderView *tableHeadView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];

    [[HJMainRequest shared] getProductDetailCache:YES productId:self.productId success:^(HJProductDetailModel *detailModel) {
        self.tableHeadView.imageGroupArray = detailModel.small_images;
        [self.dataSource addObjectsFromArray:@[detailModel]];
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
    

    [self setupNavItems];
    [self setupButtons];
}

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, MaxWidth, MaxHeight - 49)];
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
    [backButton setBackgroundImage:[UIImage imageNamed:@"shareBack"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_navView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(15);
        make.height.width.mas_equalTo(30);
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count > 0 ? 1 : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJProductDetailContentCell *cell = [[HJProductDetailContentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJProductDetailContentCellIdentifier];
    HJProductDetailModel *detailModel = [self.dataSource objectAtIndex:0];
    [cell setcontentWithModel:detailModel];
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 140;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"yOffset = %f",scrollView.mj_offsetY);
    if(scrollView.mj_offsetY < 200) {
        _navView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:scrollView.mj_offsetY/200];
    }else{
        _navView.backgroundColor = [UIColor whiteColor];
    }

}

- (void)shareAction {
    NSLog(@"shareAction");
}

- (void)couponInfo {
    [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:self webView:nil productId:self.productId success:nil fail:nil];
}

@end
