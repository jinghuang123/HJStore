//
//  HJShareMainImageView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareMainImageView.h"
@interface HJShareMainImageView ()
@property (nonatomic,strong) HJProductDetailModel *detail;
@end



@implementation HJShareMainImageView

- (instancetype)initWithFrame:(CGRect)frame andDetailModel:(HJProductDetailModel *)detail {
    if (self = [super initWithFrame:frame]) {
        self.detail = detail;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

@end
