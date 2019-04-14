//
//  HJTakeCashVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJTakeCashVC.h"
#import "HJZFBbindingCell.h"
#import "HJUserInfoModel.h"
#import "HJSettingRequest.h"

@interface HJTakeCashVC ()

@end

@implementation HJTakeCashVC



- (void)viewDidLoad {

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];
    
    // Do any additional setup after loading the view.
    self.title = @"绑定支付宝";
    CGFloat topOffset = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    HJZFBbindingCell *zfbAccountCell = [[HJZFBbindingCell alloc] init];
    zfbAccountCell.titleLabel.text = @"提现支付宝";
    zfbAccountCell.contentField.enabled = NO;
    zfbAccountCell.contentField.text = self.cashInfo.zfb.account;
    [self.view addSubview:zfbAccountCell];
    [zfbAccountCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(topOffset);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    HJZFBbindingCell *nameCell = [[HJZFBbindingCell alloc] init];
    nameCell.titleLabel.text = @"真实姓名";
    nameCell.contentField.enabled = NO;
    nameCell.contentField.text = self.cashInfo.zfb.name;
    [self.view addSubview:nameCell];
    [nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(zfbAccountCell.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    HJZFBbindingCell *getcashCell = [[HJZFBbindingCell alloc] init];
    getcashCell.titleLabel.text = @"提现金额";
    getcashCell.contentField.placeholder = @"请输入提现金额";
    [self.view addSubview:getcashCell];
    [getcashCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameCell.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    HJZFBbindingCell *moneyCell = [[HJZFBbindingCell alloc] init];
    moneyCell.titleLabel.text = @"可提现金额";
    moneyCell.contentField.text = [NSString stringWithFormat:@"%.1f",self.cashInfo.money];
    moneyCell.contentField.enabled = NO;
    [self.view addSubview:moneyCell];
    [moneyCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(getcashCell.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    
    
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.text = [NSString stringWithFormat:@"最低提现金额为%ld元",self.cashInfo.lowest];
    tipLabel.textAlignment = NSTextAlignmentRight;
    tipLabel.font = [UIFont systemFontOfSize:10];
    tipLabel.textColor = [UIColor lightGrayColor];
    [self.view addSubview:tipLabel];
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(moneyCell);
        make.right.mas_offset(-16);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(100);
    }];

    
    
    UIButton *commitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [commitButton setBackgroundColor:[UIColor redColor]];
    [commitButton setTitle:@"立即提现" forState:UIControlStateNormal];
    commitButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [commitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    commitButton.layer.cornerRadius = 22;
    commitButton.clipsToBounds = YES;
    [self.view addSubview:commitButton];
    [commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(moneyCell.mas_bottom).offset(40);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(44);
        make.left.mas_offset(20);
    }];
    weakify(self)
    [commitButton jk_addActionHandler:^(NSInteger tag) {
        NSString *takeMoney = getcashCell.contentField.text;
        if([takeMoney integerValue] <= 0) {
            [weak_self.view makeToast:@"请输入提现金额" duration:1.0 position:CSToastPositionCenter];
            return;
        }
        if (takeMoney.length > 0) {
            [[HJSettingRequest shared] getApplyCashWithMoney:takeMoney Success:^(id responseObject) {
                [weak_self.view makeToast:@"提现成功" duration:1.0 position:CSToastPositionCenter];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [weak_self.navigationController popViewControllerAnimated:YES];
                });
            } fail:^(NSError *error) {
                [weak_self.view makeToast:@"提现失败" duration:1.0 position:CSToastPositionCenter];
            }];
        }
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
