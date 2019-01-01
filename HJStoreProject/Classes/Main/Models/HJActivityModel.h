//
//  HJActivityModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJActivityModel : NSObject
@property (nonatomic, assign) NSInteger content_list;
@property (nonatomic, assign) NSInteger content_product;
@property (nonatomic, strong) NSString *content_url;
@property (nonatomic, assign) NSInteger activityId;
@property (nonatomic, assign) NSInteger islogindata;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pic_image;
@property (nonatomic, assign) NSInteger typedata; //0.url 1.产品详情  2.产品列表
@end


