//
//  HJShareVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareVC.h"
#import "HJShareCell.h"

@interface HJShareVC ()  <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@end

@implementation HJShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
}

- (UITableView *)tableview {
    if (!_tableview) {
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight)];
        _tableview = tableView;
        tableView.backgroundColor = RGB(245, 245, 245);;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;

        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    }
    return _tableview;
}

- (void)headRefresh {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableview.mj_header endRefreshing];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 10)];
        view.backgroundColor = self.tableview.backgroundColor;
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 0)];
        view.backgroundColor = self.tableview.backgroundColor;
        return view;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HJShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJShareCell"];
        if (!cell) {
            cell = [[HJShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HJShareCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellWithModel:self.shareModel];
        weakify(self)
        cell.couponShowBlock = ^(id obj) {
            weak_self.shareModel.showCoupon = !self.shareModel.showCoupon;
            [weak_self.tableview reloadData];
        };
        return cell;
    }else{
        HJShareImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJShareImagesCell"];
        if (!cell) {
            cell = [[HJShareImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HJShareImagesCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellWithModel:self.shareModel];
        return cell;
    }
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.shareModel.showCoupon ? 240 : 225;
    }else{
        return MaxHeight - 240 - 100;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}
@end
