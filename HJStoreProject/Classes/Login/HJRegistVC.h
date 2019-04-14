//
//  HJRegistVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJWechatUserModel.h"


@interface HJRegistVC : HJSuperViewController
@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) HJWechatUserModel *userModel;
@end

