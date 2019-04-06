//
//  HJOrderItemCell.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJOrderItemCell.h"
#import "HJSuperView.h"



@interface HJOrderItemCell ()
@property (nonatomic, strong) UIView *contentForeGrondView;
@property (nonatomic, strong) UIImageView *proImage;
@property (nonatomic, strong) UILabel *proTitleLabel;
@property (nonatomic, strong) UILabel *statuLabel;
@property (nonatomic, strong) UILabel *orderIdLabel;
@property (nonatomic, strong) UILabel *orderValueLabel;
@property (nonatomic, strong) UILabel *createTimeLabel;
@property (nonatomic, strong) UILabel *earnLabel;
@property (nonatomic, strong) UILabel *settlementLabel;
@end

@implementation HJOrderItemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupCellView];
    }
    return self;
}


- (void)setupCellView {
    UIView *contentForeGrondView = [[UIView alloc] init];
    _contentForeGrondView = contentForeGrondView;
    contentForeGrondView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentForeGrondView];
    
    UIImageView *proImage = [[UIImageView alloc] init];
    _proImage = proImage;
    proImage.image = [UIImage imageNamed:@"head_imageDefalut"];
    proImage.layer.cornerRadius = 2;
    proImage.clipsToBounds = YES;
    [contentForeGrondView addSubview:proImage];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _proTitleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    titleLabel.text = @"梅湾街春装新款百搭修身高领打底衫女长袖好衣服好衣服好衣服";
    [contentForeGrondView addSubview:titleLabel];
    
    UILabel *statuLabel = [[UILabel alloc] init];
    _statuLabel = statuLabel;
    statuLabel.backgroundColor = [UIColor jk_colorWithHexString:@"#E32828"];
    statuLabel.textColor = [UIColor whiteColor];
    statuLabel.layer.cornerRadius = 8;
    statuLabel.clipsToBounds = YES;
    statuLabel.textAlignment = NSTextAlignmentCenter;
    statuLabel.font = [UIFont systemFontOfSize:10];
    statuLabel.text = @"已付款";
    [contentForeGrondView addSubview:statuLabel];

    UILabel *orderIdLabel = [[UILabel alloc] init];
    _orderIdLabel = orderIdLabel;
    orderIdLabel.font = [UIFont systemFontOfSize:12];
    orderIdLabel.textColor = [UIColor lightGrayColor];
    orderIdLabel.text = @"单号:2014504054304933";
    [contentForeGrondView addSubview:orderIdLabel];
    
    UILabel *valueLabel = [[UILabel alloc] init];
    _orderValueLabel = valueLabel;
    valueLabel.font = [UIFont systemFontOfSize:10];
    valueLabel.textColor = [UIColor lightGrayColor];
    valueLabel.text = @"付款金额: 1000";
    [contentForeGrondView addSubview:valueLabel];
    
    UILabel *createLabel = [[UILabel alloc] init];
    _createTimeLabel = createLabel;
    createLabel.font = [UIFont systemFontOfSize:10];
    createLabel.textColor = [UIColor lightGrayColor];
    createLabel.text = @"创建日期: 03-12 15:23";
    [contentForeGrondView addSubview:createLabel];
    
    UILabel *earnLabel = [[UILabel alloc] init];
    _earnLabel = earnLabel;
    earnLabel.font = [UIFont systemFontOfSize:10];
    earnLabel.textColor = [UIColor jk_colorWithHexString:@"#e32828"];
    earnLabel.text = @"预估收益: 12.32";
    [contentForeGrondView addSubview:earnLabel];
    
    UILabel *settlementLabel = [[UILabel alloc] init];
    _settlementLabel = settlementLabel;
    settlementLabel.font = [UIFont systemFontOfSize:10];
    settlementLabel.textColor = [UIColor lightGrayColor];
    settlementLabel.text = @"结算日期: 03-31 15:23";
    [contentForeGrondView addSubview:settlementLabel];
    
    [self makeViewConstranints];
    
}

- (void)makeViewConstranints {
    weakify(self)
    [_contentForeGrondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(5);
        make.height.mas_equalTo(96);
    }];
    
    [_proImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(8);
        make.width.height.mas_equalTo(80);
    }];
    
    [_proTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.proImage.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.proImage.mas_top).offset(0);
        make.right.mas_offset(-8);
    }];
    
    [_statuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.proImage.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.proTitleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(44);
    }];
    
    [_orderIdLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.statuLabel.mas_right).offset(5);
        make.centerY.mas_equalTo(weak_self.statuLabel.mas_centerY).offset(0);
        make.right.mas_offset(-10);
    }];
    
    [_orderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.proImage.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.orderIdLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(15);
    }];
    
    [_createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.proImage.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.orderValueLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(15);
    }];
    
    [_earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_equalTo(weak_self.orderIdLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(15);
    }];
    
    
    [_settlementLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_equalTo(weak_self.earnLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(110);
        make.height.mas_equalTo(15);
    }];
}

- (void)updateWithOrderItem:(HJOrderListItemModel *)order {
    [self.proImage sd_setImageWithURLString:order.image placeholderImage:PLACEHOLDER_Category];
    self.proTitleLabel.text = order.item_title;
    NSString *status = @"";
    

    UIColor *color = [UIColor jk_colorWithHexString:@"#E32828"];
    switch (order.tk_status) {
        case 3:
            status = @"已结算";
            break;
        case 12:
            status = @"已付款";
            break;
        case 13:
            color = [UIColor lightGrayColor];
            status = @"已失效";
            break;
        default:
            break;
    }
    self.statuLabel.text = status;
    self.statuLabel.backgroundColor = color;
    self.orderIdLabel.text = [NSString stringWithFormat:@"订单号: %@",order.trade_id];
    self.orderValueLabel.text = [NSString stringWithFormat:@"付款金额: %@",order.alipay_total_price];
    self.earnLabel.text = [NSString stringWithFormat:@"预估收益: %@",order.money];
    self.createTimeLabel.text = [NSString stringWithFormat:@"创建日期: %@",order.create_time];
    NSString *earnTime = order.earning_time ? : @"无";
    self.settlementLabel.text = [NSString stringWithFormat:@"结算日期: %@",earnTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
