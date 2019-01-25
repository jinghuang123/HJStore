//
//  HJUserInfoFootView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/24.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserInfoFootView.h"

@implementation HJUserInfoFootView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI {
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UIButton *commitBtn = [UIButton createThemeButton:@"保存"];
    _commitBtn = commitBtn;
    commitBtn.hidden = YES;
    [self.contentView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(44);
    }];
    [commitBtn addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commitBtnClick {
    if (self.commitBlock) {
        self.commitBlock(nil);
    }
}

@end
