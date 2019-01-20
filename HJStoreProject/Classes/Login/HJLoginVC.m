//
//  HJLoginVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJLoginVC.h"
#import "HJMobileLoginVC.h"
#import "HJInviteCodeInputVC.h"
#import "HJUserInfoModel.h"

@interface HJLoginVC ()
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation HJLoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if (userInfo.token) {
        [self closeBtnClick];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeButton = [[UIButton alloc] init];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"ic_login_close"] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(64);
        make.right.mas_offset(-25);
        make.width.height.mas_equalTo(20);
    }];
    // Do any additional setup after loading the view.
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    UIImage *icon = [UIImage imageNamed:@"ic_login_top"];
    iconImageView.image = icon;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(0);
        make.top.mas_offset(40);
        make.width.mas_equalTo(300);
        make.height.mas_equalTo(300 * icon.size.height/icon.size.width);
    }];
    
    UIButton *regisButton = [UIButton createThemeButton:@"注册"];
    [self.view addSubview:regisButton];
    [regisButton addTarget:self action:@selector(regisButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [regisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(10);
        make.width.equalTo(@(MaxWidth - 40));
        make.height.equalTo(@(44));
    }];
    
    UIButton *mobileLogin = [self creatViewWithIcon:@"ic_login_phone" title:@"手机登录" width:(MaxWidth - 80)/2];
    [self.view addSubview:mobileLogin];
    [mobileLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.top.mas_equalTo(regisButton.mas_bottom).offset(30);
        make.width.mas_equalTo((MaxWidth - 80)/2);
        make.height.equalTo(@(40));
    }];
    [mobileLogin addTarget:self action:@selector(phoneLoginClick) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *wechatLogin = [self creatViewWithIcon:@"ic_login_wechat" title:@"微信登录" width:(MaxWidth - 80)/2];
    [self.view addSubview:wechatLogin];
    [wechatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.mas_equalTo(regisButton.mas_bottom).offset(30);
        make.width.mas_equalTo((MaxWidth - 80)/2);
        make.height.equalTo(@(40));
    }];
    [wechatLogin addTarget:self action:@selector(wechatLoginClick) forControlEvents:UIControlEventTouchUpInside];
}


- (UIButton *)creatViewWithIcon:(NSString *)icon title:(NSString *)title width:(CGFloat)wid{
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wid, 40)];
    view.layer.cornerRadius = 22;
    view.clipsToBounds = YES;
    [view jk_setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.2] forState:UIControlStateNormal];
    [view jk_setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.7] forState:UIControlStateSelected];
    UIImageView *preIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
    preIcon.image = [UIImage imageNamed:icon];
    [view addSubview:preIcon];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, wid - 60, 20)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = PFR14Font;
    titleLabel.text = title;
    titleLabel.textColor = [UIColor lightGrayColor];
    [view addSubview:titleLabel];
    
    
    return view;
}


- (void)regisButtonClick {
    HJInviteCodeInputVC *codeVC = [[HJInviteCodeInputVC alloc] init];
    [codeVC setNavBackItem];
    [self.navigationController pushViewController:codeVC animated:YES];
}

- (void)wechatLoginClick {
    
}

- (void)phoneLoginClick {
    HJMobileLoginVC *mobileLoginVC = [[HJMobileLoginVC alloc] init];
    [mobileLoginVC setNavBackItem];
    [self.navigationController pushViewController:mobileLoginVC animated:YES];
}

- (void)closeBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
    



@end
