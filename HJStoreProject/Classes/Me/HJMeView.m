//
//  HJMeView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMeView.h"
#import "HJMainSliderCell.h"

@interface HJMeView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroView;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *earningView;
@property (nonatomic, strong) UIImageView *earningBottomView;
@property (nonatomic, strong) UIView *icomView;
@property (nonatomic, strong) UIView *serviceView;
@property (nonatomic, strong) HJMainSliderView *adSliderCellView;
@property (nonatomic, strong) UIView *toolsView;
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
    CGFloat scroH = MaxHeight > 600 ? MaxHeight: 600;
    BOOL scrEnable = MaxHeight > 600 ? NO : YES;
    self.scroView = [[UIScrollView alloc] init];
    self.scroView.contentSize = CGSizeMake(0, scroH);
    self.scroView.delegate = self;
    self.scroView.pagingEnabled = YES;
    self.scroView.scrollEnabled = scrEnable;
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
    CGFloat topOffSet = MaxHeight >= ENM_SCREEN_H_X ? 20 : 0;
    CGFloat topViewH = MaxHeight > 600 ? 200 : 180;
    CGFloat contentH = MaxHeight > 600 ? MaxHeight: 600;
    NSLog(@">>>>>>%f",MaxHeight);
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, contentH)];
    headView.backgroundColor = [UIColor jk_colorWithHexString:@"#F2F2F2"];
    [self.scroView addSubview:headView];
    
    UIImageView *topColorView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, topViewH)];
    topColorView.image = [UIImage imageNamed:@"me_topBgImage"];
    [headView addSubview:topColorView];
    
    CGFloat headSize = 60;
    UIImageView *headImageView = [[UIImageView alloc] init];
    _headImageView = headImageView;
    headImageView.userInteractionEnabled = YES;
    headImageView.image = [UIImage imageNamed:@"head_imageDefalut.jpg"]; //PLACEHOLDER_HEAD
    headImageView.layer.cornerRadius = headSize/2;
    headImageView.clipsToBounds = YES;
    [headView addSubview:headImageView];
    [headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(35 + topOffSet);
        make.width.height.mas_equalTo(headSize);
    }];
    [headImageView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeHead];
    }];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    _nameLabel = nameLabel;
    nameLabel.text = @"杨老板是大傻B";
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.font = [UIFont systemFontOfSize:16];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headImageView.mas_top).offset(5);
        make.left.mas_equalTo(headImageView.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *codeLabel = [[UILabel alloc] init];
    _codeLabel = codeLabel;
    codeLabel.text = @"邀请码:x5s7DdgyZ";
    codeLabel.textColor = [UIColor whiteColor];
    codeLabel.font = [UIFont systemFontOfSize:11];
    codeLabel.textAlignment = NSTextAlignmentLeft;
    [headView addSubview:codeLabel];
    [codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(nameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(nameLabel.mas_left).offset(0);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [copyButton jk_setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [copyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    copyButton.titleLabel.font = [UIFont systemFontOfSize:9];
    copyButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    copyButton.layer.borderWidth = 1.0;
    copyButton.layer.cornerRadius = 7.5;
    copyButton.clipsToBounds = YES;
    [headView addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(codeLabel.mas_right).offset(0);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(32);
        make.centerY.mas_equalTo(codeLabel.mas_centerY).offset(0);
    }];
    [copyButton jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
    UIButton *messageIcon = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageIcon setBackgroundImage:[UIImage imageNamed:@"me_message"] forState:UIControlStateNormal];
    [messageIcon setBackgroundImage:[UIImage imageNamed:@"me_message"] forState:UIControlStateSelected];
    [headView addSubview:messageIcon];
    [messageIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(21);
        make.top.mas_equalTo(headImageView.mas_top).offset(0);
    }];
    [messageIcon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
    
    
    
    UIImageView *earningView = [[UIImageView alloc] init];
    earningView.image = [UIImage imageNamed:@"me_top_yellow"];
    _earningView = earningView;
    [headView addSubview:earningView];
    [earningView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.mas_offset(-8);
        make.bottom.mas_equalTo(topColorView.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(60);
    }];
    UIImageView *earningBottomView = [[UIImageView alloc] init];
    earningBottomView.image = [UIImage imageNamed:@"me_bottom_yellow"];
    _earningBottomView = earningBottomView;
    [headView addSubview:earningBottomView];
    [earningBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.mas_offset(-8);
        make.top.mas_equalTo(topColorView.mas_bottom).mas_offset(0);
        make.height.mas_equalTo(67);
    }];
    [self addEarningViewItems];
    

    
    UIView *icomView = [[UIView alloc] init];
    _icomView = icomView;
    icomView.backgroundColor = [UIColor whiteColor];
    icomView.layer.cornerRadius = 10;
    icomView.clipsToBounds = YES;
    [headView addSubview:icomView];
    [icomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.mas_offset(-8);
        make.top.mas_equalTo(earningBottomView.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(60);
    }];
    [self addItomViewItems];
    
    HJMainSliderView *adSliderCellView = [[HJMainSliderView alloc] initWithFrame:CGRectMake(8, 0, MaxWidth - 16, 100)];
    _adSliderCellView = adSliderCellView;
    adSliderCellView.backgroundColor = [UIColor clearColor];
    adSliderCellView.imageGroupArray = @[@"me_banner"];
    [headView addSubview:adSliderCellView];
    [adSliderCellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.mas_offset(-8);
        make.height.mas_equalTo(100);
        make.top.mas_equalTo(icomView.mas_bottom).offset(8);
    }];
    
    UIView *toolsView = [[UIView alloc] init];
    _toolsView = toolsView;
    toolsView.backgroundColor = [UIColor whiteColor];
    toolsView.layer.cornerRadius = 10;
    toolsView.clipsToBounds = YES;
    [headView addSubview:toolsView];
    [toolsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.right.mas_offset(-8);
        make.top.mas_equalTo(adSliderCellView.mas_bottom).mas_offset(8);
        make.height.mas_equalTo(158);
    }];
    [self addToolItems];
    
}

- (void)addEarningViewItems {
    UILabel *remainMoneyLabel = [[UILabel alloc] init];
    remainMoneyLabel.text = @"余额(元)";
    remainMoneyLabel.textColor = [UIColor whiteColor];
    remainMoneyLabel.font = [UIFont boldSystemFontOfSize:12];
    remainMoneyLabel.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:remainMoneyLabel];
    
    [remainMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(8);
        make.right.mas_equalTo(-MaxWidth/2);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *applyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyBtn setTitle:@"立即提现" forState:UIControlStateNormal];
    [applyBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyBtn.titleLabel.font = [UIFont boldSystemFontOfSize:10];
    applyBtn.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    applyBtn.layer.borderWidth = 1.0;
    applyBtn.layer.cornerRadius = 10;
    applyBtn.clipsToBounds = YES;
    [_earningView addSubview:applyBtn];
    [applyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-51);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(72);
        make.top.mas_offset(8);
    }];
    [applyBtn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeWithDrawal];
    }];

    
    UILabel *monthEarnLabel = [[UILabel alloc] init];
    monthEarnLabel.text = @"¥ 10120";
    monthEarnLabel.textColor = [UIColor whiteColor];
    monthEarnLabel.font = [UIFont systemFontOfSize:18];
    monthEarnLabel.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:monthEarnLabel];
    [monthEarnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.right.mas_offset(-MaxWidth/2);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(remainMoneyLabel.mas_bottom).offset(10);
    }];
    
    UILabel *earnTip = [[UILabel alloc] init];
    earnTip.text = @"（每月25号可提现上月结算收益）";
    earnTip.textColor = [UIColor whiteColor];
    earnTip.font = [UIFont systemFontOfSize:8];
    earnTip.textAlignment = NSTextAlignmentCenter;
    [_earningView addSubview:earnTip];
    [earnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(MaxWidth/2);
        make.right.mas_offset(0);
        make.height.mas_equalTo(8);
        make.bottom.mas_offset(-10);
    }];
    
    UILabel *monthEarnTip = [[UILabel alloc] init];
    monthEarnTip.text = @"本月预估 ¥ 1509";
    monthEarnTip.textColor = [UIColor blackColor];
    monthEarnTip.font = [UIFont systemFontOfSize:12];
    monthEarnTip.textAlignment = NSTextAlignmentCenter;
    [_earningBottomView addSubview:monthEarnTip];
    [monthEarnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-MaxWidth/2+10);
        make.height.mas_equalTo(20);
        make.top.mas_offset(8);
    }];

    UILabel *todayEarnTip = [[UILabel alloc] init];
    todayEarnTip.text = @"今日收益 ¥28";
    todayEarnTip.textColor = [UIColor blackColor];
    todayEarnTip.font = [UIFont systemFontOfSize:12];
    todayEarnTip.textAlignment = NSTextAlignmentCenter;
    [_earningBottomView addSubview:todayEarnTip];
    [todayEarnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(MaxWidth/2);
        make.right.mas_offset(0);
        make.height.mas_equalTo(20);
        make.top.mas_offset(8);
    }];
    
    UILabel *lastMonthEarnTip = [[UILabel alloc] init];
    lastMonthEarnTip.text = @"上月结算";
    lastMonthEarnTip.textColor = [UIColor blackColor];
    lastMonthEarnTip.font = [UIFont systemFontOfSize:10];
    lastMonthEarnTip.textAlignment = NSTextAlignmentCenter;
    [_earningBottomView addSubview:lastMonthEarnTip];
    [lastMonthEarnTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-MaxWidth/2 + 10);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(monthEarnTip.mas_bottom).offset(5);
    }];
    
    UILabel *lastMonthEarnCount = [[UILabel alloc] init];
    lastMonthEarnCount.text = @"¥200";
    lastMonthEarnCount.textColor = [UIColor blackColor];
    lastMonthEarnCount.font = [UIFont systemFontOfSize:11];
    lastMonthEarnCount.textAlignment = NSTextAlignmentCenter;
    [_earningBottomView addSubview:lastMonthEarnCount];
    [lastMonthEarnCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-MaxWidth/2+10);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(lastMonthEarnTip.mas_bottom).offset(5);
    }];
    
    
    UILabel *lastMonthTip = [[UILabel alloc] init];
    lastMonthTip.text = @"上月预估";
    lastMonthTip.textColor = [UIColor blackColor];
    lastMonthTip.font = [UIFont systemFontOfSize:10];
    lastMonthTip.textAlignment = NSTextAlignmentCenter;
    [_earningBottomView addSubview:lastMonthTip];
    [lastMonthTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(MaxWidth/2);
        make.right.mas_offset(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(todayEarnTip.mas_bottom).offset(5);
    }];
    
    UILabel *lastMonthCount = [[UILabel alloc] init];
    lastMonthCount.text = @"¥180";
    lastMonthCount.textColor = [UIColor blackColor];
    lastMonthCount.font = [UIFont systemFontOfSize:11];
    lastMonthCount.textAlignment = NSTextAlignmentCenter;
    [_earningBottomView addSubview:lastMonthCount];
    [lastMonthCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(MaxWidth/2);
        make.right.mas_offset(0);
        make.height.mas_equalTo(10);
        make.top.mas_equalTo(lastMonthTip.mas_bottom).offset(5);
    }];
}

- (void)addItomViewItems {
    CGFloat leftRightSpace = 10;
    CGFloat space = (MaxWidth - 20 - 40 * 5 - leftRightSpace * 2)/4;
    UIView *earnView = [self setItemWithIcon:@"shouyiicon" title:@"收益"];
    _earnView = earnView;
    [_icomView addSubview:earnView];
    [earnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(leftRightSpace);
        make.top.mas_offset(8);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    [earnView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeEarn];
    }];
    
    UIView *orderView = [self setItemWithIcon:@"dingdanicon" title:@"订单"];
    _orderView = orderView;
    [_icomView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnView.mas_right).offset(space);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    [orderView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeOrder];
    }];
    
    UIView *fenceView = [self setItemWithIcon:@"fensiicon" title:@"粉丝"];
    _fenceView = fenceView;
    [_icomView addSubview:fenceView];
    [fenceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderView.mas_right).offset(space);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    [fenceView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeFence];
    }];
    
    UIView *invitateView = [self setItemWithIcon:@"yaoqingicon" title:@"邀请"];
    _invitateView = invitateView;
    [_icomView addSubview:invitateView];
    [invitateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(fenceView.mas_right).offset(space);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    [invitateView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeInvitation];
    }];
    
    UIView *serviceView = [self setItemWithIcon:@"kefucion" title:@"专属客服"];
    _serviceView = serviceView;
    [_icomView addSubview:serviceView];
    [serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-leftRightSpace);
        make.top.mas_offset(10);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    [serviceView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self onItemClickWithType:HJClickItemTypeService];
    }];
}


- (UIView *)setItemWithIcon:(NSString *)icon title:(NSString *)title {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 60)];
    UIImageView *iconImageV = [[UIImageView alloc] init];
    iconImageV.image = [UIImage imageNamed:icon];
    [view addSubview:iconImageV];
    [iconImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(32);
    }];
    UILabel *titleLab = [[UILabel alloc] init];
    titleLab.text = title;
    titleLab.textColor = [UIColor jk_colorWithHexString:@"#515151"];
    titleLab.font = [UIFont systemFontOfSize:8];
    titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:titleLab];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(iconImageV.mas_bottom).offset(3);
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(10);
    }];
    return view;
}

- (void)addToolItems {
    UILabel *deviceTip = [[UILabel alloc] init];
    deviceTip.text = @"必备工具";
    deviceTip.font = [UIFont systemFontOfSize:12];
    [_toolsView addSubview:deviceTip];
    [deviceTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(10);
        make.height.mas_equalTo(20);
        make.right.mas_offset(15);
    }];
    UIView *vline = [[UIView alloc] init];
    vline.backgroundColor = [UIColor jk_colorWithHexString:@"#F2F2F2"];
    [_toolsView addSubview:vline];
    [vline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(36);
        make.height.mas_equalTo(1);
    }];
    
    CGFloat leftRightSpace = 10;
    CGFloat top = 45;
    CGFloat space = (MaxWidth - 20 - 40 * 5 - leftRightSpace * 2)/4;
    UIView *guideItemView = [self setItemWithIcon:@"xinshouicon" title:@"新手攻略"];
    [_toolsView addSubview:guideItemView];
    [guideItemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(leftRightSpace);
        make.top.mas_offset(top);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *problemView = [self setItemWithIcon:@"changjianwentiicon" title:@"常见问题"];
    [_toolsView addSubview:problemView];
    [problemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(guideItemView.mas_right).offset(space);
        make.top.mas_offset(top);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *collectedView = [self setItemWithIcon:@"shouchangcion" title:@"收藏"];
    [_toolsView addSubview:collectedView];
    [collectedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(problemView.mas_right).offset(space);
        make.top.mas_offset(top);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *feedBackView = [self setItemWithIcon:@"yijianfankuiicon" title:@"意见反馈"];
    [_toolsView addSubview:feedBackView];
    [feedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(collectedView.mas_right).offset(space);
        make.top.mas_offset(top);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *signView = [self setItemWithIcon:@"guanfangicon" title:@"官方公告"];
    [_toolsView addSubview:signView];
    [signView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(feedBackView.mas_right).offset(space);
        make.top.mas_offset(top);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    UIView *settingView = [self setItemWithIcon:@"shezhiicon" title:@"设置"];
    [_toolsView addSubview:settingView];
    [settingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(leftRightSpace);
        make.top.mas_equalTo(guideItemView.mas_bottom).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
    
    
    UIView *aboutUsView = [self setItemWithIcon:@"guanyuwomengicon" title:@"关于我们"];
    [_toolsView addSubview:aboutUsView];
    [aboutUsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(settingView.mas_right).offset(space);
        make.top.mas_equalTo(problemView.mas_bottom).offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_offset(60);
    }];
}


- (void)onItemClickWithType:(HJClickItemType)type {
    if (self.settingClick) {
        self.settingClick(nil,type);
    }
}

@end
