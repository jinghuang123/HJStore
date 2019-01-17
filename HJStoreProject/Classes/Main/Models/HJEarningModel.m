//
//  HJEarningModel.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/12.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarningModel.h"

@implementation HJEarningModel
+ (instancetype)shared {
    static dispatch_once_t once;
    static HJEarningModel *__singleton__;
    dispatch_once( &once, ^{ __singleton__ = [[self alloc] init]; } );
    return __singleton__;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}
@end
