//
//  NSString+Extension.m
//  HuaShuo
//
//  Created by zsj on 16/1/22.
//  Copyright (c) 2016年 HihiCenter. All rights reserved.
//

#import "NSString+Extension.h"


long const kMaxPhoneLength = 11;

@implementation NSString (Extension)

- (NSString *)stringTrim
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)stringIsEmpty
{
//    NSString *temp = [self stringTrim];
//    return (temp == nil || temp.length == 0);
    if (nil == self || 0 == self.length) {
        return YES;
    } else {
        return ([self stringTrim].length == 0);
    }
}

- (CGSize)stringSizeWithFont:(UIFont *)font bounds:(CGSize)bounds
{
    CGRect rect = [self boundingRectWithSize:bounds
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{ NSFontAttributeName:font }
                                     context:NULL];
    return rect.size;
}

- (BOOL)stringValidateWithRegx:(NSString *)regx
{
    return [[NSPredicate predicateWithFormat:@"SELF MATCHES %@", regx] evaluateWithObject:self];
}
- (NSString *)formattedPhoneNumberWithAreaCode:(NSString *)areaCode{

    NSInteger length = [self length];
    NSString *part1 = @"";
    NSString *part2 = @"";
    NSString *part3 = @"";

    if (length > 0) {
        part1 = [self substringWithRange:NSMakeRange(0, MIN(3, length))];
        part2 = [self substringWithRange:NSMakeRange(MIN(3, length - 1), MIN(4, MAX(0, length - 3)))];
        part3 = [self substringWithRange:NSMakeRange(MIN(7, length - 1), MIN(4, MAX(0, length - 7)))];
    }
    return [NSString stringWithFormat:@"(+%@)%@-%@-%@",areaCode, part1, part2, part3];

}

- (NSString *)hh_pinyin {
    NSMutableString *str = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    return str;
}
- (NSString *)hh_searchString {
    return [[[self hh_pinyin] stringByReplacingOccurrencesOfString:@" " withString:@""] lowercaseString];
}

- (BOOL)hh_contains:(NSString *)string {
    NSRange range = [self rangeOfString:string];
    return range.location != NSNotFound;
}

+ (CGFloat)widthOfString:(NSString *)string font:(UIFont *)font height:(CGFloat)height {
    NSDictionary * dict=[NSDictionary dictionaryWithObject: font forKey:NSFontAttributeName];
    CGRect rect=[string boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return rect.size.width;
}

+ (CGFloat)heightOfString:(NSString *)string font:(UIFont *)font width:(CGFloat)width {
    CGRect bounds;
    NSDictionary * parameterDict=[NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    bounds=[string boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:parameterDict context:nil];
    return bounds.size.height;
}


+ (UIFont *)fontWithPxSize:(NSInteger)pxValue {
    CGFloat fontSize = pxValue/2.0;
    return [UIFont systemFontOfSize:fontSize];
}

@end
