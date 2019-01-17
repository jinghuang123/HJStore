//
//  HJCategoryModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/14.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCategorysKey @"saveCategorysKey"

@interface HJCategoryModel : NSObject
@property (nonatomic , assign) NSInteger categoryId;
@property (nonatomic , assign) NSInteger parent_id;
@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *image;
@end

@interface HJCategoryModelsSaved : NSObject
@property (nonatomic , copy) NSArray *categorys;

- (void)saveCategorysInfo2Phone;
+ (HJCategoryModelsSaved *)getSavedCategoryModels;
@end



