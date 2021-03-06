//
//  HJOrderListVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/3/10.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJOrderListVC.h"
#import "HJOrderItemCell.h"
#import "HJOrderListRequest.h"

static NSString *HJOrderItemCellIdentifier = @"HJOrderItemCell";

@interface HJOrderListVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@end

@implementation HJOrderListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createUI];
}

- (void)createUI {
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
    weakify(self);
    [self refreshActionSuccess:^(NSArray *orders) {
        [weak_self.dataSource setArray:orders];
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_header endRefreshing];
    }];
}

- (void)footRefresh {
    self.pageNo++;
    weakify(self)
    [self refreshActionSuccess:^(NSArray *orders) {
        [weak_self.dataSource addObjectsFromArray:orders];
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_footer endRefreshing];
    }];
}

- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    [[HJOrderListRequest shared] getOrderListWithStatus:self.type PageNo:self.pageNo PageSize:self.pageSize Success:^(NSArray *orderItems) {
        success(orderItems);
    } fail:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            success([NSArray array]);
        });
    }];

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 101;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJOrderItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HJOrderItemCellIdentifier];
    if(!cell){
        cell = [[HJOrderItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJOrderItemCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    HJOrderListItemModel *order = [self.dataSource objectAtIndex:indexPath.row];
    [cell updateWithOrderItem:order];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
