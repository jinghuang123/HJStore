//
//  HJSystemInfoInstance.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSystemInfoInstance.h"
#import "HJMainRequest.h"

@implementation HJSystemInfoInstance

+ (HJSystemInfoInstance *)shared {
    static dispatch_once_t once;
    static HJSystemInfoInstance *systemInstance;
    dispatch_once( &once, ^{
        systemInstance = [[self alloc] init];
    });
    return systemInstance;
}


- (NSMutableArray *)searchHots {
    if (!_searchHots) {
        _searchHots = [[NSMutableArray alloc] init];
    }
    return _searchHots;
}

- (void)getSearchHots {
    if (self.searchHots.count == 0) {
        [[HJMainRequest shared] getSearchHotSuccess:^(NSArray *searchHots) {
            for (HJSearchHotModel *hot in searchHots) {
                [self.searchHots addObject:hot.keyword];
            }
        } fail:^(NSError *error) {
        }];
    }
}

@end
