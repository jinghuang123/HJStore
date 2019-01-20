//
//  HJMobileCodeLoginVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/15.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMobileCodeLoginVC.h"

@interface HJMobileCodeLoginVC ()
@property (nonatomic, strong) UITextField *mobileField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation HJMobileCodeLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
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

    
    UIButton *getCodeBtn = [[UIButton alloc] init];
    [getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [getCodeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    getCodeBtn.titleLabel.font = PFR12Font;
    [getCodeBtn addTarget:self action:@selector(getCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:getCodeBtn];
    [getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(pwdField.mas_right).offset(0);
        make.top.mas_equalTo(pwdField.mas_bottom).offset(10);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"登录"];
    _confirmBtn = confirmBtn;
    confirmBtn.enabled = NO;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pwdField.mas_bottom).offset(45);
        make.left.mas_offset(20);
        make.height.mas_equalTo(44);
        make.right.mas_offset(-20);
    }];
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

- (void)getCodeBtnClick {

    [[HJLoginRegistRequest shared] getCodeWithMobile:_mobileField.text event:@"mobilelogin" success:^(id responseObject) {
    } fail:^(NSError *error, NSString *errorMsg) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = errorMsg;
        [hud hideAnimated:YES afterDelay:1.5];
    }];
}

- (void)confirmBtnClick{
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HJLoginRegistRequest shared] loginWithSMS:_mobileField.text code:_pwdField.text success:^(id responseObject) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.hud hideAnimated:YES];
    } fail:^(NSError *error, NSString *errorMsg) {
        self.hud.label.text = errorMsg;
        [self.hud hideAnimated:YES afterDelay:1.5];
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
