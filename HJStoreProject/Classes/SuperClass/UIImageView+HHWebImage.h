//
//  UIImageView+HHWebImage.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIImageView+WebCache.h>
@interface UIImageView (HHWebImage)


- (void)sd_setImageWithURLString:(nullable NSString *)URLString
               placeholderImage:(nullable UIImage *)placeholder;

@end
