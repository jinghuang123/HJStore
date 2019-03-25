//
//  HJMacros.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#ifndef HJMacros_h
#define HJMacros_h

/** 屏幕高度 */
#define MaxHeight [UIScreen mainScreen].bounds.size.height
/** 屏幕宽度 */
#define MaxWidth [UIScreen mainScreen].bounds.size.width

#define KHistorySearchPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"PYSearchhistories.plist"]


////系统字体大小
#define PFR [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0 ? @"PingFangSC-Regular" : @"PingFang SC"

#define PFR20Font [UIFont fontWithName:PFR size:20];
#define PFR18Font [UIFont fontWithName:PFR size:18];
#define PFR16Font [UIFont fontWithName:PFR size:16];
#define PFR15Font [UIFont fontWithName:PFR size:15];
#define PFR14Font [UIFont fontWithName:PFR size:14];
#define PFR13Font [UIFont fontWithName:PFR size:13];
#define PFR12Font [UIFont fontWithName:PFR size:12];
#define PFR11Font [UIFont fontWithName:PFR size:11];
#define PFR10Font [UIFont fontWithName:PFR size:10];
#define PFR9Font [UIFont fontWithName:PFR size:9];
#define PFR8Font [UIFont fontWithName:PFR size:8];


//获取当前版本号
#define BUNDLE_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]
//获取当前版本的biuld
#define BIULD_VERSION [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]
//获取当前设备的UDID
#define DIV_UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)


#define PLACEHOLDER_ITEM  [UIImage imageNamed:@"placeHoder_item"]
#define PLACEHOLDER_SCRO_ITEM   [UIImage imageNamed:@"PLACEHOLDER_SCRO_SLIDER"]
#define PLACEHOLDER_HEAD   [UIImage imageNamed:@"placeholder_head"]
#define PLACEHOLDER_160X240   [UIImage imageNamed:@"placeHoderBlog"]
#define PLACEHOLDER_344X150   [UIImage imageNamed:@"bannerholder344"]


///弱引用
#define weakify(object) __weak __typeof__(object) weak##_##object = object;
///强引用
#define strongify(object) __typeof__(object) object = weak##_##object;

/******************    TabBar          *************/
#define HJStroeTabbarClassKey   @"rootVCClassString"
#define HJStroeTabbarTitleKey   @"title"
#define HJStroeTabbarImgKey     @"imageName"
#define HJStroeTabbarSelImgKey  @"selectedImageName"

#define HJStoreTokenKey  @"kHJStoreTokenKey"
#define kUserInfoKey @"kUserInfoKey"

/***** consts ******/
// 导航栏高度
#define HJNavH  44
// 底部tab高度
#define HJTabH  49
// 顶部Nav高度+指示器
#define HJTopNavH  64

#define segemeHeadH 40

#define REQ_TIMEOUT 20

#endif /* HJMacros_h */
