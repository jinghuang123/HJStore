//
//  HJWebProtocol.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/8.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJWebProtocol.h"

#define Declare(NAME, REQ) NSString * const NAME = kHHWebServerBaseURL REQ;

Declare(kUrlGetCategorys, "api/common/getCategory")  /**< 2.1 账号登录 */



