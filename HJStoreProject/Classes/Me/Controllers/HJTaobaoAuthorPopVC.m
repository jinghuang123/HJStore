//
//  HJTaobaoAuthorPopVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJTaobaoAuthorPopVC.h"

@interface HJTaobaoAuthorPopVC ()
@property (nonatomic, strong) UIButton *closeButton;
@end

@implementation HJTaobaoAuthorPopVC

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
        make.height.mas_equalTo(270);
        make.center.equalTo(self.view);
    }];
    
    
    UIButton *closeButton = [[UIButton alloc] init];
    _closeButton = closeButton;
    [closeButton setBackgroundImage:[UIImage imageNamed:@"ic_login_close"] forState:UIControlStateNormal];
    [contentView addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.right.mas_offset(-20);
        make.width.height.mas_equalTo(20);
    }];
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"taobao_author_icon"]];
    [contentView addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(45);
        make.centerX.equalTo(contentView);
        make.width.height.mas_equalTo(55);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = [UIFont systemFontOfSize:19];
    titleLabel.text = @"淘宝授权通知";
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(10);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.font = [UIFont systemFontOfSize:12];
    subTitleLabel.text = @"淘宝授权后您将可获得更多的权益保障";
    subTitleLabel.textColor = [UIColor jk_colorWithHexString:@"#515151"];
    subTitleLabel.textAlignment = NSTextAlignmentCenter;
    [contentView addSubview:subTitleLabel];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contentView);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(20);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setBackgroundColor:[UIColor redColor]];
    [commitButton setTitle:@"去授权" forState:UIControlStateNormal];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 22;
    commitButton.clipsToBounds = YES;
    [contentView addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subTitleLabel.mas_bottom).offset(20);
        make.left.mas_offset(45);
        make.right.mas_offset(-45);
        make.height.mas_equalTo(44);
    }];
    [commitButton jk_addActionHandler:^(NSInteger tag) {
        if(self.authorPushClick){
            self.authorPushClick(nil);
        }
    }];
    
}

- (void)closeBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
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
