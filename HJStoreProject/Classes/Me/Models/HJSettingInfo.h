//
//  HJSettingInfo.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/13.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJZfbInfo :NSObject
@property (nonatomic , assign) NSInteger              user_id;
@property (nonatomic , copy) NSString              * name;
@property (nonatomic , copy) NSString              * account;
@property (nonatomic , assign) NSInteger              createtime;

@end


@interface HJSettingInfo :NSObject
@property (nonatomic , strong) HJZfbInfo        * zfb;
@property (nonatomic , copy) NSString              *kefu_qrcode;
@property (nonatomic , copy) NSString              *kefu_wechat;
@property (nonatomic , assign) BOOL              weixin;
@property (nonatomic , assign) BOOL              taobao;
+ (HJSettingInfo *)shared;
@end
