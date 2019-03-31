//
//  HJRecommendItemModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/19.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJRecommendModel.h"


@interface HJRecommendItemModel :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , assign) NSInteger              share;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * avatar;
@property (nonatomic , copy) NSString              * nickname;
@property (nonatomic , copy) NSString              * taobao_items;
@property (nonatomic , assign) NSInteger              goods_count;
@property (nonatomic , strong) NSArray <HJRecommendModel *>              * goods;
@property (nonatomic , strong) NSArray <NSString *>              * images;

@end

