//
//  UITextField+inputInit.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "UITextField+inputInit.h"

@implementation UITextField (inputInit)
+ (UITextField *)createFieldWithPreIcon:(NSString *)icon placeHolder:(NSString *)holder sizeH:(CGFloat)height delegate:(id)delegate{
    HJTextField *field = [[HJTextField alloc] init];
    field.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 45, height)];
    UIImage *imageV = [UIImage imageNamed:icon];
    CGFloat iconW = imageV.size.width;
    CGFloat iconH = imageV.size.height;
    UIImageView *preImageV = [[UIImageView alloc] initWithFrame:CGRectMake(15, (height - 18)/2, 18 * iconW/iconH, 18)];
    preImageV.image = [UIImage imageNamed:icon];
    [leftView addSubview:preImageV];
    field.font = PFR13Font;
    field.leftView = leftView;
    field.placeholder = holder;
    field.delegate = delegate;
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.7];
    [leftView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-5);
        make.width.mas_equalTo(1);
        make.top.mas_offset(9);
        make.bottom.mas_offset(-9);
    }];
    return field;
}

@end
