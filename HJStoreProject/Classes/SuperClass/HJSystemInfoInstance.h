//
//  HJSystemInfoInstance.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJSystemInfoInstance : NSObject
@property (nonatomic , strong) NSMutableArray *searchHots;
+ (HJSystemInfoInstance *)shared;
- (void)getSearchHots;
@end

