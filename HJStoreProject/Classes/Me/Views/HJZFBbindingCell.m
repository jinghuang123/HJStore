//
//  HJZFBbindingCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/13.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJZFBbindingCell.h"

@implementation HJZFBbindingCell

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    titleLabel.jk_edgeInsets = UIEdgeInsetsMake(10, 20, 10, 0);
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.offset(0);
        make.width.mas_equalTo(110);
    }];
    
    UITextField *contentField = [[UITextField alloc] init];
    _contentField = contentField;
    contentField.font = [UIFont systemFontOfSize:14];
    contentField.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    [self addSubview:contentField];
    [contentField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_right).offset(10);
        make.top.bottom.offset(0);
        make.right.mas_offset(-20);
    }];
}

@end
