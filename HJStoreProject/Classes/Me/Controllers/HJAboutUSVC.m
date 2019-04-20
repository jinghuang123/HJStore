//
//  HJAboutUSVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/28.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJAboutUSVC.h"
#import "HJUserInfoCell.h"

@implementation HJAboutUSVC
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于我们";
    // Do any additional setup after loading the view.
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meizhilogo"]];
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(28 + 64);
        make.width.height.mas_equalTo(56);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, MaxWidth, MaxHeight - 120) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.scrollEnabled = NO;
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [self.dataSource setArray:@[@{@"当前版本":BIULD_VERSION}]];
    
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *reuseId = @"reuseId";
    HJUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[HJUserInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    NSDictionary *dic  = [self.dataSource objectAtIndex:indexPath.row];
    NSArray *keys = [dic allKeys];
    NSString *title = [keys objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = title;
    cell.headImageV.hidden = YES;
    cell.valueLab.text = [dic valueForKey:title];
    return cell;
}
@end
