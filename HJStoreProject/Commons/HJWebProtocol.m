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
        
Declare(kUrlGetCategorys, "api/category/getCategory")  /**< 2.1 分类 */
Declare(kUrlGetSubCategorys, "api/category/getCategory")  /**< 2.2 二级分类 */



