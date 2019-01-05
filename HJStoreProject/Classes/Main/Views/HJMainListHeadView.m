//
//  HJMainListHeadView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMainListHeadView.h"

@implementation HJMainListHeadView

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor redColor];
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.font = [UIFont systemFontOfSize:15];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor redColor];
    
    
    [self addSubview:leftView];
    [self addSubview:rightView];
    [self addSubview:tipLabel];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(120);
        make.height.mas_equalTo(25);
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(tipLabel.mas_left).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(tipLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"为你推荐"];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 25.f; // 首行缩进
    tipLabel.attributedText = attributedString;
}

@end


@implementation HJMainListHeadViewList
- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *view1 = [self createViewWithTitle:@"综合" icon:@"shouye_icon_scan_white" iconSize:CGSizeMake(10, 10)];
    [self addSubview:view1];
    UIView *view2 = [self createViewWithTitle:@"券后价" icon:@"shouye_icon_scan_white" iconSize:CGSizeMake(10, 10)];
    [self addSubview:view2];
    UIView *view3 = [self createViewWithTitle:@"销量" icon:@"shouye_icon_scan_white" iconSize:CGSizeMake(10, 10)];
    [self addSubview:view3];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.mas_equalTo((MaxWidth - 60)/3);
        make.height.mas_equalTo(40);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(view1.mas_right).offset(0);
        make.width.mas_equalTo((MaxWidth - 60)/3);
        make.height.mas_equalTo(40);
    }];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(view2.mas_right).offset(0);
        make.width.mas_equalTo((MaxWidth - 60)/3);
        make.height.mas_equalTo(40);
    }];
    
    [view1 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.sortTypeChengBlock) {
            self.sortTypeChengBlock(@(0));
        }
    }];
    [view2 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.sortTypeChengBlock) {
            self.sortTypeChengBlock(@(1));
        }
    }];
    [view3 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.sortTypeChengBlock) {
            self.sortTypeChengBlock(@(2));
        }
    }];
    
    UIButton *rightBtn = [[UIButton alloc] init];
    _rightBtn = rightBtn;
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_liebiao"] forState:UIControlStateNormal];
    [self addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(showModeChange) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(10);
        make.width.height.mas_equalTo(40);
    }];
    
}

- (UIView *)createViewWithTitle:(NSString *)title icon:(NSString *)icon iconSize:(CGSize)size{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (MaxWidth - 60)/3, 40)];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.text = title;
    label.font = PFR12Font;
    label.textColor = [UIColor lightGrayColor];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX).offset(15);
        make.centerY.mas_equalTo(view.mas_centerY).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(50);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:icon];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(5);
        make.centerY.mas_equalTo(label.mas_centerY).offset(0);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    
    return view;
}


- (void)showModeChange {
    if (self.showModeChangedBlock) {
        self.showModeChangedBlock(nil);
    }
}
@end
