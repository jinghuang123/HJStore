//
//  HJGropPopVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJGropPopVC.h"
#import "HJSuperView.h"
@interface HJGropPopVC ()

@end

@implementation HJGropPopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    [self setUpView];
}

- (void)setUpView {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor whiteColor];
    contentView.layer.cornerRadius  = 5;
    contentView.clipsToBounds = YES;
    [self.view addSubview:contentView];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(360);
        make.center.equalTo(self.view);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pop_group_icon"]];
    [contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(24);
        make.centerX.equalTo(contentView);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(30);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:17];
    titleLabel.text = @"升级运营商";
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.text = @"你还未满足运营商升级条件";
    subTitleLabel.textColor = [UIColor jk_colorWithHexString:@"#515151"];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *tipImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"update_group_tip"]];
    [contentView addSubview:tipImageView];
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(subTitleLabel.mas_bottom).offset(30);
        make.width.mas_equalTo(205);
        make.height.mas_equalTo(14);
    }];
    CGFloat wid = (MaxWidth - 60)/3;
    CGFloat height = 80;
    NSString *fenceNum = [NSString stringWithFormat:@"%ld人",self.groupModel.zsfs];
    UIView *fenceNumView = [self createTipViewWithTitle:@"直属粉丝" subTitle:fenceNum size:CGSizeMake(wid, height)];
    [contentView addSubview:fenceNumView];
    [fenceNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_equalTo(tipImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(wid);
    }];
    
    NSString *tjfenceNum = [NSString stringWithFormat:@"%ld人",self.groupModel.jjfs];
    UIView *tjfenceNumView = [self createTipViewWithTitle:@"推荐粉丝" subTitle:tjfenceNum size:CGSizeMake(wid, height)];
    [contentView addSubview:tjfenceNumView];
    [tjfenceNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fenceNumView.mas_right).offset(0);
        make.top.mas_equalTo(fenceNumView.mas_top).offset(0);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(wid);
    }];
    
    NSString *money = [NSString stringWithFormat:@"%ld元",self.groupModel.yygsy];
    UIView *moneyView = [self createTipViewWithTitle:@"月预估收益" subTitle:money size:CGSizeMake(wid, height)];
    [contentView addSubview:moneyView];
    [moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tjfenceNumView.mas_right).offset(0);
        make.top.mas_equalTo(fenceNumView.mas_top).offset(0);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(wid);
    }];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setBackgroundColor:[UIColor redColor]];
    [commitButton setTitle:@"好的" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 22;
    commitButton.clipsToBounds = YES;
    [contentView addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(moneyView.mas_bottom).offset(20);
        make.left.mas_offset(45);
        make.right.mas_offset(-45);
        make.height.mas_equalTo(44);
    }];
    [commitButton jk_addActionHandler:^(NSInteger tag) {
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }];
}

- (UIView *)createTipViewWithTitle:(NSString *)title subTitle:(NSString *)subTitle size:(CGSize)size {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = title;
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.mas_offset(10);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = [UIFont systemFontOfSize:14];
    subTitleLabel.text = subTitle;
    subTitleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [view addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.bottom.mas_offset(-10);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(20);
    }];
    
    return view;
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
