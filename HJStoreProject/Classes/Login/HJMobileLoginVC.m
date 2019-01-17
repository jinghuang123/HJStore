//
//  HJMobileLoginVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMobileLoginVC.h"
#import "HJMobileCodeLoginVC.h"

@interface HJMobileLoginVC () <UITextFieldDelegate>
@property (nonatomic, strong) UITextField *mobileField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *confirmBtn;
@end

@implementation HJMobileLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat fieldH = 40;
    UITextField *mobileField = [UITextField createFieldWithPreIcon:@"ic_login_input_phone" placeHolder:@"请输入手机号码" sizeH:fieldH delegate:self];
    _mobileField = mobileField;
    mobileField.layer.cornerRadius = fieldH/2;
    mobileField.clipsToBounds = YES;
    mobileField.font = PFR13Font;
    mobileField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:mobileField];
    [mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_offset(180);
        make.height.mas_equalTo(fieldH);
    }];
    
    UITextField *pwdField = [UITextField createFieldWithPreIcon:@"ic_login_input_pwd" placeHolder:@"请输入登录密码" sizeH:fieldH delegate:self];
    _pwdField = pwdField;
    pwdField.layer.cornerRadius = fieldH/2;
    pwdField.clipsToBounds = YES;
    pwdField.font = PFR13Font;
    pwdField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:pwdField];
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(mobileField.mas_bottom).offset(40);
        make.height.mas_equalTo(fieldH);
    }];
    
    UIButton *forgetBtn = [[UIButton alloc] init];
    [forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [forgetBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    forgetBtn.titleLabel.font = PFR12Font;
    [forgetBtn addTarget:self action:@selector(forgetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(pwdField.mas_left).offset(0);
        make.top.mas_equalTo(pwdField.mas_bottom).offset(45);
        make.width.mas_equalTo(65);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *codeLoginBtn = [[UIButton alloc] init];
    [codeLoginBtn setTitle:@"短信验证码登录" forState:UIControlStateNormal];
    [codeLoginBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [codeLoginBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    codeLoginBtn.titleLabel.font = PFR12Font;
    [codeLoginBtn addTarget:self action:@selector(codeLoginBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:codeLoginBtn];
    [codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(pwdField.mas_right).offset(0);
        make.top.mas_equalTo(pwdField.mas_bottom).offset(45);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"登录"];
    _confirmBtn = confirmBtn;
    confirmBtn.enabled = NO;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeLoginBtn.mas_bottom).offset(55);
        make.left.mas_offset(20);
        make.height.mas_equalTo(44);
        make.right.mas_offset(-20);
    }];
    
}

- (void)forgetBtnClick {
    
}

- (void)codeLoginBtnClick {
    HJMobileCodeLoginVC *codeLogin = [[HJMobileCodeLoginVC alloc] init];
    [self.navigationController pushViewController:codeLogin animated:YES];
}

- (void)confirmBtnClick {
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_pwdField.text.length >= 5 && _mobileField.text.length == 11) {
        self.confirmBtn.enabled = YES;
    }else{
        self.confirmBtn.enabled = NO;
    }
    return YES;
}

@end