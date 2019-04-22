//
//  HJMeView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperView.h"
#import "HJMainSliderCell.h"
#import "HJGeneralInfo.h"
#import "HJUserInfoModel.h"
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
    HJClickItemTypeMessage, ///消息列表
    HJClickItemTypeUpdateGroup, ///升级运营商
} HJClickItemType;

#define kUrlNewGuide @"https://app.meizhi1000.com/cms/c/%E6%96%B0%E6%89%8B%E6%94%BB%E7%95%A5"
#define kUrlQuestion @"https://app.meizhi1000.com/cms/c/%E5%B8%B8%E8%A7%81%E9%97%AE%E9%A2%98"
#define kUrlFeedBack @"https://app.meizhi1000.com/cms/d/message"
#define kUrlSign @"https://app.meizhi1000.com/cms/c/%E5%AE%98%E6%96%B9%E5%85%AC%E5%91%8A"
#define kUrlUpdateUser @"https://app.meizhi1000.com/index/yys/index"

@interface HJMeView : HJSuperView

@property (nonatomic, strong) UIView *earnView;
@property (nonatomic, strong) UIView *orderView;
@property (nonatomic, strong) UIView *fenceView;
@property (nonatomic, strong) UIView *invitateView;
@property (nonatomic, strong) HJMainSliderView *adSliderCellView;
@property (nonatomic, strong) UIView *icomView;
@property (nonatomic,strong) NSString *code;

@property (nonatomic,copy) void(^settingClick)(id obj,HJClickItemType type);

- (void)setInfoWithGenerInfo:(HJGeneralInfo *)info;

- (instancetype)initWithBanners:(NSArray *)array;
@end


