//
//  HJShareCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareCell.h"


@interface HJShareCell ()
@property (nonatomic,strong) UILabel *topTipLabel;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *couponLabel;
@property (nonatomic,strong) UILabel *downloadTipLabel;
@property (nonatomic,strong) UILabel *tipCopyLabel;
@property (nonatomic,strong) UILabel *showCouponLabel;
@end


@implementation HJShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *topTip = [[UILabel alloc] init];
    _topTipLabel = topTip;
    topTip.backgroundColor = [UIColor redColor];
    topTip.textColor = [UIColor whiteColor];
    topTip.text = @"    奖励收益预估 ¥3.24";
    topTip.font = PFR12Font;
    [self.contentView addSubview:topTip];
    
    UILabel *titleLab = [[UILabel alloc] init];
    _titleLab = titleLab;
    titleLab.textColor = [UIColor blackColor];
    titleLab.jk_edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    titleLab.font = PFR13Font;
    titleLab.numberOfLines = 3;
    titleLab.text = @"你妹的杨帆，你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹妹你妹你妹你妹你妹";
    [self.contentView addSubview:titleLab];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    _priceLabel = priceLabel;
    priceLabel.text = @"【在售价】 22.32元";
    priceLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    priceLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    priceLabel.font = PFR13Font;
    [self.contentView addSubview:priceLabel];
    
    UILabel *couponLabel = [[UILabel alloc] init];
    _couponLabel = couponLabel;
    couponLabel.text = @"【券后价】 17.32元";
    couponLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    couponLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    couponLabel.font = PFR13Font;
    [self.contentView addSubview:couponLabel];
    UILabel *downloadTipLabel = [[UILabel alloc] init];
    _downloadTipLabel = downloadTipLabel;
    downloadTipLabel.text = @"【下载花生日记再省】 3.00元";
    downloadTipLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    downloadTipLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    downloadTipLabel.font = PFR13Font;
    [self.contentView addSubview:downloadTipLabel];

    
    UILabel *tipCopyLabel = [[UILabel alloc] init];
    _tipCopyLabel = tipCopyLabel;
    tipCopyLabel.text = @"下载这条信息¥nmddeQDdsWjpdxd¥,\n打开【手机淘宝】即可查看";
    tipCopyLabel.numberOfLines = 2;
    tipCopyLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    tipCopyLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    tipCopyLabel.font = PFR13Font;
    [self.contentView addSubview:tipCopyLabel];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.text = @"----------";
    lineLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    lineLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    lineLabel.font = PFR13Font;
    [self.contentView addSubview:lineLabel];
    
   
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    [self.contentView addSubview:lineView];
    
    UILabel *showCouponLabel = [[UILabel alloc] init];
    _showCouponLabel = showCouponLabel;
    showCouponLabel.text = @"显示花生日记收益";
    showCouponLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 35, 0, 10);
    showCouponLabel.textColor = [UIColor redColor];
    showCouponLabel.font = PFR12Font;
    [self.contentView addSubview:showCouponLabel];
    
    [topTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(30);
    }];
    CGFloat h = [titleLab.text jk_heightWithFont:titleLab.font constrainedToWidth:MaxWidth - 20];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(topTip.mas_bottom).offset(0);
        make.height.mas_equalTo(h + 25);
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(0);
        make.height.mas_equalTo(15);
    }];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(15);
    }];
    [downloadTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(couponLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(15);
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(downloadTipLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    [tipCopyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-30);
        make.height.mas_equalTo(0.5);
    }];
    
    [showCouponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(8);
        make.height.mas_equalTo(15);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
