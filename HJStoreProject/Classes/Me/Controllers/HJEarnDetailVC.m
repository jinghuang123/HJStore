//
//  HJEarnDetailVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarnDetailVC.h"
#import "HJSettingRequest.h"


@interface HJWeiquanCell ()
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end
@implementation HJWeiquanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeCell];
    }
    return self;
}

- (void)makeCell {
    UIView *contentForeGrondView = [[UIView alloc] init];
    contentForeGrondView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentForeGrondView];
    [contentForeGrondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(2);
        make.bottom.mas_offset(0);
    }];
    
    UILabel *orderIdLabel = [[UILabel alloc] init];
    _orderIdLabel = orderIdLabel;
    orderIdLabel.font = [UIFont systemFontOfSize:12];
    orderIdLabel.text = @"维权订单号:4423303434023322";
    orderIdLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    [contentForeGrondView addSubview:orderIdLabel];
    [orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.width.mas_equalTo(260);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *dateLabel = [[UILabel alloc] init];
    _dateLabel = dateLabel;
    dateLabel.font = [UIFont systemFontOfSize:10];
    dateLabel.textColor = [UIColor lightGrayColor];
    dateLabel.text = @"2015年5月3日";
    [contentForeGrondView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(orderIdLabel.mas_left).offset(0);
        make.top.mas_equalTo(orderIdLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    _moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:10];
    moneyLabel.textColor = [UIColor redColor];
    moneyLabel.textAlignment = NSTextAlignmentRight;
    moneyLabel.text = @"- ¥10.00";
    [contentForeGrondView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_equalTo(dateLabel.mas_top).offset(0);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [copyButton jk_setBackgroundColor:[UIColor redColor] forState:UIControlStateNormal];
    [copyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    copyButton.titleLabel.font = [UIFont systemFontOfSize:9];
    copyButton.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;
    copyButton.layer.borderWidth = 1.0;
    copyButton.layer.cornerRadius = 7.5;
    copyButton.clipsToBounds = YES;
    [contentForeGrondView addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_equalTo(15);
        make.width.mas_equalTo(32);
        make.centerY.mas_equalTo(orderIdLabel.mas_centerY).offset(0);
    }];
    [copyButton jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        //        [self jk_makeToast:@"邀请码复制成功" duration:1.0 position:JKToastPositionCenter];
//        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
//        pasteboard.string = self.code;
    }];
}

- (void)updateContentWithModel:(HJWeiquanModel *)model {
    _moneyLabel.text = [NSString stringWithFormat:@"- ¥%@",model.money];
    _dateLabel.text = model.date;
    _orderIdLabel.text = [NSString stringWithFormat:@"维权订单号:%@",model.weiquanId];

}

@end

@interface HJSettlementCell ()
@property (nonatomic, strong) UIImageView *proImage;
@property (nonatomic, strong) UILabel *proTitleLabel;
@property (nonatomic, strong) UILabel *earnLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UILabel *settlementTimeLabel;
@property (nonatomic, strong) UILabel *moneyLabel;
@end
@implementation HJSettlementCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeCell];
    }
    return self;
}

- (void)makeCell {
    UIView *contentForeGrondView = [[UIView alloc] init];
    contentForeGrondView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentForeGrondView];
    [contentForeGrondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(2);
        make.bottom.mas_offset(0);
    }];
    weakify(self)
    UIImageView *proImage = [[UIImageView alloc] init];
    _proImage = proImage;
    proImage.image = [UIImage imageNamed:@"head_imageDefalut"];
    proImage.layer.cornerRadius = 2;
    proImage.clipsToBounds = YES;
    [contentForeGrondView addSubview:proImage];
    [proImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(8);
        make.width.height.mas_equalTo(44);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _proTitleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    titleLabel.text = @"梅湾街春装新款百搭修身高领打底衫女长袖好衣服好衣服好衣服";
    [contentForeGrondView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.proImage.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.proImage.mas_top).offset(0);
        make.right.mas_offset(-88);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *earnLabel = [[UILabel alloc] init];
    _earnLabel = earnLabel;
    earnLabel.font = [UIFont systemFontOfSize:12];
    earnLabel.textColor = [UIColor redColor];
    earnLabel.text = @"+ ¥2.23";
    earnLabel.textAlignment = NSTextAlignmentRight;
    [contentForeGrondView addSubview:earnLabel];
    [earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_equalTo(weak_self.proImage.mas_top).offset(0);
        make.width.mas_offset(75);
        make.height.mas_equalTo(20);
    }];
    
    
    CGFloat wid = (MaxWidth - 70)/3;

    
    UILabel *createTimeLabel = [[UILabel alloc] init];
    _createTimeLabel = createTimeLabel;
    createTimeLabel.font = [UIFont systemFontOfSize:9];
    createTimeLabel.textColor = [UIColor lightGrayColor];
    createTimeLabel.text = @"创建:2019-04-05";
    [contentForeGrondView addSubview:createTimeLabel];
    [createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(titleLabel.mas_left).offset(0);
        make.bottom.mas_equalTo(proImage.mas_bottom).offset(0);
        make.width.mas_offset(wid);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *settlementTimeLabel = [[UILabel alloc] init];
    _settlementTimeLabel = settlementTimeLabel;
    settlementTimeLabel.font = [UIFont systemFontOfSize:9];
    settlementTimeLabel.textColor = [UIColor lightGrayColor];
    settlementTimeLabel.text = @"结算:2019-04-05";
    [contentForeGrondView addSubview:settlementTimeLabel];
    [settlementTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(createTimeLabel.mas_right).offset(0);
        make.bottom.mas_equalTo(createTimeLabel.mas_bottom).offset(0);
        make.width.mas_offset(wid);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *moneyLabel = [[UILabel alloc] init];
    _moneyLabel = moneyLabel;
    moneyLabel.font = [UIFont systemFontOfSize:9];
    moneyLabel.textColor = [UIColor lightGrayColor];
    moneyLabel.text = @"订单金额:¥10.00";
    moneyLabel.textAlignment = NSTextAlignmentRight;
    [contentForeGrondView addSubview:moneyLabel];
    [moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_equalTo(createTimeLabel.mas_bottom).offset(0);
        make.width.mas_offset(wid);
        make.height.mas_equalTo(15);
    }];
}



- (void)updateContentWithModel:(HJCommissionInfo *)info {
    _proTitleLabel.text = info.item_title;
    [_proImage sd_setImageWithURLString:info.image placeholderImage:PLACEHOLDER_Category];
    _earnLabel.text = [NSString stringWithFormat:@"+ ¥%@",info.money];
    NSString *price = info.price ? : @"0.00";
    _moneyLabel.text = [NSString stringWithFormat:@"订单金额:¥%@",price];
    _createTimeLabel.text = [NSString stringWithFormat:@"创建:%@",info.createtime];
    _settlementTimeLabel.text = [NSString stringWithFormat:@"结算:%@",info.jiesuantime];

}

@end


@interface HJEarnDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end


static NSString *HJSettlementCellID = @"HJSettlementCellIdentifier";
static NSString *HJWeiquanCellID = @"HJWeiquanCellIdentifier";

@implementation HJEarnDetailVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"收益结算明细";
    [self createUI];
}

- (void)createUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, MaxWidth, MaxHeight - HJTopNavH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#f5f5f5"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.tableView.mj_header beginRefreshing];
}

- (NSMutableArray *)dataSource {
    if(!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)headRefresh {
    weakify(self);
    [self refreshActionSuccess:^(NSArray *orders) {
        [weak_self.dataSource setArray:orders];
        [weak_self.tableView reloadData];
        [weak_self.tableView.mj_header endRefreshing];
    }];
}

- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    if (self.type == HJEarnDetailListTypeEarn) {
        [[HJSettingRequest shared] getCommissionInfoSuccess:^(NSArray *infos) {
            success(infos);
        } fail:^(NSError *error) {
            success([NSArray array]);
        }];
    }else if (self.type == HJEarnDetailListTypeOrder){
        [[HJSettingRequest shared] getWeiquanOrderSuccess:^(NSArray *orders) {
            success(orders);
        } fail:^(NSError *error) {
            success([NSArray array]);
        }];
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if(self.type == HJEarnDetailListTypeEarn){
        HJSettlementCell *settlementCell = [tableView dequeueReusableCellWithIdentifier:HJSettlementCellID];
        if (!settlementCell) {
            settlementCell = [[HJSettlementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJSettlementCellID];
        }
        settlementCell.backgroundColor = [UIColor clearColor];
        HJCommissionInfo *info = [self.dataSource objectAtIndex:indexPath.row];
        [settlementCell updateContentWithModel:info];
        cell = settlementCell;
    }else {
        HJWeiquanCell *weiquanCell = [tableView dequeueReusableCellWithIdentifier:HJWeiquanCellID];
        if (!weiquanCell) {
            weiquanCell = [[HJWeiquanCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:HJWeiquanCellID];
        }
        weiquanCell.backgroundColor = [UIColor clearColor];
        HJWeiquanModel *model = [self.dataSource objectAtIndex:indexPath.row];
        [weiquanCell updateContentWithModel:model];
        cell = weiquanCell;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}



@end
