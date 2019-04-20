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
#import "HJShareInstance.h"
#import "HJLoginRegistRequest.h"

@interface HJLoginVC ()
@property (nonatomic, strong) UIImageView *iconImageView;
@end

@implementation HJLoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if (userInfo.token && userInfo.token.length > 0) {
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
    _closeButton = closeButton;
    closeButton.hidden = self.closeHide;
    [closeButton setBackgroundImage:[UIImage imageNamed:@"ic_login_close"] forState:UIControlStateNormal];
    [self.view addSubview:closeButton];
    [closeButton addTarget:self action:@selector(closeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.right.mas_offset(-25);
        make.width.height.mas_equalTo(24);
    }];
    // Do any additional setup after loading the view.
    
    UIImageView *iconImageView = [[UIImageView alloc] init];
    UIImage *icon = [UIImage imageNamed:@"ic_login_top"];
    iconImageView.image = icon;
    [self.view addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(0);
        make.top.mas_offset(120);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(120);
    }];
    
    UIImageView *tipImageView = [[UIImageView alloc] init];
    UIImage *tipIcon = [UIImage imageNamed:@"ic_login_tip"];
    tipImageView.image = tipIcon;
    [self.view addSubview:tipImageView];
    [tipImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX).offset(0);
        make.top.mas_equalTo(iconImageView.mas_bottom).offset(40);
        make.width.mas_equalTo(192);
        make.height.mas_equalTo(46);
    }];
    
    UIButton *regisButton = [UIButton createThemeButtonRegist:@"注册"];
    [self.view addSubview:regisButton];
    [regisButton addTarget:self action:@selector(regisButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [regisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(tipImageView.mas_bottom).offset(71);
        make.width.equalTo(@(192));
        make.height.equalTo(@(32));
    }];
    
    UIButton *mobileLogin = [self creatViewWithIcon:@"ic_login_phone" title:@"手机登录" width:192];
    [self.view addSubview:mobileLogin];
    [mobileLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(regisButton.mas_bottom).offset(30);
        make.width.mas_equalTo(192);
        make.height.equalTo(@(32));
    }];
    [mobileLogin addTarget:self action:@selector(phoneLoginClick) forControlEvents:UIControlEventTouchUpInside];

    
    UIButton *wechatLogin = [self creatViewWithIcon:@"ic_login_wechat" title:@"微信登录" width:192];
    [self.view addSubview:wechatLogin];
    [wechatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(mobileLogin.mas_bottom).offset(16);
        make.width.mas_equalTo(192);
        make.height.equalTo(@(32));
    }];
    [wechatLogin addTarget:self action:@selector(wechatLoginClick) forControlEvents:UIControlEventTouchUpInside];
}


- (UIButton *)creatViewWithIcon:(NSString *)icon title:(NSString *)title width:(CGFloat)wid{
    UIButton *view = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, wid, 32)];
    [view setBackgroundImage:[UIImage imageNamed:@"mobile_login_icon"] forState:UIControlStateNormal];
    UIImageView *preIcon = [[UIImageView alloc] initWithFrame:CGRectMake(42, 5, 22, 22)];
    preIcon.image = [UIImage imageNamed:icon];
    [view addSubview:preIcon];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 5, wid - 95, 22)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = PFR14Font;
    titleLabel.text = title;
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    [view addSubview:titleLabel];
    return view;
}


- (void)regisButtonClick {
    HJInviteCodeInputVC *codeVC = [[HJInviteCodeInputVC alloc] init];
    [self.navigationController pushViewController:codeVC animated:YES];
}

- (void)regisByWechatUserInfo:(HJWechatUserModel *)userInfo {
    HJInviteCodeInputVC *codeVC = [[HJInviteCodeInputVC alloc] init];
    codeVC.userModel = userInfo;
    [self.navigationController pushViewController:codeVC animated:YES];
}

- (void)wechatLoginClick {
    weakify(self)
    [[HJShareInstance shareInstance] getUserInfoForWechatSuccess:^(HJWechatUserModel *userInfo) {
        [self.view makeToast:@"微信授权成功" duration:2.0 position:CSToastPositionCenter];
        [[HJLoginRegistRequest shared] loginWithWechatInfo:userInfo.openid success:^(id responseObject) {
            [self.view makeToast:@"微信登录成功" duration:2.0 position:CSToastPositionCenter];
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSError *error, NSString *errorMsg) {
            [weak_self regisByWechatUserInfo:userInfo];
        }];
    }];
}

- (void)phoneLoginClick {
    HJMobileLoginVC *mobileLoginVC = [[HJMobileLoginVC alloc] init];
    [self.navigationController pushViewController:mobileLoginVC animated:YES];
}

- (void)closeBtnClick {
    if (self.closeBlock) {
        self.closeBlock(nil);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self.navigationController popViewControllerAnimated:YES];

    }
}
    



@end
