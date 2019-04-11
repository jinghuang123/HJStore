//
//  HJShareVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJShareModel.h"
#import "HJRecommendModel.h"

@interface HJShareVC : HJSuperViewController
@property (nonatomic, strong) HJShareModel *shareModel;
@property (nonatomic, strong) HJRecommendModel *detailmodel;
@property (nonatomic, strong) UIImage *mainShareImage;
@property (nonatomic, assign) BOOL showCoupons;
@end


