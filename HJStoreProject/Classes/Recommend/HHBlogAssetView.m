//
//  HHBlogAssetView.m
//  Smartpaw
//
//  Created by zhangxq on 2017/8/18.
//  Copyright © 2017年 hihisoft. All rights reserved.
//

#import "HHBlogAssetView.h"
#import <Masonry.h>

@interface HHBlogAssetView()
@property (strong, nonatomic) UIImageView *videoIcon;
@end

@implementation HHBlogAssetView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI {

    self.contentMode =  UIViewContentModeScaleAspectFill;
    self.clipsToBounds = YES;
    _videoIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mon_icon_n"]];
    _videoIcon.hidden = YES;
    [self addSubview:_videoIcon];
    [_videoIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
}
@end
