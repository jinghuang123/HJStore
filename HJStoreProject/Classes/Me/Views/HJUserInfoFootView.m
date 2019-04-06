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
    self.contentView.backgroundColor = [UIColor jk_colorWithHexString:@"#fafafa"];;
    
    UIButton *quiteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [quiteButton setTitle:@"退出登录" forState:UIControlStateNormal];
    quiteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [quiteButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [quiteButton jk_setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _quiteButton = quiteButton;
    quiteButton.hidden = YES;
    [self.contentView addSubview:quiteButton];
    [quiteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.left.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    [quiteButton addTarget:self action:@selector(commitBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)commitBtnClick {
    if (self.commitBlock) {
        self.commitBlock(nil);
    }
}

@end
