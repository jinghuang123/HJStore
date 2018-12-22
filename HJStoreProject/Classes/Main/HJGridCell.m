//
//  HJGridCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJGridCell.h"


@interface HJGridCell ()

/* imageView */
@property (strong , nonatomic)UIImageView *gridImageView;
/* gridLabel */
@property (strong , nonatomic)UILabel *gridLabel;


@end



@implementation HJGridCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    _gridImageView = [[UIImageView alloc] init];
    _gridImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_gridImageView];
    
    _gridLabel = [[UILabel alloc] init];
    _gridLabel.font = PFR12Font;
    _gridLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    _gridLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_gridLabel];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_gridImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.width.height.mas_equalTo(itemsize);
        make.centerX.mas_equalTo(self);
    }];
    
    [_gridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_gridImageView.mas_bottom).offset(5);
    }];

    
}

- (void)updeteCellWithGridItem:(HJSubCategoryModel *)category {
    _gridLabel.text = category.name;
    if (category.image.length == 0) return;
    [_gridImageView sd_setImageWithURLString:category.image placeholderImage:[UIImage imageNamed:@"default_49_11"]];
}

- (void)updeteCellWithActivityItem:(HJActivityModel *)activity {
    _gridLabel.text = activity.name;
    if (activity.pic_image.length == 0) return;
    [_gridImageView sd_setImageWithURLString:activity.pic_image placeholderImage:[UIImage imageNamed:@"default_49_11"]];
}
@end
