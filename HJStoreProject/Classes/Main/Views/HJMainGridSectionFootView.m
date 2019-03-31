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
#import "SGAdvertScrollView.h"

@interface HJMainGridSectionFootView () <SGAdvertScrollViewDelegate>

@property (strong , nonatomic) UIView *bottomLineView;


@property (strong, nonatomic) SGAdvertScrollView *advertScrollView;

@end

@implementation HJMainGridSectionFootView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    
    UIImageView *preIcon = [[UIImageView alloc] init];
    preIcon.image = [UIImage imageNamed:@"ic_home_headmsg"];
    [self addSubview:preIcon];
    [preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.width.mas_equalTo(56);
        make.height.mas_equalTo(16);
        make.top.mas_offset(5);
    }];
    
    self.backgroundColor = [UIColor whiteColor];
    _advertScrollView = [[SGAdvertScrollView alloc] init];
    _advertScrollView.delegate = self;
    [self addSubview:_advertScrollView];
    
    _advertScrollView.signImages = @[@"", @"", @""];
    _advertScrollView.titles = self.titles;
    _advertScrollView.textAlignment = NSTextAlignmentCenter;

    
    _bottomLineView = [[UIView alloc] init];
    _bottomLineView.backgroundColor = [UIColor clearColor];
    [self addSubview:_bottomLineView];
    _bottomLineView.frame = CGRectMake(0, self.jk_height - 8, MaxWidth, 8);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [_advertScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(60);
        make.right.top.mas_offset(0);
        make.bottom.mas_offset(-1);
    }];
}

- (void)setTitles:(NSArray *)titles {
    _titles = titles;
    _advertScrollView.titles = titles;
    NSMutableArray *images = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < titles.count; i++) {
        [images addObject:@""];
    }
    _advertScrollView.signImages = images;
}

/// 代理方法
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    if (self.rollingDidSelected) {
        self.rollingDidSelected(index);
    }
}
@end
