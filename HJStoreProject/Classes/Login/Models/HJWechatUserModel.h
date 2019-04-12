//
//  HJWechatUserModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJWechatUserModel : NSObject
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , copy) NSString *token;
@property (nonatomic , copy) NSString *openid;
@property (nonatomic , copy) NSString *icon;
@property (nonatomic , copy) NSString *uid;
@property (nonatomic , assign) NSInteger gender;
@end


