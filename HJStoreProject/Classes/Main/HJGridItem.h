//
//  HJGridItem.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJGridItem : NSObject
/** 图片  */
@property (nonatomic, copy ,readonly) NSString *iconImage;
/** 文字  */
@property (nonatomic, copy ,readonly) NSString *gridTitle;
/** tag  */
@property (nonatomic, copy ,readonly) NSString *gridTag;
/** tag颜色  */
@property (nonatomic, copy ,readonly) NSString *gridColor;
@end

@interface HJRecommendItem : NSObject
/** 图片URL */
@property (nonatomic, copy ,readonly) NSString *image_url;
/** 商品标题 */
@property (nonatomic, copy ,readonly) NSString *main_title;
/** 商品小标题 */
@property (nonatomic, copy ,readonly) NSString *goods_title;
/** 商品价格 */
@property (nonatomic, copy ,readonly) NSString *price;
/** 剩余 */
@property (nonatomic, copy ,readonly) NSString *stock;
/** 属性 */
@property (nonatomic, copy ,readonly) NSString *nature;
/* 头部轮播 */
@property (copy , nonatomic , readonly)NSArray *images;
@end

