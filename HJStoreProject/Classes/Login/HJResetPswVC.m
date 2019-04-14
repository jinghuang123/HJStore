//
//  HJResetPswVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJResetPswVC.h"
#import "HJLoginRegistRequest.h"

@interface HJResetPswVC ()<UITextFieldDelegate>
@property (nonatomic, strong) UITextField *mobileField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation HJResetPswVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat fieldH = 40;
    CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? 120 : 90;
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    NSString *mobile = [NSString stringWithFormat:@"%@****%@",[userInfo.mobile substringToIndex:3],[userInfo.mobile substringWithRange:NSMakeRange(7, 4)]];
    UITextField *mobileField = [UITextField createFieldWithPreIcon:@"ic_login_input_phone" placeHolder:@"" sizeH:fieldH delegate:self];
    _mobileField = mobileField;
    mobileField.text = mobile;
    mobileField.layer.cornerRadius = fieldH/2;
    mobileField.clipsToBounds = YES;
    mobileField.enabled = NO;
    mobileField.font = PFR13Font;
    mobileField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:mobileField];
    [mobileField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_offset(topOffSet);
        make.height.mas_equalTo(fieldH);
    }];
    
    UIButton *getCodeBtn = [[UIButton alloc] init];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    getCodeBtn.titleLabel.font = PFR14Font;
    [getCodeBtn addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCodeBtn];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.mas_equalTo(mobileField.mas_bottom).offset(5);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(30);
    }];
    
    UITextField *codeField = [UITextField createFieldWithPreIcon:@"ic_login_yzm" placeHolder:@"请输入验证码" sizeH:fieldH delegate:self];
    _codeField = codeField;
    codeField.layer.cornerRadius = fieldH/2;
    codeField.clipsToBounds = YES;
    codeField.font = PFR13Font;
    codeField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:codeField];
    [codeField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(getCodeBtn.mas_bottom).offset(25);
        make.height.mas_equalTo(fieldH);
    }];
    
    UITextField *pwdField = [UITextField createFieldWithPreIcon:@"ic_login_input_pwd" placeHolder:@"请输入6～32位新密码" sizeH:fieldH delegate:self];
    _pwdField = pwdField;
    pwdField.layer.cornerRadius = fieldH/2;
    pwdField.clipsToBounds = YES;
    pwdField.font = PFR13Font;
    pwdField.secureTextEntry = YES;
    pwdField.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    [self.view addSubview:pwdField];
    [pwdField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(codeField.mas_bottom).offset(25);
        make.height.mas_equalTo(fieldH);
    }];
    
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"完成"];
    _confirmButton = confirmBtn;
    confirmBtn.enabled = NO;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pwdField.mas_bottom).offset(40);
        make.left.mas_offset(20);
        make.height.mas_equalTo(44);
        make.right.mas_offset(-20);
    }];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_codeField.text.length > 0 && _pwdField.text.length >= 5 && _mobileField.text.length == 11) {
        self.confirmButton.enabled = YES;
    }else{
        self.confirmButton.enabled = NO;
    }
    return YES;
}

- (void)getCode {
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    [[HJLoginRegistRequest shared] getCodeWithMobile:userInfo.mobile event:@"resetpwd" success:^(id responseObject) {
    } fail:^(NSError *error, NSString *errorMsg) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = errorMsg;
        [hud hideAnimated:YES afterDelay:1.5];
    }];
}

- (void)confirmBtnClick {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HJLoginRegistRequest shared] reSetPasswordWithMobileNum:_mobileField.text psw:_pwdField.text Code:_codeField.text success:^(id responseObject) {
        [self.navigationController popViewControllerAnimated:YES];
        [self.hud hideAnimated:YES];
    } fail:^(NSError *error, NSString *errorMsg) {
        self.hud.label.text = errorMsg;
        [self.hud hideAnimated:YES afterDelay:1.5];
    }];
    
}



@end
