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

@end

#define cellSize MaxWidth/2 - 50


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
    _goodsImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_goodsImageView];
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR12Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:_goodsLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR15Font;
    [self addSubview:_priceLabel];
    
    _sameButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _sameButton.titleLabel.font = PFR10Font;
    _sameButton.layer.cornerRadius = 0;
    _sameButton.layer.borderWidth = 1;
    _sameButton.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _sameButton.clipsToBounds = YES;
    [_sameButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [_sameButton setTitle:@"看相似" forState:UIControlStateNormal];
    [_sameButton addTarget:self action:@selector(lookSameGoods) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_sameButton];
}

#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    weakify(self)
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(10);
        make.width.height.mas_equalTo(cellSize);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(self).multipliedBy(0.8);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(weak_self.goodsImageView.mas_bottom).offset(10);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView);
        make.width.mas_equalTo(self).multipliedBy(0.5);
        make.top.mas_equalTo(weak_self.goodsLabel.mas_bottom);
        
    }];
    
    [_sameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-10);
        make.centerY.mas_equalTo(weak_self.priceLabel);
        make.size.mas_equalTo(CGSizeMake(35, 18));
    }];
}

- (void)setItemCellWithItem:(HJRecommendItem *)item {
    [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:item.image_url]];
    _priceLabel.text = [NSString stringWithFormat:@"¥ %.2f",[item.price floatValue]];
    _goodsLabel.text = item.main_title;
}

- (void)lookSameGoods {
    if(self.lookSameBlock){
        self.lookSameBlock();
    }
}

@end
