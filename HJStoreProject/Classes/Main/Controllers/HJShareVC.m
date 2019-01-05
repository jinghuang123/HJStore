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
        tableView.backgroundColor = [UIColor clearColor];
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




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJShareCell"];
    if (!cell) {
        cell = [[HJShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HJShareCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240;
}
@end
