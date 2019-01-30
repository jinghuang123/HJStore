//
//  HJMeView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperView.h"



@interface HJMeView : HJSuperView

@property (nonatomic, strong) UIView *earnView;
@property (nonatomic, strong) UIView *orderView;
@property (nonatomic, strong) UIView *fenceView;
@property (nonatomic, strong) UIView *invitateView;

@property (nonatomic,copy) void(^settingClick)(id obj);
@end


