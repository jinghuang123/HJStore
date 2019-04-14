//
//  HJInviteCodeInputVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJInviteCodeInputVC.h"
#import "HJRegistVC.h"
#import "HJLoginRegistRequest.h"

@interface HJInviteCodeInputVC () <UITextFieldDelegate>
@property (nonatomic, strong) UIButton *confirmBtn;
@property (nonatomic, strong) UITextField *field;
@property (nonatomic, strong) UIView *inviteView;
@property (nonatomic, assign) CGFloat inviteViewSize;
@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) UIImageView *avatarImageView;
@property (nonatomic, strong) UILabel *nickName;
@end

@implementation HJInviteCodeInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请码";
    
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(20, 150, MaxWidth - 40, 20)];
    _field = field;

    field.font = PFR16Font
    field.delegate = self;
    field.placeholder = @"请输入邀请码";
    [self.view addSubview:field];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(20, 170, MaxWidth - 40, 1)];
    line.backgroundColor = [UIColor jk_colorWithHexString:@"#D8D8D8"];
    [self.view addSubview:line];
    
    UIView *inviteView = [[UIView alloc] init];
    _inviteView = inviteView;
    inviteView.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    inviteView.layer.borderWidth = 0.5;
    inviteView.layer.cornerRadius = 3;
    inviteView.clipsToBounds = YES;
    [self.view addSubview:inviteView];
    weakify(self)
    self.inviteViewSize = 0;
    [inviteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.mas_equalTo(field.mas_bottom).offset(50);
        make.height.mas_equalTo(weak_self.inviteViewSize);
    }];
    
    UIImageView *avatarImageView = [[UIImageView alloc] init];
    _avatarImageView = avatarImageView;
    avatarImageView.layer.cornerRadius  = 25;
    avatarImageView.clipsToBounds = YES;
    [inviteView addSubview:avatarImageView];
    [avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.bottom.mas_offset(-10);
        make.width.height.mas_equalTo(50);
    }];
    
    UILabel *nickName = [[UILabel alloc] init];
    _nickName = nickName;
    nickName.font = [UIFont systemFontOfSize:15];
    nickName.textColor = [UIColor blackColor];
    [inviteView addSubview:nickName];
    [nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatarImageView.mas_right).offset(10);
        make.right.mas_offset(-20);
        make.top.mas_offset(15);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *inviteTip = [[UILabel alloc] init];
    inviteTip.font = [UIFont systemFontOfSize:14];
    inviteTip.text = @"邀请您加入美值";
    inviteTip.textColor = [[UIColor jk_colorWithHexString:@"0x333333"] colorWithAlphaComponent:0.5];
    [inviteView addSubview:inviteTip];
    [inviteTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatarImageView.mas_right).offset(10);
        make.right.mas_offset(-20);
        make.top.equalTo(nickName.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"确认"];
    _confirmBtn = confirmBtn;
    confirmBtn.enabled = NO;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(inviteView.mas_bottom).offset(40);
        make.left.mas_offset(20);
        make.height.mas_equalTo(44);
        make.right.mas_offset(-20);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string isEqualToString:@" "]) {
        return NO;
    }
    if (textField.text.length >= 11 && ![string isEqualToString:@""]) {
        return NO;
    }
    if([string isEqualToString:@""]) {
        if (textField.text.length == 7) {
            [self check];
        }else if (textField.text.length == 8) {
            [self check];
        }else{
            self.confirmBtn.enabled = NO;
            self.inviteViewSize = 0;
            [self updateInviteView:nil];
        }
    }else{
        if (textField.text.length == 5) {
            [self check];
        }else if (textField.text.length == 6) {
            [self check];
        }else if (textField.text.length == 10) {
            [self check];
        }else{
            self.confirmBtn.enabled = NO;
            self.inviteViewSize = 0;
            [self updateInviteView:nil];
        }
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    NSLog(@"textFieldDidEndEditing");

}

- (void)check {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.field resignFirstResponder];
        [[HJLoginRegistRequest shared] checkMobileOrCode:self.field.text success:^(NSDictionary *invitationInfo) {
            self.inviteCode = self.field.text;
            self.confirmBtn.enabled = YES;
            self.inviteViewSize = 70;
            [self updateInviteView:invitationInfo];
            [hud hideAnimated:YES];
        } fail:^(NSError *error,NSString *msg) {
            self.confirmBtn.enabled = NO;
            self.inviteViewSize = 0;
            [hud hideAnimated:YES];
            [self updateInviteView:nil];
        }];
    });
}

- (void)updateInviteView:(NSDictionary *)invitationInfo {
    NSString *avatar = invitationInfo ? [invitationInfo objectForKey:@"avatar"] : @"";
    NSString *nickname = invitationInfo ? [invitationInfo objectForKey:@"nickname"] : @"";
    [_avatarImageView sd_setImageWithURLString:avatar placeholderImage:PLACEHOLDER_Category];
    _nickName.text = nickname;
    [self.inviteView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.inviteViewSize);
    }];
}

- (void)confirmBtnClick {
    HJRegistVC *registVC = [[HJRegistVC alloc] init];
    registVC.title = @"注册";
    registVC.inviteCode = self.inviteCode;
    registVC.userModel = self.userModel;
    [self.navigationController pushViewController:registVC animated:YES];
}



@end
