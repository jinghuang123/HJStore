//
//  HJWebProtocol.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

#define Declare(NAME, REQ) extern NSString * const NAME;

#define kHHWebServerBaseURL @"https://app.meizhi1000.com/"



Declare(kUrlGetCategoryMainList, "api/goods/getProductList") /**1.1 主页分类**/
Declare(kUrlGetProductDetail, "api/goods/getProductDetails")  /**1.3 商品详情 **/
Declare(kUrlGetMainList, "api/index/getIndex")  /**1.4 主页精品页面数据列表 **/
Declare(kUrlGetRandomList, "api/goods/getRandomProductList") /*1.5 猜你喜欢 */
Declare(kUrlGetListSearch,"api/search/get") /* 1.6 搜索*/
Declare(kUrlGetShareData,"api/goods/getShareInfo") /* 1.7 分享数据*/
Declare(kUrlGetActivityList,"api/activity/getList") /* 1.8 活动类商品列表*/
Declare(kUrlEarningConfiger,"api/user/getConfig") /* 1.9 商品收益配置 */
Declare(kUrlFavoriteGoods,"api/goods/favorites") /* 1.10 商品收藏 */
Declare(kUrlGetFavoriteGoods,"api/goods/getFavorites") /* 1.11 获取商品收藏列表 */
Declare(kUrlGetIfFavorite,"api/goods/checkItemFavorites") /* 1.12 检查商品是否收藏 */
Declare(kUrlGetSearchHot,  "api/search/getHot") /* 1.13 获取热门搜索 */

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
Declare(kUrlGetRecommendChildren, "api/user/getRecommendChildren") /* 3.81 推荐粉丝*/
Declare(kUrlCheckModbileCode, "api/validate/check_code_or_mobile") /* 3.9 检测手机号或邀请码是否存在 */
Declare(kUrlCheckModbile, "api/validate/check_mobile_exist") /* 3.10 检测手机号是否存在 */
Declare(kUrlGetCode, "api/sms/send") /* 3.11 获取验证码 */
Declare(kUrlCheckCode, "api/sms/check") /* 3.12 验证验证码 */
Declare(kUrlWechatLogin, "api/user/wechatlogin") /*3.13 微信登陆*/
Declare(kUrlWechatBonding, "api/user/wechatbind") /*3.14 微信绑定*/
Declare(kUrlUpdateGroup, "api/user/upgrade") /*3.15 升级运营商*/
Declare(kUrlGetSettingInfo, "api/setting/getSettingInfo") /*3.16 查询设置信息*/


Declare(kUrlRecommendTitles, "api/bbs/getBbsChannel") /* 4.1 社区分类 */
Declare(kUrlRecommendList, "api/bbs/getBbsList") /* 4.2 社区列表数据 */

Declare(kURLBindAlipay, "api/setting/bindZfb") /* 5.1 绑定支付宝 */
Declare(kURLGetBindMsg, "api/setting/getBindZfb") /* 5.2 绑定信息获取 */
Declare(kURLGetInvitationList, "api/setting/getInvitationInfo") /* 5.3 查询邀请页数据 */
Declare(kURLApplyCash, "api/user/requestCash") /* 5.4 申请提现 */
Declare(kURLGetApplyCashList, "api/setting/getCashWithdrawalRecord") /* 5.4 提现记录 */
Declare(kURLFileUpload, @"/api/common/upload") /* 5.5 文件上传*/
Declare(kURLGetBanners, @"api/common/getBanner") /*5.6 获取banners*/
Declare(kUrlGetGeneralInfo, @"api/user/getGeneralInfo") /* 5.7 获取收益概要信息 */
Declare(kUrlGetWeiquanOrders, @"api/order/getWeiquanOrders") /* 5.8 获取维权订单 */
Declare(kUrlGetCommissionInfo, @"api/user/getCommissionInfo") /* 5.9 获取收益明细 */
Declare(kUrlGetKefuInfo, @"api/setting/getKefuInfo") /* 5.10 获取维权订单 */
Declare(kUrlGetServiceInfo, @"api/setting/getKefuInfo") /* 5.11 获取客服信息 */
Declare(kUrlGetCachInfo, @"api/setting/getCashInfo") /*5.12 获取提现信息 */

Declare(kURLGetOrderList, @"api/order/getOrder") /* 6.1 获取订单*/


Declare(kURLGetInvitationInfo, @"api/setting/getInvitationInfo") /*7.1 获取邀请数据*/
Declare(kURLQrcode, @"index/app/detail") /* 8.1 生成二维码地址 */
