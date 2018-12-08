//
//  HJMainGridSectionFootView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/3.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainGridSectionFootView.h"
#import <FLAnimatedImageView.h>
#import <FLAnimatedImage.h>
#import <UIImage+GIF.h>

@interface HJMainGridSectionFootView ()

/* 顶部广告宣传图片 */
@property (strong , nonatomic) UIImageView *topAdImageView;


@property (strong , nonatomic) UIView *bottomLineView;

@end

@implementation HJMainGridSectionFootView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _topAdImageView = [[UIImageView alloc] init];
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:HomeBottomViewGIFImage]];
    UIImage *gifImage = [UIImage sd_animatedGIFWithData:data];
    _topAdImageView.image = gifImage;
    _topAdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_topAdImageView];

    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.jk_height - 8, MaxWidth, 8);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_topAdImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.width.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-8);
    }];
}
@end
