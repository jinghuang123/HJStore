//
//  HJMainPodVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainPodVC.h"

@implementation HJSortTypeSelectCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCell];
    }
    return self;
}

- (void)setupCell {
    self.itemName = [[UILabel alloc] init];
    self.itemName.jk_edgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    self.itemName.textAlignment = NSTextAlignmentLeft;
    self.itemName.font = [UIFont systemFontOfSize:15];
    self.itemName.textColor = [UIColor jk_colorWithHexString:@"#999999"];
    [self.contentView addSubview:self.itemName];
    [self.itemName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
}



@end

@interface HJMainPodVC () <UITableViewDelegate,UITableViewDataSource>

@end

@implementation HJMainPodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self setUpView];
}

- (void)setUpView {
    
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self.view addSubview:bgView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissPop)];
    [bgView addGestureRecognizer:tap];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.showViewPoint.x, self.showViewPoint.y, _viewSize.width, _viewSize.height)];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.tableView.scrollEnabled = NO;
}



- (void)dismissPop {
    if (self.popDismissBlock) {
        self.popDismissBlock(YES);
    }
}


#pragma mark tableViewDelegate & dataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * identifier = @"YFBlogTypeSelectCell";
    
    HJSortTypeSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HJSortTypeSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    cell.itemName.text = title;
    if (indexPath.row == self.selectedIndex) {
        cell.itemName.textColor = [UIColor redColor];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.didSelectedRowBlock) {
        self.didSelectedRowBlock(indexPath.row);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
