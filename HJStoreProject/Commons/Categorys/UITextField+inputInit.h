//
//  UITextField+inputInit.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (inputInit)
+ (UITextField *)createFieldWithPreIcon:(NSString *)icon placeHolder:(NSString *)holder sizeH:(CGFloat)height delegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
