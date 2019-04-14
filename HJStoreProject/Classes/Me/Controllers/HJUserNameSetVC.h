//
//  HJUserNameSetVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"


typedef void(^UserInfoSetCommitBlock)(id obj);
@interface HJUserNameSetVC : HJSuperViewController
@property (nonatomic, copy) UserInfoSetCommitBlock userNameSetBlock;
@end


