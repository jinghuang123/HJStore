//
//  UIImageView+HHWebImage.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "UIImageView+HHWebImage.h"


@implementation UIImageView (HHWebImage)

- (void)sd_setImageWithURLString:(nullable NSString *)URLString
                placeholderImage:(nullable UIImage *)placeholder {
    NSString *realUrl = [URLString hasPrefix:@"http"] ? URLString : [NSString stringWithFormat:@"%@%@",kHHWebServerBaseURL,URLString];
    NSURL *url = [NSURL URLWithString:realUrl ?: @""];
    [self sd_setImageWithURL:url placeholderImage:placeholder];
}




@end
