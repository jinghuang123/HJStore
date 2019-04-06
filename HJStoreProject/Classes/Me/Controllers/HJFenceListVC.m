//
//  HJFenceListVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJFenceListVC.h"
#import <HMSegmentedControl.h>
#import "HJFenceItemCell.h"
#import "HJFenceRequest.h"

static NSString *HJFenceItemCellIdentifier = @"HJFenceItemCell";

@interface HJFenceListVC () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@end

@implementation HJFenceListVC



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
        [weak_self.dataSource setArray:fences];
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_header endRefreshing];
    }];
}

- (void)footRefresh {
    self.pageNo++;
    [self refreshActionSuccess:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    [[HJFenceRequest shared] getFenceListWithType:self.type success:^(NSArray *fences) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            success(fences);
        });
    } fail:^(NSError *error) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            success(nil);
        });
    }];

}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 58;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJFenceItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HJFenceItemCellIdentifier];
    if(!cell){
        cell = [[HJFenceItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJFenceItemCellIdentifier];
    }
    HJFenceModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    [cell updateContentWithFenceModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
