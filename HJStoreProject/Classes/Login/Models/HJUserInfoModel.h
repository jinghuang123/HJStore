//
//  HJUserInfoModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJUserInfoModel : NSObject
@property (nonatomic , copy) NSString *avatar;
@property (nonatomic , copy) NSString *createtime;
@property (nonatomic , copy) NSString *expires_in;
@property (nonatomic , copy) NSString *expiretime;
@property (nonatomic , copy) NSString *mobile;
@property (nonatomic , copy) NSString *nickname;
@property (nonatomic , assign) NSInteger score;
@property (nonatomic , copy) NSString *token;
@property (nonatomic , copy) NSString *code;
@property (nonatomic , copy) NSString *user_id;
@property (nonatomic , copy) NSString *username;
@property (nonatomic , assign) NSInteger group_id;

- (void)saveUserInfo2Phone;

+ (HJUserInfoModel *)getSavedUserInfo;
@end

