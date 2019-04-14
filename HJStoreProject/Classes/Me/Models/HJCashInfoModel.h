//
//  HJCashInfoModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Zfb :NSObject
@property (nonatomic , copy) NSString              *account;
@property (nonatomic , assign) NSInteger              createtime;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              *user_id;

@end


@interface HJCashInfoModel :NSObject
@property (nonatomic , copy) NSString              * fee;
@property (nonatomic , assign) NSInteger              lowest;
@property (nonatomic , assign) CGFloat              money;
@property (nonatomic , strong) Zfb              * zfb;

@end
