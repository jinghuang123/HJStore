//
//  HJCategoryModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/14.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJCategoryModel.h"

@implementation HJCategoryModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             // 模型属性: JSON key, MJExtension 会自动将 JSON 的 key 替换为你模型中需要的属性
             @"categoryId":@"id",
             };
}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_categoryId forKey:@"categoryId"];
    [aCoder encodeInteger:_parent_id forKey:@"parent_id"];
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_image forKey:@"image"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.categoryId = [aDecoder decodeObjectForKey:@"categoryId"];
        self.parent_id = [aDecoder decodeIntForKey:@"parent_id"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.image = [aDecoder decodeObjectForKey:@"image"];
    }
    return self;
}


@end


@implementation HJCategoryModelsSaved


-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_categorys forKey:@"categorys"];
}

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.categorys = [aDecoder decodeObjectForKey:@"categorys"];
    }
    return self;
}


- (void)saveCategorysInfo2Phone
{
    [NSUserDefaults jk_setArcObject:self forKey:kCategorysKey];
}

+ (HJCategoryModelsSaved *)getSavedCategoryModels
{
    HJCategoryModelsSaved *info = nil;
    
    info = [NSUserDefaults jk_arcObjectForKey:kCategorysKey];
    
    return info;
}

@end
