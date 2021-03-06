//
//  HJFenceListVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"

typedef enum : NSUInteger {
    HJFenceListTypeAll,
    HJFenceListTypeDirectly,
    HJFenceListTypeRecommend,
} HJFenceListType;

@interface HJFenceListVC : HJSuperViewController
@property (nonatomic, assign) HJFenceListType type;

@end


