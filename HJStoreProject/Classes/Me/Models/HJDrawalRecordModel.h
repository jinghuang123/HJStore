//
//  HJDrawalRecordModel.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJDrawalRecordModel :NSObject
@property (nonatomic , assign) NSInteger              id;
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * money;
@property (nonatomic , copy) NSString              * status;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , assign) NSInteger              updatetime;
@property (nonatomic , copy) NSString              * memo;
@property (nonatomic , copy) NSString              * alipay_order_id;

@end
