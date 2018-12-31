//
//  HJBannerModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJBannerModel : NSObject
@property (nonatomic, strong) NSString *banner_image;
@property (nonatomic, assign) NSInteger content_product;
@property (nonatomic, strong) NSString *content_url;
@property (nonatomic, assign) NSInteger taobao_activity_id;
@property (nonatomic, assign) NSInteger typedata;
@end


