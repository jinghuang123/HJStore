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
@property (nonatomic, strong) UILabel *storeName;
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
        make.height.mas_equalTo(17);
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
        make.bottom.mas_offset(-35);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"collected_n"] forState:UIControlStateNormal];
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
        make.bottom.mas_offset(-35);
        make.height.mas_equalTo(20);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.2];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.mas_equalTo(10);
        make.bottom.mas_offset(-30);
        make.height.mas_equalTo(0.5);
    }];
    
    UILabel *storeName = [[UILabel alloc] init];
    _storeName = storeName;
    storeName.textColor = [UIColor blackColor];
    storeName.font = PFR13Font;
    [self.contentView addSubview:storeName];
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(7);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)setcontentWithModel:(HJProductDetailModel *)item {
    NSString *type = item.user_type == 1 ? @"天猫价" : @"淘宝价";
    CGFloat final_value = [item.zk_final_price floatValue];
    CGFloat couponValue = [item.coupon_value floatValue];
    NSString *value = [NSString stringWithFormat:@"%.2f", final_value - couponValue];
    _priceLabel.text = [NSString stringWithFormat:@"%@   %@:%@",value,type,item.reserve_price];
    //3.初始化NSTextAttachment对象
    if(item.user_type == 0) {
        _preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        _preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }
    _soldCountLabel.text = [NSString stringWithFormat:@"已售%ld",item.volume];
    _earningLabel.text = [NSString stringWithFormat:@"预估收益%.2f",item.earning];
    _storeName.text = item.nick;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 35.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _titleLabel.attributedText = attributedString;
    


    
    
    NSInteger final_price_length = value.length + 1;
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


@implementation HJProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = RGB(245, 245, 245);;
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-5);
    }];
    UILabel *titleTip = [[UILabel alloc] init];
    titleTip.text = @"查看商品详情";
    titleTip.font = PFR14Font;
    titleTip.textColor = [UIColor blackColor];
    [contentV addSubview:titleTip];
    [titleTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_equalTo(contentV.mas_centerY).offset(0);
        make.height.mas_equalTo(20);
    }];
}

@end


@implementation HJProductDetailTipCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}




- (void)setUpUI {
    self.contentView.backgroundColor = RGB(245, 245, 245);;
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor redColor];
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.text = @"猜你喜欢";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor redColor];
    
    
    [self.contentView addSubview:leftView];
    [self.contentView addSubview:rightView];
    [self.contentView addSubview:tipLabel];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(tipLabel.mas_left).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(tipLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_equalTo(25);
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
}

@end


@interface HJGoodItemsSingleCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

/* 销售量 */
@property (strong , nonatomic)UILabel *soldCountLabel;

@property (strong , nonatomic)UIImageView *preIcon;
@property (strong , nonatomic)UIImageView *couponIcon;
@end


@implementation HJGoodItemsSingleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}




- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.layer.cornerRadius = 5;
    _goodsImageView.clipsToBounds = YES;
    _goodsImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_goodsImageView];
    
    
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR14Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _preIcon = [[UIImageView alloc] init];
    [self addSubview:_preIcon];
    
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR16Font;
    [self addSubview:_priceLabel];
    
    _couponIcon = [[UIImageView alloc] init];
    [self addSubview:_couponIcon];
    
    _soldCountLabel =  [[UILabel alloc] init];
    _soldCountLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    _soldCountLabel.font = [UIFont systemFontOfSize:13];
    _soldCountLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_soldCountLabel];
    
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    weakify(self)
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.mas_offset(5);
        make.width.height.mas_equalTo(140);
    }];
    
    [_preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(10);
        make.top.mas_offset(20);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(13);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(10);
        make.top.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(10);
        make.bottom.mas_offset(-10);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(10);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weak_self.goodsLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [_soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(10);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(weak_self.priceLabel.mas_bottom).offset(10);
    }];
}


- (void)setItemCellWithItem:(HJRecommendModel *)item {
    [_goodsImageView sd_setImageWithURLString:item.pict_url_image placeholderImage:[UIImage imageNamed:@"list_holder"]];
    NSString *type = item.user_type == 1 ? @"天猫价" : @"淘宝价";
    _priceLabel.text = [NSString stringWithFormat:@"%@ %@:%@",item.zk_final_price,type,item.reserve_price];
    //3.初始化NSTextAttachment对象
    if(item.user_type == 0) {
        _preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        _preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }
    [_couponIcon sd_setImageWithURLString:item.pict_url_image placeholderImage:[UIImage imageNamed:@"list_holder"]];
    _soldCountLabel.text = [NSString stringWithFormat:@"已售%ld",item.volume];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 25.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _goodsLabel.attributedText = attributedString;
    
    
    NSInteger final_price_length = item.zk_final_price.length + 1;
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",_priceLabel.text]];
    
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 1)];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(final_price_length, newPriceString.length - final_price_length)];
    [newPriceString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(final_price_length, newPriceString.length - final_price_length)];
    _priceLabel.attributedText = newPriceString;
}
@end
