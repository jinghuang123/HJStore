//
//  HJZFBBindingVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJZFBBindingVC.h"
#import "HJUserInfoModel.h"
#import "HJZFBbindingCell.h"
#import "HJLoginRegistRequest.h"

@interface HJZFBBindingVC () 

@end


@implementation HJZFBBindingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];

    // Do any additional setup after loading the view.
    self.title = @"绑定支付宝";
    
    CGFloat topOffset = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    NSString *mobile = [NSString stringWithFormat:@"%@****%@",[userInfo.mobile substringToIndex:3],[userInfo.mobile substringWithRange:NSMakeRange(7, 4)]];
    HJZFBbindingCell *nameCell = [[HJZFBbindingCell alloc] init];
    nameCell.titleLabel.text = @"姓名";
    nameCell.contentField.placeholder = @"请输入支付宝认证的真实姓名";
    [self.view addSubview:nameCell];
    [nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(topOffset);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    HJZFBbindingCell *mobileCell = [[HJZFBbindingCell alloc] init];
    mobileCell.titleLabel.text = @"手机号码";
    mobileCell.contentField.enabled = NO;
    mobileCell.contentField.text = mobile;
    [self.view addSubview:mobileCell];
    [mobileCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameCell.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    HJZFBbindingCell *accountCell = [[HJZFBbindingCell alloc] init];
    accountCell.titleLabel.text = @"支付宝账号";
    accountCell.contentField.placeholder = @"请输入支付宝账号";
    [self.view addSubview:accountCell];
    [accountCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(mobileCell.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    HJZFBbindingCell *codeCell = [[HJZFBbindingCell alloc] init];
    codeCell.titleLabel.text = @"验证码";
    codeCell.contentField.placeholder = @"请输入验证码";
    [self.view addSubview:codeCell];
    [codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(accountCell.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    UIButton *getCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [getCodeButton setBackgroundColor:[UIColor redColor]];
    [getCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    getCodeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [getCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getCodeButton.layer.cornerRadius = 13;
    getCodeButton.clipsToBounds = YES;
    [self.view addSubview:getCodeButton];
    [getCodeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(codeCell);
        make.right.mas_offset(-16);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(100);
    }];
    [getCodeButton jk_addActionHandler:^(NSInteger tag) {
        [[HJLoginRegistRequest shared] getCodeWithMobile:userInfo.mobile event:@"bind" success:^(id responseObject) {
        } fail:^(NSError *error, NSString *errorMsg) {
        }];
    }];
    
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setBackgroundColor:[UIColor redColor]];
    [commitButton setTitle:@"立即绑定" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 22;
    commitButton.clipsToBounds = YES;
    [self.view addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(codeCell.mas_bottom).offset(40);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(44);
        make.left.mas_offset(20);
    }];
    weakify(self)
    [commitButton jk_addActionHandler:^(NSInteger tag) {
        NSString *name = nameCell.contentField.text;
        NSString *mobile = userInfo.mobile;
        NSString *account = accountCell.contentField.text;
        NSString *code = codeCell.contentField.text;
        name.length == 0 ? [weak_self.view makeToast:@"请输入姓名" duration:1.0 position:CSToastPositionCenter] : @"";
        account.length == 0 ? [weak_self.view makeToast:@"请输入账号" duration:1.0 position:CSToastPositionCenter] : @"";
        code.length == 0 ? [weak_self.view makeToast:@"请输入验证码" duration:1.0 position:CSToastPositionCenter] : @"";
        if (name.length > 0 && mobile.length > 0 && account.length > 0 && code.length > 0) {
            [[HJLoginRegistRequest shared] bondingZFBWithName:name account:account mobile:mobile captcha:code success:^(id obj) {
                [weak_self.navigationController popViewControllerAnimated:YES];
            } fail:^(NSError *error, NSString *errorMsg) {
            }];
        }
    }];

}

@end
