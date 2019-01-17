//
//  HJEarningModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJEarningModel : NSObject
@property (nonatomic , assign) CGFloat  taobao_service_fee;
@property (nonatomic , assign) CGFloat  app_service_fee;
@property (nonatomic , assign) CGFloat  user_rate;
@property (nonatomic , assign) CGFloat  parent_user_rate;
@property (nonatomic , assign) CGFloat  parent_parent_user_rate;
@property (nonatomic , copy) NSString   *adzone_id;
@property (nonatomic , copy) NSString   *pid;

+ (instancetype)shared;
@end


