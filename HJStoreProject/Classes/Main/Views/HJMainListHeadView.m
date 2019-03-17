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
    
    UIImageView *supportImageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"supportTipImage"]];
    [self addSubview:supportImageview];
    [supportImageview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_offset(212);
        make.height.mas_equalTo(24);
    }];
}

@end

@implementation HJSortIcon

- (instancetype)initWithTitle:(NSString *)title{
    if (self = [super init]) {
        [self makeUI:title];
    }
    return self;
}

- (void)makeUI:(NSString *)title {
    UILabel *label = [[UILabel alloc] init];
    _sortTitle = label;
    [self addSubview:label];
    label.font = PFR14Font;
    label.text = title;
    label.textColor = [UIColor lightGrayColor];
    CGFloat wid = [NSString widthOfString:title font:label.font height:20] + 5;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_centerX).offset(15);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(wid);
    }];

    UIImageView *imageView = [[UIImageView alloc] init];
    _sortImageView = imageView;
    imageView.image = [UIImage imageNamed:@"sortType_nomal"];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(0);
        make.centerY.mas_equalTo(label.mas_centerY).offset(0);
        make.width.mas_equalTo(7);
        make.height.mas_equalTo(14);
    }];
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
    NSString *view1Title = @"综合";
    NSString *view2Title = @"券后价";
    NSString *view3Title = @"销量";
    HJSortIcon *view1 = [[HJSortIcon alloc] initWithTitle:view1Title]; //  [self  createViewWithTitle:@"综合" icon:@"SortDown" iconSize:CGSizeMake(7, 5)];
    _view1 = view1;
    [self addSubview:view1];
    HJSortIcon *view2 = [[HJSortIcon alloc] initWithTitle:view2Title];//[self createViewWithTitle:@"券后价" icon:@"sortType_nomal" iconSize:CGSizeMake(7, 14)];
    _view2 = view2;
    [self addSubview:view2];
    HJSortIcon *view3 = [[HJSortIcon alloc] initWithTitle:view3Title];
    _view3 = view3;
    [self addSubview:view3];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(0);
        make.width.mas_equalTo((MaxWidth - 80)/3);
        make.height.mas_equalTo(40);
    }];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(view1.mas_right).offset(0);
        make.width.mas_equalTo((MaxWidth - 80)/3);
        make.height.mas_equalTo(40);
    }];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_equalTo(view2.mas_right).offset(0);
        make.width.mas_equalTo((MaxWidth - 80)/3);
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
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"icon_wangge"] forState:UIControlStateNormal];

    [self addSubview:rightBtn];
    [rightBtn addTarget:self action:@selector(showModeChange) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.mas_offset(-20);
        make.width.height.mas_equalTo(20);
    }];
    if(self.frame.size.height > 40){
        [self addViewToBottom];
    }
}

- (UIView *)createViewWithTitle:(NSString *)title icon:(NSString *)icon iconSize:(CGSize)size{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, (MaxWidth - 60)/3, 40)];
    UILabel *label = [[UILabel alloc] init];
    [view addSubview:label];
    label.text = title;
    label.font = PFR14Font;
    label.textColor = [UIColor lightGrayColor];
    CGFloat wid = [NSString widthOfString:title font:label.font height:20] + 5;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(view.mas_centerX).offset(15);
        make.centerY.mas_equalTo(view.mas_centerY).offset(0);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(wid);
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:icon];
    [view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label.mas_right).offset(0);
        make.centerY.mas_equalTo(label.mas_centerY).offset(0);
        make.width.mas_equalTo(size.width);
        make.height.mas_equalTo(size.height);
    }];
    
    return view;
}

- (void)addViewToBottom {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 40, MaxWidth, 40)];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3].CGColor;
    [self addSubview:view];
    UIImageView *preImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Conpon_Shape"]];
    preImageView.frame = CGRectMake(10, 10, 24, 20);
    [view addSubview:preImageView];
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, 200, 20)];
    tipLabel.font = PFR13Font;
    tipLabel.textColor = [UIColor lightGrayColor];
    tipLabel.text = @"仅显示优惠券商品";
    [view addSubview:tipLabel];
    UISwitch *swi = [[UISwitch alloc] init];
    swi.tintColor = [UIColor orangeColor];
    swi.onTintColor = [UIColor orangeColor];
    swi.transform = CGAffineTransformMakeScale(0.8,0.8);
    [view addSubview:swi];
    [swi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.centerY.mas_equalTo(view.mas_centerY).offset(0);
    }];
    [swi addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
}

- (void)switchChange:(UISwitch *)swi{
    if(self.switchChangeBlock){
        self.switchChangeBlock(swi.on);
    }
}


- (void)showModeChange {
    if (self.showModeChangedBlock) {
        self.showModeChangedBlock(nil);
    }
}
@end
