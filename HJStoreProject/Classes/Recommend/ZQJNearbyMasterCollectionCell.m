//
//  ZQJNearbyMasterCollectionCell.m
//  易裁衣
//
//  Created by UT—ZQJ on 2017/3/28.
//  Copyright © 2017年 UT—ZQJ. All rights reserved.
//

#import "ZQJNearbyMasterCollectionCell.h"

@interface ZQJNearbyMasterCollectionCell ()



@end

@implementation ZQJNearbyMasterCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.imgV = [UIImageView new];
    [self.contentView addSubview:self.imgV];
    self.imgV.backgroundColor = [UIColor redColor];
    [self.imgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UILabel *couponvalueLabel = [[UILabel alloc] init];
    _couponvalueLabel = couponvalueLabel;
    couponvalueLabel.textColor = [UIColor whiteColor];
    couponvalueLabel.textAlignment = NSTextAlignmentCenter;
    couponvalueLabel.font = [UIFont systemFontOfSize:12];
    couponvalueLabel.backgroundColor = [UIColor redColor];
    [self.imgV addSubview:couponvalueLabel];
    [couponvalueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(20);
    }];
}

@end
