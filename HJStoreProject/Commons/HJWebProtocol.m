//
//  HJWebProtocol.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJWebProtocol.h"

#define Declare(NAME, REQ) NSString * const NAME = kHHWebServerBaseURL REQ;

Declare(kUrlGetCategoryMainList, "api/goods/getProductList") /**1.1 主页分类**/
Declare(kUrlGetProductDetail, "api/goods/getProductDetails")  /**1.3 商品详情 **/
Declare(kUrlGetMainList, "api/index/getIndex")  /**1.4 主页面数据列表 **/
Declare(kUrlGetRandomList, "api/goods/getRandomProductList") /*1.5 猜你喜欢 */
Declare(kUrlGetListSearch,"api/search/get") /* 1.6 搜索*/
Declare(kUrlGetShareData,"api/goods/getShareInfo") /* 1.7 分享数据*/
Declare(kUrlGetActivityList,"api/activity/getList") /* 1.8 活动类商品列表*/
Declare(kUrlEarningConfiger,"api/user/getConfig") /* 1.9 商品收益配置 */


        
Declare(kUrlGetCategorys, "api/category/getCategory")  /**< 2.1 分类 */
Declare(kUrlGetSubCategorys, "api/category/getCategory")  /**< 2.2 二级分类 */


Declare(kUrlRegist, "api/user/register") /* 3.0 注册 */
Declare(kUrlLogin, "api/user/login") /* 3.1 密码登录 */
Declare(kUrlLoginSMS, "api/user/mobilelogin") /* 3.2 短信登录 */
Declare(kUrlLogout, "api/user/logout") /* 3.3 注销登录 */
Declare(kUrlUserUpdate, "api/user/profile") /* 3.4 修改会员信息*/
Declare(kUrlMobileUpdate, "api/user/changemobile") /* 3.5 修改手机号*/
Declare(kUrlPassworldReset, "api/user/resetpwd") /* 3.6 重置密码*/
Declare(kUrlGetAllChildren, "api/user/getAllChildren") /* 3.7 粉丝列表*/
Declare(kUrlGetChildren, "api/user/getChildren") /* 3.8 直接粉丝*/
Declare(kUrlCheckModbileCode, "api/validate/check_code_or_mobile") /* 3.9 检测手机号或邀请码是否存在 */
Declare(kUrlCheckModbile, "api/validate/check_mobile_exist") /* 3.10 检测手机号是否存在 */
Declare(kUrlGetCode, "api/sms/send") /* 3.11 获取验证码 */
Declare(kUrlCheckCode, "api/sms/check") /* 3.12 验证验证码 */
