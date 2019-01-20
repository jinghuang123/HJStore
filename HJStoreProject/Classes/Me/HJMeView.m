//
//  HJMeView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMeView.h"

@interface HJMeView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *earningView;
@property (nonatomic, strong) UIView *icomView;
@end

@implementation HJMeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.scroView = [[UIScrollView alloc] init];
    self.scroView.contentSize = CGSizeMake(0, MaxHeight);
    self.scroView.delegate = self;
    self.scroView.pagingEnabled = YES;
    self.scroView.scrollEnabled = NO;
    self.scroView.bounces = NO;
    self.scroView.showsVerticalScrollIndicator = NO;
    self.scroView.showsHorizontalScrollIndicator = NO;
    self.scroView.alwaysBounceHorizontal = YES;
    self.scroView.alwaysBounceVertical = YES;
    [self addSubview:self.scroView];
    [self.scroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    [self addScroViewContent];
}

- (void)addScroViewContent {
    [self addScroViewTop];
}

- (void)addScroViewTop {
    CGFloat topViewH = MaxHeight > 600 ? 220 : 180;
    NSLog(@">>>>>>%f",MaxHeight);
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight)];
    headView.backgroundColor = [UIColor jk_colorWithHexString:@"#f5f5f5"];
    [self.scroView addSubview:headView];
    
    UIView *topColorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, topViewH * 0.8)];
    topColorView.backgroundColor = [UIColor jk_colorWithHexString:@"#008B8B"];
    [headView addSubview:topColorView];
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn setBackgroundImage:[UIImage imageNamed:@"me_icon_setting"] forState:UIControlStateNormal];
    [headView addSubview:settingBtn];
    [settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(30);
        make.width.height.mas_equalTo(20);
    }];
    [settingBtn addTarget:self action:@selector(settingBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *bottomCornerView = [[UIView alloc] initWithFrame:CGRectMake(0, topViewH/2, MaxWidth, MaxHeight)];
    bottomCornerView.backgroundColor = [UIColor jk_colorWithHexString:@"#f5f5f5"];
    UIBezierPath *maskPath  = [[UIBezierPath alloc] init];
    [maskPath addArcWithCenter:CGPointMake(MaxWidth/2, MaxHeight/2)
                    radius:MaxHeight/2
                startAngle:M_PI*1.0
                  endAngle:M_PI*2.0
                 clockwise:YES];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = bottomCornerView.bounds;
    maskLayer.path = maskPath.CGPath;
    bottomCornerView.layer.mask = maskLayer;
    [headView addSubview:bottomCornerView];
    [bottomCornerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset(topViewH/2);
    }];
    
    CGFloat headSize = 60;
    UIImageView *headImageView = [[UIImageView alloc] init];
    _headImageView = headImageView;
    headImageView.image = [UIImage imageNamed:@"default_avatar"];
    headImageView.layer.borderColor = [UIColor jk_colorWithHexString:@"#f5f5f5"].CGColor;
    headImageView.layer.borderWidth = 3.0;
    headImageView.layer.cornerRadius = headSize/2;
    headImageView.clipsToBounds = YES;
    [headView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView.mas_centerX).offset(0);
        make.top.mas_offset(topViewH/2 - headSize/2);
        make.width.height.mas_equalTo(headSize);
    }];
    
    
    UILabel *nameLabel = [[UILabel alloc] init];
    _nameLabel = nameLabel;
    nameLabel.text = @"杨老板是大傻B";
    nameLabel.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    nameLabel.font = [UIFont systemFontOfSize:11];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(headImageView.mas_centerX).offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    _codeLabel = codeLabel;
    codeLabel.text = @"邀请码:x5s7DdgyZ";
    codeLabel.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    codeLabel.font = [UIFont systemFontOfSize:11];
    codeLabel.textAlignment = NSTextAlignmentCenter;
    [headView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
        make.centerX.mas_equalTo(nameLabel.mas_centerX).offset(0);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    UIView *hline = [[UIView alloc] init];
    hline.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [headView addSubview:hline];
    [hline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(codeLabel.mas_bottom).offset(10);
    }];
    
    UIView *earningView = [[UIView alloc] init];
    _earningView = earningView;
    earningView.backgroundColor = [UIColor whiteColor];
    earningView.layer.cornerRadius = 5;
    earningView.clipsToBounds = YES;
    [headView addSubview:earningView];
    [earningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(hline.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(120);
    }];
    [self addEarningViewItems];
    
    UIView *hline2 = [[UIView alloc] init];
    hline2.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [headView addSubview:hline2];
    [hline2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(earningView.mas_bottom).offset(10);
    }];
    
    UIView *icomView = [[UIView alloc] init];
    _icomView = icomView;
    icomView.backgroundColor = [UIColor whiteColor];
    icomView.layer.cornerRadius = 5;
    icomView.clipsToBounds = YES;
    [headView addSubview:icomView];
    [icomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.top.mas_equalTo(hline2.mas_bottom).mas_offset(15);
        make.height.mas_equalTo(80);
    }];
    [self addItomViewItems];
}

- (void)addEarningViewItems {
    UILabel *remainMoneyLabel = [[UILabel alloc] init];
    remainMoneyLabel.text = @"余额 ¥ 20";
    remainMoneyLabel.textColor = [UIColor jk_colorWithHexString:@"#262f42"];
    remainMoneyLabel.font = [UIFont boldSystemFontOfSize:13];
    remainMoneyLabel.textAlignment = NSTextAlignmentLeft;
    [_earningView addSubview:remainMoneyLabel];
    
    [remainMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor jk_colorWithHexString:@"#262f42"] forState:UIControlStateNormal];
    applyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    applyBtn.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
    applyBtn.layer.borderWidth = 1.0;
    applyBtn.layer.cornerRadius = 2;
    applyBtn.clipsToBounds = YES;
    [_earningView addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(50);
        make.top.mas_offset(12);
    }];
    
    UIView *hline = [[UIView alloc] init];
    hline.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [_earningView addSubview:hline];
    [hline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(remainMoneyLabel.mas_bottom).offset(5);
    }];
    
 
    
    UIView *vline = [[UIView alloc] init];
    vline.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.4];
    [_earningView addSubview:vline];
    [vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(hline.mas_centerX).offset(0);
        make.width.mas_equalTo(0.5);
        make.top.mas_equalTo(hline.mas_bottom).offset(20);
        make.bottom.mas_offset(-20);
    }];
    
    UILabel *monthEarnLabel = [[UILabel alloc] init];
    monthEarnLabel.text = @"¥ 20";
    monthEarnLabel.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    monthEarnLabel.font = [UIFont systemFontOfSize:11];
    monthEarnLabel.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:monthEarnLabel];
    [monthEarnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_equalTo(vline.mas_left).offset(-20);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(hline.mas_bottom).offset(20);
    }];
    
    UILabel *monthEarnTip = [[UILabel alloc] init];
    monthEarnTip.text = @"本月预估";
    monthEarnTip.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    monthEarnTip.font = [UIFont systemFontOfSize:11];
    monthEarnTip.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:monthEarnTip];
    [monthEarnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_equalTo(vline.mas_left).offset(-20);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(monthEarnLabel.mas_bottom).offset(10);
    }];
    
    UILabel *todayEarnLabel = [[UILabel alloc] init];
    todayEarnLabel.text = @"¥ 5";
    todayEarnLabel.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    todayEarnLabel.font = [UIFont systemFontOfSize:11];
    todayEarnLabel.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:todayEarnLabel];
    [todayEarnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vline.mas_right).offset(20);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(hline.mas_bottom).offset(20);
    }];
    
    UILabel *todayEarnTip = [[UILabel alloc] init];
    todayEarnTip.text = @"今日收益";
    todayEarnTip.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    todayEarnTip.font = [UIFont systemFontOfSize:11];
    todayEarnTip.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:todayEarnTip];
    [todayEarnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(vline.mas_right).offset(20);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(monthEarnLabel.mas_bottom).offset(10);
    }];
}

- (void)addItomViewItems {
    CGFloat leftRightSpace = 20;
    CGFloat space = (MaxWidth - 60 - 40 * 4 - leftRightSpace * 2)/3;
    UIView *earnView = [self setItemWithIcon:@"icon_xd_discount" title:@"收益"];
    [_icomView addSubview:earnView];
    [earnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(leftRightSpace);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *orderView = [self setItemWithIcon:@"icon_xd_discount" title:@"订单"];
    [_icomView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnView.mas_right).offset(space);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *fenceView = [self setItemWithIcon:@"icon_xd_discount" title:@"粉丝"];
    [_icomView addSubview:fenceView];
    [fenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderView.mas_right).offset(space);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *invitateView = [self setItemWithIcon:@"icon_xd_discount" title:@"邀请"];
    [_icomView addSubview:invitateView];
    [invitateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-leftRightSpace);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
}


- (UIView *)setItemWithIcon:(NSString *)icon title:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
    UIImageView *iconImageV = [[UIImageView alloc] init];
    iconImageV.image = [UIImage imageNamed:icon];
    [view addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(20);
        make.centerX.mas_equalTo(view.mas_centerX).offset(0);
        make.width.height.mas_equalTo(15);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = title;
    titleLab.textColor = [UIColor jk_colorWithHexString:@"#8e8e8e"];
    titleLab.font = [UIFont systemFontOfSize:11];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageV.mas_bottom).offset(5);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(20);
    }];
    return view;
}


- (void)settingBtnClick {
    if (self.settingClick) {
        self.settingClick(nil);
    }
}

@end
