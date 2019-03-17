//
//  HJMainSliderCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainSliderCell.h"
#import <SDCycleScrollView.h>
#import "HJBannerModel.h"


@interface HJMainSliderView ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic) SDCycleScrollView *cycleScrollView;


@end


@implementation HJMainSliderView



- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.jk_width, self.jk_height) delegate:self placeholderImage:PLACEHOLDER_SCRO_ITEM];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.backgroundColor = [UIColor clearColor];
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    [self addSubview:_cycleScrollView];
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray {
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = PLACEHOLDER_SCRO_ITEM;
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    HJBannerModel *banner = [self.bannerItems objectAtIndex:index];
    if (self.bannerCellItemClick) {
        self.bannerCellItemClick(banner);
    }
}

@end




@interface HJMainSliderCell ()<SDCycleScrollViewDelegate>

/* 轮播图 */
@property (strong , nonatomic) SDCycleScrollView *cycleScrollView;


@end

@implementation HJMainSliderCell
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, self.jk_width, self.jk_height) delegate:self placeholderImage:PLACEHOLDER_SCRO_ITEM];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    [self addSubview:_cycleScrollView];
}

- (void)setImageGroupArray:(NSArray *)imageGroupArray {
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = PLACEHOLDER_SCRO_ITEM;
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;
}

#pragma mark - 点击图片Bannar跳转
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"点击了%zd轮播图",index);
    HJBannerModel *banner = [self.bannerItems objectAtIndex:index];
    if (self.bannerCellItemClick) {
        self.bannerCellItemClick(banner);
    }
}
@end
