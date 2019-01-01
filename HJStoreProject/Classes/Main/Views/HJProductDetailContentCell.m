//
//  HJProductDetailContentCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJProductDetailContentCell.h"

@interface HJProductDetailContentCell ()
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *preIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *soldCountLabel;
@property (nonatomic, strong) UILabel *earningLabel;
@end

@implementation HJProductDetailContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    tip.layer.cornerRadius = 10;
    tip.textAlignment = NSTextAlignmentCenter;
    tip.clipsToBounds = YES;
    tip.textColor = [UIColor whiteColor];
    tip.text = @"券后价";
    tip.font = PFR10Font;
    tip.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(20);
    }];
    
    
    UILabel *priceLabel = [[UILabel alloc] init];
    _priceLabel = priceLabel;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = PFR18Font;
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tip.mas_right).offset(10);
        make.centerY.mas_equalTo(tip.mas_centerY).offset(0);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(25);
    }];
    
    UIImageView *preIcon = [[UIImageView alloc] init];
    _preIcon = preIcon;
    [self.contentView addSubview:preIcon];
    [preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tip.mas_bottom).offset(15);
        make.left.mas_equalTo(tip.mas_left).offset(0);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(15);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    titleLabel.numberOfLines = 0;
    titleLabel.font = PFR15Font;
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(tip.mas_bottom).offset(10);
        make.left.mas_equalTo(tip.mas_left).offset(0);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(50);
    }];
    
    UILabel *soldCountLabel =  [[UILabel alloc] init];
    _soldCountLabel = soldCountLabel;
    soldCountLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    soldCountLabel.font = [UIFont systemFontOfSize:13];
    soldCountLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:soldCountLabel];
    [soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tip.mas_left).offset(0);
        make.width.mas_equalTo(120);
        make.bottom.mas_offset(-5);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"AppIcon"] forState:UIControlStateNormal];
    [collectionBtn addTarget:self action:@selector(collectionAction) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:collectionBtn];
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.height.mas_equalTo(30);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(-10);
    }];
    
    UILabel *earningLabel =  [[UILabel alloc] init];
    _earningLabel = earningLabel;
    earningLabel.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.3];
    earningLabel.textColor = [UIColor redColor];
    earningLabel.font = [UIFont systemFontOfSize:13];
    earningLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:earningLabel];
    [earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.mas_equalTo(160);
        make.bottom.mas_offset(-5);
        make.height.mas_equalTo(20);
    }];
}

- (void)setcontentWithModel:(HJProductDetailModel *)item {
    NSString *type = item.user_type == 1 ? @"天猫价" : @"淘宝价";
    _priceLabel.text = [NSString stringWithFormat:@"%@   %@:%@",item.zk_final_price,type,item.reserve_price];
    //3.初始化NSTextAttachment对象
    [_preIcon sd_setImageWithURLString:item.pict_url_image placeholderImage:[UIImage imageNamed:@"default_160"]];
    _soldCountLabel.text = [NSString stringWithFormat:@"已售%ld",item.volume];
    _earningLabel.text = @"预估收益1.53～5.32";
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 35.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _titleLabel.attributedText = attributedString;
    
    
    NSInteger final_price_length = item.zk_final_price.length + 1;
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",_priceLabel.text]];
    
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(1, final_price_length)];

    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(final_price_length, newPriceString.length - final_price_length)];
    [newPriceString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(final_price_length, newPriceString.length - final_price_length)];
    _priceLabel.attributedText = newPriceString;
}

- (void)collectionAction {
    NSLog(@"collectionAction");
    if (self.collectionSaveBlock) {
        self.collectionSaveBlock(nil);
    }
}
@end
