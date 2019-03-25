//
//  HJCategoryRequest.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/18.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HJCategoryModel.h"


@interface HJCategoryRequest : NSObject
+ (instancetype)shared;
- (void)getCategoryCache:(BOOL)cache success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

- (void)getSubCategoryCache:(BOOL)cache parentId:(NSString *)parentId success:(CompletionSuccessBlock)success fail:(CompletionFailBlock)fail;

@end

