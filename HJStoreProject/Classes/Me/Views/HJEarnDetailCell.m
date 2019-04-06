//
//  HJEarnDetailCell.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/30.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarnDetailCell.h"

@interface HJEarnDetailCell()
@property (nonatomic,strong) UILabel *earnValue;
@property (nonatomic,strong) UILabel *orderNumber;
@property (nonatomic,strong) UILabel *createTime;
@property (nonatomic,strong)  HJDrawalRecordModel *record;
@end

@implementation HJEarnDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self makeCell];
    }
    return self;
}

- (void)makeCell {
    UILabel *earnTitle = [[UILabel alloc] init];
    earnTitle.text = @"支付宝提现成功";
    earnTitle.textColor = [UIColor jk_colorWithHexString:@"#515151"];
    earnTitle.font = [UIFont systemFontOfSize:11];
    [self.contentView addSubview:earnTitle];
    [earnTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(9);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *earnValue = [[UILabel alloc] init];
    _earnValue = earnValue;
    earnValue.text = @"+ ¥1.26";
    earnValue.textColor = [UIColor jk_colorWithHexString:@"#e32828"];
    earnValue.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:earnValue];
    [earnValue mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnTitle.mas_right).offset(0);
        make.top.mas_offset(9);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *createTimeLabel = [[UILabel alloc] init];
    _createTime = createTimeLabel;
    createTimeLabel.text = @"创建日期 2019-02-04 18:30";
    createTimeLabel.textColor = [UIColor jk_colorWithHexString:@"#B3B3B3"];
    createTimeLabel.font = [UIFont systemFontOfSize:9];
    createTimeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:createTimeLabel];
    [createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.top.mas_offset(10);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *orderNumberLabel = [[UILabel alloc] init];
    _orderNumber = orderNumberLabel;
    orderNumberLabel.text = @"订单编号:201902271199002201902271199002";
    orderNumberLabel.textColor = [UIColor jk_colorWithHexString:@"#B3B3B3"];
    orderNumberLabel.font = [UIFont systemFontOfSize:9];
    [self.contentView addSubview:orderNumberLabel];
    [orderNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnTitle.mas_left).offset(0);
        make.bottom.mas_offset(-8);
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(13);
    }];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    copyButton.titleLabel.font = [UIFont systemFontOfSize:8];
    [copyButton setTitle:@"复制" forState:UIControlStateNormal];
    [copyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    copyButton.backgroundColor = [UIColor jk_colorWithHexString:@"#E32828"];
    copyButton.layer.cornerRadius = 7;
    copyButton.clipsToBounds = YES;
    [self addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-16);
        make.bottom.mas_offset(-9);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(14);
    }];
    weakify(self)
    [copyButton jk_addActionHandler:^(NSInteger tag) {
        [self makeToast:@"订单号复制成功" duration:1.0 position:CSToastPositionCenter];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = weak_self.record.alipay_order_id;
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.right.mas_offset(0);
        make.bottom.mas_offset(-0.5);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)updateContentWithModel:(HJDrawalRecordModel *)model {
    _record = model;
    _orderNumber.text = [NSString stringWithFormat:@"订单编号:%@",model.alipay_order_id];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.createtime];
    NSString *dateStr = [date jk_formatWithTimeZoneWithoutTime:[NSTimeZone localTimeZone]];
    _createTime.text = [NSString stringWithFormat:@"创建日期 %@",dateStr];
    _earnValue.text = [NSString stringWithFormat:@"+ ¥%@",model.money];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
