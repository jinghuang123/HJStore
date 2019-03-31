//
//  HJEarningVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/3/10.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarningVC.h"
#import "HJEarnDeatilRecordVC.h"


@interface CardView ()
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *payedOrderTip;
@property (nonatomic,strong) UILabel *earnTip;
@property (nonatomic,strong) UILabel *otherEarnTip;
@property (nonatomic,strong) UILabel *payedOrderValue;
@property (nonatomic,strong) UILabel *earnValue;
@property (nonatomic,strong) UILabel *otherEarnValue;
@property (nonatomic,strong) UIButton *rightButton;
@end

@implementation CardView


- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat cardWid = MaxWidth - 32;
    UIView *cardBgView = [[UIView alloc] init];
    cardBgView.layer.cornerRadius = 5;
    cardBgView.clipsToBounds = YES;
    cardBgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:cardBgView];
    [cardBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_offset(0);
        make.height.mas_equalTo(96);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _title = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.backgroundColor = [UIColor jk_colorWithHexString:@"#E32828"];
    titleLabel.layer.cornerRadius = 10;
    titleLabel.clipsToBounds = YES;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.mas_offset(9);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton = rightButton;
    rightButton.titleLabel.font = [UIFont systemFontOfSize:9];
    [rightButton setTitleColor:[UIColor jk_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    rightButton.backgroundColor = [UIColor jk_colorWithHexString:@"#FBE1A3"];
    rightButton.layer.cornerRadius = 8;
    rightButton.clipsToBounds = YES;
    [self addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.top.mas_offset(9);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(16);
    }];
    
    UILabel *payedOrderTip = [[UILabel alloc] init];
    _payedOrderTip = payedOrderTip;
    payedOrderTip.font = [UIFont systemFontOfSize:12];
    payedOrderTip.textColor = [UIColor blackColor];
    payedOrderTip.textAlignment = NSTextAlignmentCenter;
    [self addSubview:payedOrderTip];
    [payedOrderTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(15);
        make.width.mas_equalTo(cardWid/3);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *payedOrderValue = [[UILabel alloc] init];
    _payedOrderValue = payedOrderValue;
    payedOrderValue.font = [UIFont systemFontOfSize:12];
    payedOrderValue.textColor = [UIColor blackColor];
    payedOrderValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:payedOrderValue];
    [payedOrderValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_equalTo(payedOrderTip.mas_bottom).offset(5);
        make.width.mas_equalTo(cardWid/3);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *earnTip = [[UILabel alloc] init];
    _earnTip = earnTip;
    earnTip.font = [UIFont systemFontOfSize:12];
    earnTip.textColor = [UIColor blackColor];
    earnTip.textAlignment = NSTextAlignmentCenter;
    [self addSubview:earnTip];
    [earnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(payedOrderTip.mas_right).offset(0);
        make.top.mas_equalTo(payedOrderTip.mas_top).offset(0);
        make.width.mas_equalTo(cardWid/3);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *earnValue = [[UILabel alloc] init];
    _earnValue = earnValue;
    earnValue.font = [UIFont systemFontOfSize:12];
    earnValue.textColor = [UIColor blackColor];
    earnValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:earnValue];
    [earnValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(payedOrderValue.mas_right).offset(0);
        make.top.mas_equalTo(payedOrderValue.mas_top).offset(0);
        make.width.mas_equalTo(cardWid/3);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *otherEarnTip = [[UILabel alloc] init];
    _otherEarnTip = otherEarnTip;
    otherEarnTip.font = [UIFont systemFontOfSize:12];
    otherEarnTip.textColor = [UIColor blackColor];
    otherEarnTip.textAlignment = NSTextAlignmentCenter;
    [self addSubview:otherEarnTip];
    [otherEarnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnTip.mas_right).offset(0);
        make.top.mas_equalTo(payedOrderTip.mas_top).offset(0);
        make.width.mas_equalTo(cardWid/3);
        make.height.mas_equalTo(17);
    }];
    
    UILabel *otherEarnValue = [[UILabel alloc] init];
    _otherEarnValue = otherEarnValue;
    otherEarnValue.font = [UIFont systemFontOfSize:12];
    otherEarnValue.textColor = [UIColor blackColor];
    otherEarnValue.textAlignment = NSTextAlignmentCenter;
    [self addSubview:otherEarnValue];
    [otherEarnValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnValue.mas_right).offset(0);
        make.top.mas_equalTo(payedOrderValue.mas_top).offset(0);
        make.width.mas_equalTo(cardWid/3);
        make.height.mas_equalTo(17);
    }];
}

@end

@interface HJEarningVC ()
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, strong) UILabel *earnTotal;
@property (nonatomic, strong) CardView *todayEarnBgView;
@property (nonatomic, strong) CardView *yestodayEarnBgView;
@property (nonatomic, strong) CardView *monthEarnBgView;
@end

@implementation HJEarningVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat topViewH = MaxHeight >= ENM_SCREEN_H_X ? 265 : 235;
    UIImageView *topColorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, topViewH)];
    topColorView.image = [UIImage imageNamed:@"me_topBgImage"];
    [self.view addSubview:topColorView];
    
    [self setupNav];
    UILabel *totalEarnLabel = [[UILabel alloc] init];
    totalEarnLabel.textColor = [UIColor whiteColor];
    totalEarnLabel.text = @"累计结算收益(元)";
    totalEarnLabel.textAlignment = NSTextAlignmentCenter;
    totalEarnLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:totalEarnLabel];
    weakify(self)
    [totalEarnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(weak_self.backView.mas_bottom).offset(8);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *earnTotal = [[UILabel alloc] init];
    _earnTotal = earnTotal;
    earnTotal.textColor = [UIColor whiteColor];
    earnTotal.text = @"¥3020.28";
    earnTotal.textAlignment = NSTextAlignmentCenter;
    earnTotal.font = [UIFont systemFontOfSize:10];
    [self.view addSubview:earnTotal];
    [earnTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(totalEarnLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(10);
    }];
    [self setTodayEarnView];
    [self setYestodayEarnView];
    [self setMonthEarnView];
    
    
    UIButton *getRecodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [getRecodsBtn setBackgroundImage:[UIImage imageNamed:@"earn_commit_btn"] forState:UIControlStateNormal];
    [getRecodsBtn setTitle:@"全部提现记录" forState:UIControlStateNormal];
    [getRecodsBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    getRecodsBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:getRecodsBtn];
    [getRecodsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.top.mas_equalTo(weak_self.monthEarnBgView.mas_bottom).offset(32);
        make.left.mas_offset(16);
        make.height.mas_equalTo(32);
    }];
    [getRecodsBtn jk_addActionHandler:^(NSInteger tag) {
        HJEarnDeatilRecordVC *earnRecordVC = [[HJEarnDeatilRecordVC alloc] init];
        [self.navigationController pushViewController:earnRecordVC animated:YES];
    }];
    
}

- (void)setupNav {
    CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? 40 : 20;
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, topOffSet, 80, 44)];
    _backView = backView;
    backView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:backView];
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"earn_back"] forState:UIControlStateNormal];
    [backView addSubview:backButton];
    [backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(15);
        make.width.mas_equalTo(8);
        make.height.mas_equalTo(14);
    }];
    UILabel *backLabel = [[UILabel alloc] init];
    backLabel.textColor = [UIColor whiteColor];
    backLabel.text = @"返回";
    backLabel.font = [UIFont systemFontOfSize:14];
    [backView addSubview:backLabel];
    [backLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(backButton.mas_right).offset(5);
        make.centerY.mas_equalTo(backButton.mas_centerY).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(25);
    }];
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = @"我的收益";
    titleLabel.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.mas_equalTo(backButton.mas_centerY).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(25);
    }];
    
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightBtn setBackgroundImage:[UIImage imageNamed:@"earn_right_btn"] forState:UIControlStateNormal];
    [navRightBtn setTitle:@"收益结算明细" forState:UIControlStateNormal];
    [navRightBtn setTitleColor:[UIColor jk_colorWithHexString:@"#333333"] forState:UIControlStateNormal];
    navRightBtn.titleLabel.font = [UIFont systemFontOfSize:9];
    [self.view addSubview:navRightBtn];
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.centerY.mas_equalTo(backButton.mas_centerY).offset(0);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(21);
    }];
    
    [navRightBtn jk_addActionHandler:^(NSInteger tag) {
   
    }];
}

- (void)setTodayEarnView {
    weakify(self)
    CardView *todayEarnBgView = [[CardView alloc] init];
    _todayEarnBgView = todayEarnBgView;
    todayEarnBgView.title.text = @"今日收益";
    todayEarnBgView.payedOrderTip.text = @"付款订单(笔)";
    todayEarnBgView.earnTip.text = @"预估收益(元)";
    todayEarnBgView.otherEarnTip.text = @"其他收益";
    todayEarnBgView.payedOrderValue.text = @"0";
    todayEarnBgView.earnValue.text = @"¥0";
    todayEarnBgView.otherEarnValue.text = @"¥0";
    [todayEarnBgView.rightButton setTitle:@"收益明细" forState:UIControlStateNormal];
    [self.view addSubview:todayEarnBgView];
    [todayEarnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.right.mas_offset(-16);
        make.height.mas_equalTo(96);
        make.top.mas_equalTo(weak_self.earnTotal.mas_bottom).offset(10);
    }];
    [todayEarnBgView.rightButton jk_addActionHandler:^(NSInteger tag) {
        
    }];
    
}

- (void)setYestodayEarnView {
    weakify(self)
    CardView *yestodayBgView = [[CardView alloc] init];
    _yestodayEarnBgView = yestodayBgView;
    yestodayBgView.title.text = @"昨日收益";
    yestodayBgView.payedOrderTip.text = @"付款订单(笔)";
    yestodayBgView.earnTip.text = @"预估收益(元)";
    yestodayBgView.otherEarnTip.text = @"其他收益";
    yestodayBgView.payedOrderValue.text = @"0";
    yestodayBgView.earnValue.text = @"¥0";
    yestodayBgView.otherEarnValue.text = @"¥0";
    yestodayBgView.rightButton.hidden = YES;
    [self.view addSubview:yestodayBgView];
    [yestodayBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.right.mas_offset(-16);
        make.height.mas_equalTo(96);
        make.top.mas_equalTo(weak_self.todayEarnBgView.mas_bottom).offset(10);
    }];
    
}


- (void)setMonthEarnView {
    weakify(self)
    CardView *monthEarnBgView = [[CardView alloc] init];
    _monthEarnBgView = monthEarnBgView;
    monthEarnBgView.title.text = @"月预估收益";
    monthEarnBgView.payedOrderTip.text = @"本月预估收益";
    monthEarnBgView.earnTip.text = @"上月预估收益";
    monthEarnBgView.otherEarnTip.text = @"上月结算收益";
    monthEarnBgView.payedOrderValue.text = @"¥0";
    monthEarnBgView.earnValue.text = @"¥0";
    monthEarnBgView.otherEarnValue.text = @"¥0";
    [monthEarnBgView.rightButton setTitle:@"历史月报" forState:UIControlStateNormal];
    [self.view addSubview:monthEarnBgView];
    [monthEarnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.right.mas_offset(-16);
        make.height.mas_equalTo(96);
        make.top.mas_equalTo(weak_self.yestodayEarnBgView.mas_bottom).offset(10);
    }];
    
    [monthEarnBgView.rightButton jk_addActionHandler:^(NSInteger tag) {
        
    }];
}


@end
