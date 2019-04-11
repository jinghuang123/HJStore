//
//  HJEarningModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarningModel.h"

@implementation HJEarningModel

-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeFloat:_taobao_service_fee forKey:@"taobao_service_fee"];
    [aCoder encodeFloat:_app_service_fee forKey:@"app_service_fee"];
    [aCoder encodeFloat:_user_rate forKey:@"user_rate"];
    [aCoder encodeFloat:_parent_user_rate forKey:@"parent_user_rate"];
    [aCoder encodeFloat:_parent_parent_user_rate forKey:@"parent_parent_user_rate"];
    [aCoder encodeObject:_appkey forKey:@"appkey"];
    [aCoder encodeObject:_adzone_id forKey:@"adzone_id"];
    [aCoder encodeObject:_pid forKey:@"pid"];
    [aCoder encodeObject:_member_invitecode forKey:@"member_invitecode"];
    [aCoder encodeObject:_relation_id forKey:@"relation_id"];
    [aCoder encodeObject:_special_id forKey:@"special_id"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.taobao_service_fee = [aDecoder decodeFloatForKey:@"taobao_service_fee"];
        self.app_service_fee = [aDecoder decodeFloatForKey:@"app_service_fee"];
        self.user_rate = [aDecoder decodeFloatForKey:@"user_rate"];
        self.parent_user_rate = [aDecoder decodeFloatForKey:@"parent_user_rate"];
        self.parent_parent_user_rate = [aDecoder decodeFloatForKey:@"parent_parent_user_rate"];
        self.appkey = [aDecoder decodeObjectForKey:@"appkey"];
        self.adzone_id = [aDecoder decodeObjectForKey:@"adzone_id"];
        self.pid = [aDecoder decodeObjectForKey:@"pid"];
        self.member_invitecode = [aDecoder decodeObjectForKey:@"member_invitecode"];
        self.relation_id = [aDecoder decodeObjectForKey:@"relation_id"];
        self.special_id = [aDecoder decodeObjectForKey:@"special_id"];
    }
    return self;
}


- (void)saveEarnConfiger2Phone
{
    [NSUserDefaults jk_setArcObject:self forKey:kEarnConfigerKey];
}

+ (HJEarningModel *)getSavedEarnConfiger {
    HJEarningModel *configer = nil;
    
    configer = [NSUserDefaults jk_arcObjectForKey:kEarnConfigerKey];
    
    return configer;
}
@end
