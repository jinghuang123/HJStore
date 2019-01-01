//
//  HJMainTopToolView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/3.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainTopToolView.h"

@interface HJMainTopToolView()
/* 左边Item */
@property (strong , nonatomic)UIButton *leftItemButton;
/* 右边Item */
@property (strong , nonatomic)UIButton *rightItemButton;

/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;

@end

@implementation HJMainTopToolView


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI {
    self.backgroundColor = [UIColor jk_colorWithHexString:@"#ff5809"];

    UIButton *leftItemButton = [[UIButton alloc] init];
    _leftItemButton = leftItemButton;
    [leftItemButton setImage:[UIImage imageNamed:@"shouye_icon_scan_white"] forState:UIControlStateNormal];
    [leftItemButton addTarget:self action:@selector(leftButtonItemClick) forControlEvents:UIControlEventTouchUpInside];


    UIButton *rightItemButton = [[UIButton alloc] init];
    _rightItemButton = rightItemButton;
    [rightItemButton setImage:[UIImage imageNamed:@"shouye_icon_sort_white"] forState:UIControlStateNormal];
    [rightItemButton addTarget:self action:@selector(rightButtonItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_rightItemButton];
    [self addSubview:_leftItemButton];
    
//    CAGradientLayer * layer = [[CAGradientLayer alloc] init];
//    layer.frame = self.bounds;
//    layer.colors = @[(id)[UIColor colorWithWhite:0 alpha:0.2].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.15].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.1].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.05].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.03].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.01].CGColor,(id)[UIColor colorWithWhite:0 alpha:0.0].CGColor];
//    [self.layer addSublayer:layer];
    
    _topSearchView = [[UIView alloc] init];
    _topSearchView.backgroundColor = [UIColor whiteColor];
    _topSearchView.layer.cornerRadius = 16;
    [_topSearchView.layer masksToBounds];
    [self addSubview:_topSearchView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    weakify(self)
    [_leftItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(20);
        make.left.equalTo(self.mas_left).offset(0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [_rightItemButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weak_self.leftItemButton.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-0);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        [make.left.mas_equalTo(weak_self.leftItemButton.mas_right)setOffset:5];
        [make.right.mas_equalTo(weak_self.rightItemButton.mas_left)setOffset:5];
        make.height.mas_equalTo(@(32));
        make.centerY.mas_equalTo(weak_self.rightItemButton);
    }];
}

- (void)leftButtonItemClick {
    if (self.leftItemClickBlock) {
        self.leftItemClickBlock();
    }
}

- (void)rightButtonItemClick {
    if (self.rightItemClickBlock) {
        self.rightItemClickBlock();
    }
}
@end
