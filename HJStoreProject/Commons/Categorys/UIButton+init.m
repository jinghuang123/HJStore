//
//  UIButton+init.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "UIButton+init.h"

@implementation UIButton (init)
+ (UIButton *)createThemeButtonRegist:(NSString *)title {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageNomal = [UIImage imageNamed:@"register_bg"];
    buttonImageNomal = [buttonImageNomal stretchableImageWithLeftCapWidth:floorf(buttonImageNomal.size.width/2) topCapHeight:floorf(buttonImageNomal.size.height/2)];
    [button setBackgroundImage:buttonImageNomal forState:UIControlStateNormal];
    UIImage *buttonImageHigh = [UIImage imageNamed:@"register_bg"];
    buttonImageHigh = [buttonImageHigh stretchableImageWithLeftCapWidth:floorf(buttonImageHigh.size.width/2) topCapHeight:floorf(buttonImageHigh.size.height/2)];
    [button setBackgroundImage:buttonImageHigh forState:UIControlStateHighlighted];
    UIImage *buttonImageDis = [UIImage imageNamed:@"register_bg"];
    buttonImageDis = [buttonImageDis stretchableImageWithLeftCapWidth:floorf(buttonImageDis.size.width/2) topCapHeight:floorf(buttonImageDis.size.height/2)];
    [button setBackgroundImage:buttonImageDis forState:UIControlStateDisabled];

    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
    return button;
}


+ (UIButton *)createThemeButton:(NSString *)title {
    UIButton *button = [self buttonWithType:UIButtonTypeCustom];
    UIImage *buttonImageNomal = [UIImage imageNamed:@"button_h"];

    [button setBackgroundImage:buttonImageNomal forState:UIControlStateNormal];
    UIImage *buttonImageHigh = [UIImage imageNamed:@"button_h"];
    [button setBackgroundImage:buttonImageHigh forState:UIControlStateHighlighted];
    UIImage *buttonImageDis = [UIImage imageNamed:@"button_gray_bg"];
    [button setBackgroundImage:buttonImageDis forState:UIControlStateDisabled];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:18];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    return button;
}
@end
