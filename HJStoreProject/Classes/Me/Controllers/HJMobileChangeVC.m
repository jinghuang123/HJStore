//
//  HJMobileChangeVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMobileChangeVC.h"
#import "HJLoginRegistRequest.h"

@interface HJMobileChangeVC ()
@property (nonatomic, strong) UITextField *mobileField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation HJMobileChangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat fieldH = 40;
    CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? 120 : 90;
    UITextField *mobileField = [UITextField createFieldWithPreIcon:@"ic_login_input_phone" placeHolder:@"请输入新的手机号码" sizeH:fieldH delegate:self];
    _mobileField = mobileField;
    mobileField.layer.cornerRadius = fieldH/2;
    mobileField.clipsToBounds = YES;
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
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"完成"];
    _confirmButton = confirmBtn;
    confirmBtn.enabled = NO;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(codeField.mas_bottom).offset(40);
        make.left.mas_offset(20);
        make.height.mas_equalTo(44);
        make.right.mas_offset(-20);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_codeField.text.length > 0 && _mobileField.text.length > 0) {
        self.confirmButton.enabled = YES;
    }else{
        self.confirmButton.enabled = NO;
    }
    return YES;
}

- (void)getCode {
    [[HJLoginRegistRequest shared] getCodeWithMobile:_mobileField.text event:@"changemobile" success:^(id responseObject) {
    } fail:^(NSError *error, NSString *errorMsg) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = errorMsg;
        [hud hideAnimated:YES afterDelay:1.5];
    }];
}

- (void)confirmBtnClick {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HJLoginRegistRequest shared] postNewMobileWithMobile:_mobileField.text code:_codeField.text success:^(id responseObject) {
        self.hud.label.text = @"修改成功";
        HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
        userInfo.mobile = self.mobileField.text;
        [userInfo saveUserInfo2Phone];
        [self.hud hideAnimated:YES afterDelay:1.0];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } fail:^(NSError *error,NSString *errorMsg) {
        self.hud.label.text = @"修改手机号码失败";
        [self.hud hideAnimated:YES afterDelay:1.5];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}

@end
