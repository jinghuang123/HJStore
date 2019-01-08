//
//  HJLoginVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJLoginVC.h"

@interface HJLoginVC ()

@end

@implementation HJLoginVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
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
    
    UIButton *regisButton = [UIButton createThemeButton:@"注册"];
    [self.view addSubview:regisButton];
    [regisButton addTarget:self action:@selector(regisButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [regisButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_offset(320);
        make.width.equalTo(@(MaxWidth - 40));
        make.height.equalTo(@(44));
    }];
    
    UIButton *wechatLoginButton = [UIButton createThemeButton:@"微信登录"];
    [self.view addSubview:wechatLoginButton];
    [wechatLoginButton addTarget:self action:@selector(wechatLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [wechatLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(regisButton.mas_bottom).offset(10);
        make.width.equalTo(@(MaxWidth - 40));
        make.height.equalTo(@(44));
    }];
    
    UIButton *phoneLoginButton = [UIButton createThemeButton:@"手机登录"];
    [self.view addSubview:phoneLoginButton];
    [phoneLoginButton addTarget:self action:@selector(phoneLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [phoneLoginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(wechatLoginButton.mas_bottom).offset(10);
        make.width.equalTo(@(MaxWidth - 40));
        make.height.equalTo(@(44));
    }];
}



- (void)regisButtonClick {
    
}

- (void)wechatLoginClick {
    
}

- (void)phoneLoginClick {
    
}

- (void)closeBtnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}
    



@end
