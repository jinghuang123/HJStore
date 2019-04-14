//
//  HJRegistVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJRegistVC.h"
#import "HJLoginRegistRequest.h"
#import "YFPolicyWebVC.h"
#define UserAgrement @"https://app.meizhi1000.com/cms/p/%E7%BE%8E%E5%80%BC%E7%94%A8%E6%88%B7%E5%8D%8F%E8%AE%AE"

@interface HJRegistVC () <UITextFieldDelegate,TYAttributedLabelDelegate>
@property (nonatomic, strong) UITextField *mobileField;
@property (nonatomic, strong) UITextField *codeField;
@property (nonatomic, strong) UITextField *pwdField;
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation HJRegistVC

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat fieldH = 40;
    CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? 120 : 90;
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
    
    UITextField *pwdField = [UITextField createFieldWithPreIcon:@"ic_login_input_pwd" placeHolder:@"请输入6～32位密码" sizeH:fieldH delegate:self];
    _pwdField = pwdField;
    pwdField.layer.cornerRadius = fieldH/2;
    pwdField.clipsToBounds = YES;
    pwdField.secureTextEntry = YES;
    pwdField.font = PFR13Font;
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
    
    TYAttributedLabel *agrementTip = [[TYAttributedLabel alloc] init];
    agrementTip.text = @"注册代表您已同意《美值用户协议》";
    agrementTip.font = [UIFont systemFontOfSize:12];
    agrementTip.delegate = self;
    agrementTip.backgroundColor = [UIColor clearColor];
    agrementTip.textAlignment = kCTTextAlignmentCenter;
    agrementTip.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    [self.view addSubview:agrementTip];
    [agrementTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.top.equalTo(confirmBtn.mas_bottom).offset(20);
        make.height.mas_equalTo(20);
    }];
    
    NSMutableString *mutableStr = [NSMutableString stringWithString:agrementTip.text];
    NSRange range =  [mutableStr rangeOfString:@"《美值用户协议》"];
    [agrementTip addLinkWithLinkData:@{@"title":@"《美值用户协议》",@"url":UserAgrement} linkColor:[UIColor redColor] underLineStyle:kCTUnderlineStyleNone range:range];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_codeField.text.length >= 6 && _pwdField.text.length >= 5 && _mobileField.text.length == 11) {
        self.confirmButton.enabled = YES;
    }else{
        self.confirmButton.enabled = NO;
    }
    return YES;
}

- (void)getCode {
    [[HJLoginRegistRequest shared] getCodeWithMobile:_mobileField.text event:@"register" success:^(id responseObject) {
    } fail:^(NSError *error, NSString *errorMsg) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.label.text = errorMsg;
        [hud hideAnimated:YES afterDelay:1.5];
    }];
}

- (void)confirmBtnClick {
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[HJLoginRegistRequest shared] checkInviteCodeWithMobile:_mobileField.text event:@"register" code:_codeField.text success:^(id responseObject) {
        [self registeAction];
        [self.hud hideAnimated:YES];
    } fail:^(NSError *error, NSString *errorMsg) {
        self.hud.label.text = errorMsg;
        [self.hud hideAnimated:YES afterDelay:1.5];
    }];

}

- (void)registeAction {
    NSString *userName = _mobileField.text;
    [[HJLoginRegistRequest shared] registWithMobileNum:_mobileField.text psw:_pwdField.text Code:self.inviteCode openId:self.userModel.openid token:self.userModel.token userName:userName success:^(id responseObject) {
        [self.navigationController popToRootViewControllerAnimated:YES];
        [self.hud hideAnimated:YES];
    } fail:^(NSError *error, NSString *errorMsg) {
        self.hud.label.text = errorMsg;
        [self.hud hideAnimated:YES afterDelay:1.5];
    }];
}

- (void)attributedLabel:(TYAttributedLabel *)attributedLabel textStorageClicked:(id<TYTextStorageProtocol>)textStorage atPoint:(CGPoint)point {
    NSDictionary *data = ((TYLinkTextStorage *) textStorage).linkData;
    NSString *title = data[@"title"];
    NSString *url = data[@"url"];
    YFPolicyWebVC *web = [[YFPolicyWebVC alloc] init];
    web.policyUrl = url;
    [self.navigationController pushViewController:web animated:YES];
}
@end
