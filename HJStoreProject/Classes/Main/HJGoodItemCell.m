//
//  HJGoodItemCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJGoodItemCell.h"

@interface HJGoodItemCell ()

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

#define cellSize (MaxWidth - 15)/2


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
    
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR15Font;
    [self addSubview:_priceLabel];
    
    _couponIcon = [[UIImageView alloc] init];
    [self addSubview:_couponIcon];
    
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
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(10);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(weak_self.goodsImageView.mas_bottom).offset(10);
    }];
    
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.mas_equalTo(weak_self.goodsLabel.mas_bottom).offset(5);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(15);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.right.mas_offset(-5);
        make.bottom.mas_offset(-5);
    }];
    
    [_soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.width.mas_equalTo(120);
        make.centerY.mas_equalTo(_priceLabel.mas_centerY).offset(0);
    }];
    

}

- (void)setItemCellWithItem:(HJRecommendModel *)item {
    [_goodsImageView sd_setImageWithURLString:item.image placeholderImage:[UIImage imageNamed:@"list_holder"]];
    _priceLabel.text = [NSString stringWithFormat:@"%@ %@",item.rebate_price,item.price];
    //3.初始化NSTextAttachment对象
    [_preIcon sd_setImageWithURLString:item.stote_logo placeholderImage:[UIImage imageNamed:@"default_160"]];
    [_couponIcon sd_setImageWithURLString:item.coupon placeholderImage:[UIImage imageNamed:@"list_holder"]];
    _soldCountLabel.text = [NSString stringWithFormat:@"已售%ld",item.sold_count];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 25.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _goodsLabel.attributedText = attributedString;
    
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",_priceLabel.text]];
    [newPriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(newPriceString.length - item.price.length, item.price.length)];
    
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, 1)];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(newPriceString.length - item.price.length, item.price.length)];
    [newPriceString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(newPriceString.length - item.price.length, item.price.length)];
    _priceLabel.attributedText = newPriceString;

}


@end
