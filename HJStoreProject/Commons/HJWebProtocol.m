//
//  HJWebProtocol.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJWebProtocol.h"

#define Declare(NAME, REQ) NSString * const NAME = kHHWebServerBaseURL REQ;

Declare(kUrlGetCategoryMainList, "api/common/getIndexByCategory") /**1.1 主页分类**/
Declare(kUrlGetProductListMain, "api/common/getProductList")  /**1.2 主页商品列表 **/
Declare(kUrlGetProductDetail, "api/common/getProductDetails")  /**1.3 商品详情 **/
Declare(kUrlGetMainList, "api/common/getIndex")  /**1.4 主页精品页面数据列表 **/

Declare(kUrlGetCategorys, "api/common/getTopCategory")  /**< 2.1 分类 */
Declare(kUrlGetSubCategorys, "api/common/getSecondCategory")  /**< 2.2 二级分类 */



