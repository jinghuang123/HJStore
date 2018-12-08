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


#define itemsize  MaxWidth == ENM_SCREEN_W_5S ? 38 : 45

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
    _gridLabel.font = PFR13Font;
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

- (void)updeteCellWithGridItem:(HJGridItem *)gridItem {
    _gridLabel.text = gridItem.gridTitle;
    if (gridItem.iconImage.length == 0) return;
    if ([[gridItem.iconImage substringToIndex:4] isEqualToString:@"http"]) {
        [_gridImageView sd_setImageWithURL:[NSURL URLWithString:gridItem.iconImage]placeholderImage:[UIImage imageNamed:@"default_49_11"]];
    }else{
        _gridImageView.image = [UIImage imageNamed:gridItem.iconImage];
    }
}
@end
