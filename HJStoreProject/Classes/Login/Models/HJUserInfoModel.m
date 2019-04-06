//
//  HJUserInfoModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserInfoModel.h"

@implementation HJUserInfoModel



-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeInteger:_score forKey:@"score"];
    [aCoder encodeObject:_avatar forKey:@"avatar"];
    [aCoder encodeObject:_createtime forKey:@"createtime"];
    [aCoder encodeObject:_expires_in forKey:@"expires_in"];
    [aCoder encodeObject:_expiretime forKey:@"expiretime"];
    [aCoder encodeObject:_mobile forKey:@"mobile"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
    [aCoder encodeObject:_token forKey:@"token"];
    [aCoder encodeObject:_user_id forKey:@"user_id"];
    [aCoder encodeObject:_username forKey:@"username"];
    [aCoder encodeObject:_code forKey:@"code"];
    [aCoder encodeInteger:_group_id forKey:@"group_id"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.score = [aDecoder decodeIntForKey:@"score"];
        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
        self.createtime = [aDecoder decodeObjectForKey:@"createtime"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.expiretime = [aDecoder decodeObjectForKey:@"expiretime"];
        self.mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.nickname = [aDecoder decodeObjectForKey:@"nickname"];
        self.token = [aDecoder decodeObjectForKey:@"token"];
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        self.username = [aDecoder decodeObjectForKey:@"username"];
        self.code = [aDecoder decodeObjectForKey:@"code"];
        self.group_id = [aDecoder decodeIntForKey:@"group_id"];

    }
    return self;
}


- (void)saveUserInfo2Phone
{
    [NSUserDefaults jk_setArcObject:self forKey:kUserInfoKey];
}

+ (HJUserInfoModel *)getSavedUserInfo {
    HJUserInfoModel *info = nil;
    
    info = [NSUserDefaults jk_arcObjectForKey:kUserInfoKey];
    
    return info;
}

@end
