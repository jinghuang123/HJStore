//
//  HJUserNameSetVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserNameSetVC.h"

@interface HJUserNameSetVC () <UITextFieldDelegate>
@property (nonatomic, strong)  UITextField *field;
@property (nonatomic, strong)  UIButton *confirmButton;
@end

@implementation HJUserNameSetVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGFloat yoffSet = MaxHeight >= ENM_SCREEN_H_X ? 90 : 70;
    HJTextField *field = [[HJTextField alloc] initWithFrame:CGRectMake(0, yoffSet, MaxWidth, 44)];
    _field = field;
    field.edgeInsets = UIEdgeInsetsMake(5, 20, 5, 0);
    field.backgroundColor = [UIColor whiteColor];
    field.text = self.name;
    field.textColor = [UIColor jk_colorWithHexString:@"#262f42"];
    field.font = [UIFont systemFontOfSize:14];
    field.delegate = self;
    [self.view addSubview:field];
    
//    UILabel *tip = [[UILabel alloc] init];
//    tip.text = @"*昵称修改成功后三天内不能再修改";
//    tip.textColor = [UIColor redColor];
//    tip.font = [UIFont systemFontOfSize:12];
//    [self.view addSubview:tip];
//    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(20);
//        make.top.mas_equalTo(field.mas_bottom).offset(10);
//        make.height.mas_equalTo(15);
//        make.width.mas_equalTo(200);
//    }];
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"确定"];
    _confirmButton = confirmBtn;
    confirmBtn.enabled = YES;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(field.mas_bottom).offset(40);
        make.left.mas_offset(20);
        make.height.mas_equalTo(44);
        make.right.mas_offset(-20);
    }];
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (_field.text.length > 0) {
        self.confirmButton.enabled = YES;
    }else{
        self.confirmButton.enabled = NO;
    }
    return YES;
}

- (void)confirmBtnClick {
    if (self.userNameSetBlock) {
        self.userNameSetBlock(_field.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
