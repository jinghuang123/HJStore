//
//  HJFenceItemCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJFenceItemCell.h"
#import "HJSuperView.h"

@interface HJFenceItemCell()
@property (nonatomic, strong) UIView *contentBgView;
@property (nonatomic, strong) UIImageView *userIcon;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) UILabel *fenceCountLabel;
@property (nonatomic, strong) UILabel *phoneNumLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UIImageView *userTypeBgImageView;
@property (nonatomic, strong) UILabel *userTypeLabel;
@property (nonatomic, strong) UIImageView *userTypePreIcon;
@end

@implementation HJFenceItemCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeCell];
    }
    return self;
}

- (void)makeCell {
    
    UIView *contentBgView = [[UIView alloc] init];
    contentBgView.backgroundColor = [UIColor whiteColor];
    _contentBgView = contentBgView;
    [self.contentView addSubview:contentBgView];
    
    UIImageView *userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"head_imageDefalut"]];
    userIcon.layer.cornerRadius = 20;
    userIcon.clipsToBounds = YES;
    _userIcon = userIcon;
    [contentBgView addSubview:userIcon];
    
    UILabel *userNameLabel =  [[UILabel alloc] init];
    _userName = userNameLabel;
    userNameLabel.text = @"杨老板";
    userNameLabel.textColor = [UIColor jk_colorWithHexString:@"#1F3149"];
    userNameLabel.font = [UIFont systemFontOfSize:14];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    [contentBgView addSubview:userNameLabel];
    
    UILabel *fenceCountLabel = [[UILabel alloc] init];
    _fenceCountLabel = fenceCountLabel;
    fenceCountLabel.text = @"粉丝数12";
    fenceCountLabel.textColor = [UIColor jk_colorWithHexString:@"#1F3149"];
    fenceCountLabel.font = [UIFont systemFontOfSize:12];
    fenceCountLabel.textAlignment = NSTextAlignmentLeft;
    [contentBgView addSubview:fenceCountLabel];
    
    UILabel *phoneNumLabel = [[UILabel alloc] init];
    _phoneNumLabel = phoneNumLabel;
    phoneNumLabel.text = @"136****8888";
    phoneNumLabel.textColor = [UIColor jk_colorWithHexString:@"#1F3149"];
    phoneNumLabel.font = [UIFont systemFontOfSize:12];
    phoneNumLabel.textAlignment = NSTextAlignmentLeft;
    [contentBgView addSubview:phoneNumLabel];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    _dateLabel = dateLabel;
    dateLabel.text = @"2019-03-12";
    dateLabel.textColor = [UIColor jk_colorWithHexString:@"#1F3149"];
    dateLabel.font = [UIFont systemFontOfSize:12];
    dateLabel.textAlignment = NSTextAlignmentLeft;
    [contentBgView addSubview:dateLabel];
    
    UIImageView *userTypeBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_level_bg"]];
    _userTypeBgImageView = userTypeBgImageView;
    [contentBgView addSubview:userTypeBgImageView];

    
    UIImageView *userTypePreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"huiyuan"]];
    _userTypePreIcon = userTypePreIcon;
    [userTypeBgImageView addSubview:userTypePreIcon];

    
    UILabel *userTypeLabel =  [[UILabel alloc] init];
    _userTypeLabel = userTypeLabel;
    userTypeLabel.text = @"钻石会员";
    userTypeLabel.textColor = [UIColor jk_colorWithHexString:@"#FFE15D"];
    userTypeLabel.font = [UIFont systemFontOfSize:10];
    userTypeLabel.textAlignment = NSTextAlignmentLeft;
    [userTypeBgImageView addSubview:userTypeLabel];

    
    
    [self makeViewConstranints];
    
}

- (void)makeViewConstranints {
    weakify(self)
    
    [_contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(2);
    }];
    
    [_userIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.width.height.mas_equalTo(40);
        make.top.mas_offset(8);
        make.bottom.mas_offset(-8);
    }];
    
    [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.userIcon.mas_right).offset(16);
        make.width.mas_greaterThanOrEqualTo(40);
        make.height.mas_equalTo(15);
        make.top.mas_offset(8);
    }];
    
    [_fenceCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.width.mas_greaterThanOrEqualTo(40);
        make.height.mas_equalTo(15);
        make.centerY.mas_equalTo(weak_self.userName.mas_centerY).offset(0);
    }];
    
    [_phoneNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.userIcon.mas_right).offset(16);
        make.width.mas_greaterThanOrEqualTo(150);
        make.height.mas_equalTo(15);
        make.bottom.mas_offset(-8);
    }];
    
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.width.mas_greaterThanOrEqualTo(80);
        make.height.mas_equalTo(15);
        make.bottom.mas_offset(-8);
    }];
    

    
    [_userTypeBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.userName.mas_right).offset(5);
        make.width.mas_equalTo(66);
        make.top.mas_offset(8);
        make.height.mas_equalTo(16);
    }];
    [_userTypePreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(3);
        make.width.mas_equalTo(12);
        make.top.mas_equalTo(3);
        make.height.mas_equalTo(10);
    }];

    [_userTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.userTypePreIcon.mas_right).offset(3);
        make.width.mas_equalTo(50);
        make.top.mas_offset(0);
        make.height.mas_equalTo(16);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
