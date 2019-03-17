//
//  NSString+Extension.h
//  HuaShuo
//
//  Created by zsj on 16/1/22.
//  Copyright (c) 2016年 HihiCenter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

extern long const kMaxPhoneLength;     /**< 手机号长度 */

@interface NSString (Extension)

/**
 *  清空字符串左右两边空格
 */
- (NSString *)stringTrim;

/**
 *  判断是否为空字符串，包括全是空格
 */
- (BOOL)stringIsEmpty;

/**
 *  根据字体大小和指定size计算出字符串实际size
 *
 *  @param font   字体
 *  @param bounds size限制
 */
- (CGSize)stringSizeWithFont:(UIFont *)font bounds:(CGSize)bounds;

/**
 *  根据指定的正则表达式判断字符串是否符合要求
 *
 *  @param regx 正则表达式
 */
- (BOOL)stringValidateWithRegx:(NSString *)regx;

- (NSString *)formattedPhoneNumberWithAreaCode:(NSString *)areaCode;


- (NSString *)hh_pinyin;
- (NSString *)hh_searchString;
- (BOOL)hh_contains:(NSString *)string;
+ (UIFont *)fontWithPxSize:(NSInteger)pxValue;
+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height;
+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width;
@end
