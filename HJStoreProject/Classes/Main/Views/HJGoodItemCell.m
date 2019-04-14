//
//  HJGoodItemCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJGoodItemCell.h"

#define cellSize (MaxWidth - 15)/2

@interface HJGoodItemCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;

/* 价格 */
@property (strong , nonatomic)UILabel *nowPriceLabel;

/* 价格 */
@property (strong , nonatomic)UILabel *finalPriceLabel;

/* 销售量 */
@property (strong , nonatomic)UILabel *soldCountLabel;

@property (strong , nonatomic)UIImageView *preIcon;
@property (strong , nonatomic)UIImageView *couponIcon;
@property (strong , nonatomic)UILabel *couponLabel;

@property (strong , nonatomic) UILabel *earningLabel;
@end




@implementation HJGoodItemCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_goodsImageView];
    

    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR12Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _preIcon = [[UIImageView alloc] init];
    [self addSubview:_preIcon];
    
    
    _nowPriceLabel = [[UILabel alloc] init];
    _nowPriceLabel.textAlignment = NSTextAlignmentLeft;
    _nowPriceLabel.textColor = [UIColor grayColor];
    _nowPriceLabel.font = PFR8Font;
    [self addSubview:_nowPriceLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentLeft;
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR12Font;
    [self addSubview:_priceLabel];
    

    
    
    _couponIcon = [[UIImageView alloc] init];
    [self addSubview:_couponIcon];
    
    _couponLabel = [[UILabel alloc] init];
    _couponLabel.font = [UIFont systemFontOfSize:9];
    _couponLabel.textColor = [UIColor redColor];
    _couponLabel.textAlignment = NSTextAlignmentCenter;
    [_couponIcon addSubview:_couponLabel];
    
    _earningLabel =  [[UILabel alloc] init];
    _earningLabel.backgroundColor = [UIColor jk_colorWithHexString:@"#E32828"];
    _earningLabel.textColor = [UIColor whiteColor];
    _earningLabel.layer.cornerRadius = 8;
    _earningLabel.clipsToBounds = YES;
    _earningLabel.font = [UIFont systemFontOfSize:10];
    _earningLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_earningLabel];

    
    _soldCountLabel =  [[UILabel alloc] init];
    _soldCountLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    _soldCountLabel.font = [UIFont systemFontOfSize:11];
    _soldCountLabel.textAlignment = NSTextAlignmentRight;
    [self addSubview:_soldCountLabel];
    
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    weakify(self)
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(0);
        make.width.height.mas_equalTo(cellSize);
    }];
    
    [_preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.mas_equalTo(weak_self.goodsImageView.mas_bottom).offset(15);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(weak_self.goodsImageView.mas_bottom).offset(10);
    }];
    
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.mas_equalTo(weak_self.goodsLabel.mas_bottom).offset(2);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(19);
    }];
    
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(10);
    }];
    
    [_earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.width.mas_equalTo(65);
        make.top.mas_equalTo(weak_self.couponIcon.mas_top).offset(0);
        make.height.mas_equalTo(16);
    }];
    
    
    [_nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(0);
        make.top.mas_equalTo(weak_self.couponIcon.mas_bottom).offset(5);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(0);
        make.top.mas_equalTo(weak_self.nowPriceLabel.mas_bottom).offset(5);
    }];

    
    [_soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.width.mas_equalTo(120);
        make.centerY.mas_equalTo(weak_self.priceLabel.mas_centerY).offset(0);
    }];
    

}

- (void)setItemCellWithItem:(HJRecommendModel *)item {
    [_goodsImageView sd_setImageWithURLString:item.pict_url placeholderImage:PLACEHOLDER_ITEM];
    _priceLabel.text = [NSString stringWithFormat:@"券后 ¥%.2f",item.coupon_after_price];
    _nowPriceLabel.text = item.zk_final_price;
    //3.初始化NSTextAttachment对象
    if(item.user_type == 0) {
        _preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        _preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }
    _earningLabel.text = [NSString stringWithFormat:@"赚%.2f",item.earning];
    [_couponIcon setImage:[UIImage imageNamed:@"CouponIcon"]];
    _couponLabel.text = [NSString stringWithFormat:@"¥%ld",[item.coupon_amount integerValue]];
    
    _soldCountLabel.text = [NSString stringWithFormat:@"销量 %ld",item.volume];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 20.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _goodsLabel.attributedText = attributedString;
    
    
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_priceLabel.text]];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 2)];
    _priceLabel.attributedText = newPriceString;
    
    NSMutableAttributedString *currentPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"现价 %@",_nowPriceLabel.text]];
    [currentPriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, currentPriceString.length - 3)];
    _nowPriceLabel.attributedText = currentPriceString;
    
    if(!item.coupon_amount) {
        _couponIcon.hidden = YES;
        _nowPriceLabel.hidden = YES;
        _priceLabel.text = [NSString stringWithFormat:@"现价 ¥%.2f",item.coupon_after_price];
    }

}
@end



///////////////////////////////////////////////////////////////////


@interface HJGoodItemSingleCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *nowPriceLabel;

/* 销售量 */
@property (strong , nonatomic)UILabel *soldCountLabel;

@property (strong , nonatomic)UIImageView *preIcon;
@property (strong , nonatomic)UIImageView *couponIcon;
@property (strong , nonatomic)UILabel *couponLabel;

@property (strong , nonatomic) UILabel *earningLabel;

@end


@implementation HJGoodItemSingleCell



- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
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
    [self.contentView addSubview:_goodsImageView];
    
    
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR14Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_goodsLabel];
    
    _preIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_preIcon];
    
    
    _nowPriceLabel = [[UILabel alloc] init];
    _nowPriceLabel.textAlignment = NSTextAlignmentLeft;
    _nowPriceLabel.textColor = [UIColor grayColor];
    _nowPriceLabel.font = PFR8Font;
    [self.contentView addSubview:_nowPriceLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR12Font;
    [self addSubview:_priceLabel];
    
    _couponIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_couponIcon];
    
    _couponLabel = [[UILabel alloc] init];
    _couponLabel.font = [UIFont systemFontOfSize:9];
    _couponLabel.textAlignment = NSTextAlignmentCenter;
    _couponLabel.textColor = [UIColor redColor];
    [_couponIcon addSubview:_couponLabel];
    
    _earningLabel =  [[UILabel alloc] init];
    _earningLabel.backgroundColor = [UIColor jk_colorWithHexString:@"#E32828"];
    _earningLabel.textColor = [UIColor whiteColor];
    _earningLabel.layer.cornerRadius = 8;
    _earningLabel.clipsToBounds = YES;
    _earningLabel.font = [UIFont systemFontOfSize:10];
    _earningLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_earningLabel];
    
    _soldCountLabel =  [[UILabel alloc] init];
    _soldCountLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    _soldCountLabel.font = [UIFont systemFontOfSize:9];
    _soldCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_soldCountLabel];
    
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
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.top.mas_offset(18);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.top.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.goodsLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(19);
    }];
    
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(10);
    }];
    
    [_earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_equalTo(80);
        make.top.mas_equalTo(weak_self.couponIcon.mas_top).offset(0);
        make.height.mas_equalTo(15);
    }];
    
    [_nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.couponIcon.mas_left).offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(weak_self.couponIcon.mas_bottom).offset(10);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weak_self.nowPriceLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [_soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(weak_self.nowPriceLabel.mas_bottom).offset(10);
    }];
}


- (void)setItemCellWithItem:(HJRecommendModel *)item {
    [_goodsImageView sd_setImageWithURLString:item.pict_url placeholderImage:PLACEHOLDER_ITEM];
    _priceLabel.text = [NSString stringWithFormat:@"券后 ¥%.2f",item.coupon_after_price];
    _nowPriceLabel.text = item.zk_final_price;
    //3.初始化NSTextAttachment对象
    if(item.user_type == 0) {
        _preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        _preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }

    
    [_couponIcon setImage:[UIImage imageNamed:@"CouponIcon"]];
    _couponLabel.text = [NSString stringWithFormat:@"¥ %ld",[item.coupon_amount integerValue]];
    _earningLabel.text = [NSString stringWithFormat:@"赚 %.2f",item.earning];
    _soldCountLabel.text = [NSString stringWithFormat:@"销量 %ld",item.volume];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 20.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _goodsLabel.attributedText = attributedString;
    
    
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_priceLabel.text]];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 2)];
    _priceLabel.attributedText = newPriceString;
    
    NSMutableAttributedString *currentPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"现价 %@",_nowPriceLabel.text]];
    [currentPriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, currentPriceString.length - 3)];
    _nowPriceLabel.attributedText = currentPriceString;
    
    if(!item.coupon_amount) {
        _couponIcon.hidden = YES;
        _nowPriceLabel.hidden = YES;
        _priceLabel.text = [NSString stringWithFormat:@"现价 ¥%.2f",item.coupon_after_price];
    }
}



@end
