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
    UITextField *field = [[UITextField alloc] init];
    field.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, height)];
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
    return field;
}
@end
