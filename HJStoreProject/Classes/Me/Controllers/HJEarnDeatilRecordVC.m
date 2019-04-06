//
//  HJEarnDeatilRecordVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/30.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarnDeatilRecordVC.h"
#import "HJEarnDetailCell.h"
#import "HJSettingRequest.h"

@interface HJEarnDeatilRecordVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UIImageView *navView;
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSMutableArray *dataSource;
@end

static NSString *const HJEarnDetailCellIdentifier = @"HJEarnDetailCell";

@implementation HJEarnDeatilRecordVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNav];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.navView.mas_bottom).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
    
}

- (void)setupNav {
    CGFloat navH = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    UIImageView *navView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earnDetailRecord_nav"]];
    navView.userInteractionEnabled = YES;
    navView.frame = CGRectMake(0, 0, MaxWidth, navH);
    _navView = navView;
    [self.view addSubview:navView];

    
    CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? 40 : 20;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, topOffSet, 80, 44)];
    backView.backgroundColor = [UIColor clearColor];
    [navView addSubview:backView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"earn_back"] forState:UIControlStateNormal];
    [backView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(14);
    }];
    UILabel *backLabel = [[UILabel alloc] init];
    backLabel.textColor = [UIColor whiteColor];
    backLabel.text = @"返回";
    backLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:backLabel];
    [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backButton.mas_right).offset(5);
        make.centerY.mas_equalTo(backButton.mas_centerY).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(25);
    }];
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"历史体现记录";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    [navView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.mas_equalTo(backButton.mas_centerY).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(25);
    }];
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)headRefresh {
 
    weakify(self);
    [self refreshActionSuccess:^(NSArray *orders) {
        [weak_self.dataSource setArray:orders];
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_header endRefreshing];
    }];
}

- (void)footRefresh {
    weakify(self)
    [self refreshActionSuccess:^(NSArray *orders) {
        [weak_self.dataSource addObjectsFromArray:orders];
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_footer endRefreshing];
    }];
}

- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    [[HJSettingRequest shared] getApplyCashListSuccess:^(NSArray *records) {
        success(records);
    } fail:^(NSError *error) {
        success([NSArray array]);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJEarnDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:HJEarnDetailCellIdentifier];
    if (!cell) {
        cell = [[HJEarnDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJEarnDetailCellIdentifier];
    }
    HJDrawalRecordModel *record = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateContentWithModel:record];
    return cell;
}
@end
