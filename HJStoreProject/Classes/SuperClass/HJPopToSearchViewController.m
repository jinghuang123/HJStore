//
//  HJPopToSearchViewController.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/4.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJPopToSearchViewController.h"

@interface HJPopToSearchViewController ()

@end

@implementation HJPopToSearchViewController
//searchPop_top
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self setUpView];
}

- (void)setUpView {
    UIImageView *topView = [[UIImageView alloc] init];
    topView.image = [UIImage imageNamed:@"searchPop_top"];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-120);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(120);
    }];
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).offset(0);
        make.left.mas_equalTo(topView.mas_left).offset(0);
        make.right.mas_equalTo(topView.mas_right).offset(0);
        make.height.mas_equalTo(220);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont boldSystemFontOfSize:20];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"智能搜索优惠券";
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.centerY.equalTo(topView).offset(5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(30);
    }];
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.font = [UIFont systemFontOfSize:12];
    subtitleLabel.textColor = [UIColor whiteColor];
    subtitleLabel.text = @"您是否搜索以下商品";
    subtitleLabel.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:subtitleLabel];
    [subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(titleLabel);
        make.top.equalTo(titleLabel.mas_bottom).offset(0);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.text = self.searchTip;
    tipLabel.numberOfLines = 0;
    [bottomView addSubview:tipLabel];
    CGFloat tipH = [NSString heightOfString:self.searchTip font:tipLabel.font width:260];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView);
        make.centerY.equalTo(bottomView).offset(-20);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(tipH);
    }];
    
    [bottomView jk_addBottomBorderWithColor:[UIColor clearColor] width:1];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [bottomView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.bottom.equalTo(bottomView).offset(-45);
        make.right.equalTo(bottomView);
        make.height.mas_equalTo(1);
    }];
    
    UIView *vlineView = [[UIView alloc] init];
    vlineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [bottomView addSubview:vlineView];
    [vlineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.bottom.equalTo(bottomView).offset(0);
        make.width.mas_equalTo(1);
        make.centerX.mas_equalTo(bottomView);
    }];
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [bottomView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView);
        make.bottom.equalTo(bottomView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(44);
    }];
    [cancelButton jk_addActionHandler:^(NSInteger tag) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchButton setTitle:@"搜索" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor jk_colorWithHexString:@"#E32828"] forState:UIControlStateNormal];
    [bottomView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bottomView);
        make.bottom.equalTo(bottomView);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(44);
    }];
    [searchButton jk_addActionHandler:^(NSInteger tag) {
        if (self.searchBlock) {
            self.searchBlock(self.searchTip);
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
