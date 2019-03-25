//
//  HJMeView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperView.h"

///点击类型
typedef enum : NSUInteger {
    HJClickItemTypeHead, //头像
    HJClickItemTypeWithDrawal,  //提现
    HJClickItemTypeEarn,  //收益
    HJClickItemTypeOrder,  //订单
    HJClickItemTypeFence, ///粉丝
    HJClickItemTypeInvitation, ///邀请
    HJClickItemTypeService, ///客服
    HJClickItemTypeGuide, ///新手引导
    HJClickItemTypeProblem, ///常见问题
    HJClickItemTypeCollected, ///收藏
    HJClickItemTypeFeedBack, ///意见反馈
    HJClickItemTypeSign, ///官方公告
    HJClickItemTypeSetting, ///设置
    HJClickItemTypeAboutUS, ///关于我们
    HJClickItemTypeADS, ///广告位
} HJClickItemType;

@interface HJMeView : HJSuperView

@property (nonatomic, strong) UIView *earnView;
@property (nonatomic, strong) UIView *orderView;
@property (nonatomic, strong) UIView *fenceView;
@property (nonatomic, strong) UIView *invitateView;

@property (nonatomic,copy) void(^settingClick)(id obj,HJClickItemType type);
@end


