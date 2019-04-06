//
//  HJCommissionInfo.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJCommissionInfo :NSObject
@property (nonatomic , copy) NSString              * createtime;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * item_title;
@property (nonatomic , copy) NSString              * jiesuantime;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * price;
@property (nonatomic , copy) NSString              * real_money;
@property (nonatomic , assign) NSInteger              status;
@property (nonatomic , assign) NSInteger              type;
@property (nonatomic , assign) NSInteger              user_id;

@end
