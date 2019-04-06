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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CGFloat yoffSet = MaxHeight >= ENM_SCREEN_H_X ? 110 : 90;
    HJTextField *field = [[HJTextField alloc] initWithFrame:CGRectMake(0, yoffSet, MaxWidth, 44)];
    field.edgeInsets = UIEdgeInsetsMake(5, 10, 5, 0);
    field.backgroundColor = [UIColor whiteColor];
    field.textColor = [UIColor jk_colorWithHexString:@"#262f42"];
    field.font = [UIFont systemFontOfSize:15];
    field.delegate = self;
    [self.view addSubview:field];
    
    UIButton *confirmBtn = [UIButton createThemeButton:@"确定"];
    _confirmButton = confirmBtn;
    confirmBtn.enabled = NO;
    [self.view addSubview:confirmBtn];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(field.mas_bottom).offset(55);
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
    
}

@end
