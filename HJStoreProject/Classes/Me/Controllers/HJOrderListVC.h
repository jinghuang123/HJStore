//
//  HJOrderListVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/3/10.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"

typedef enum : NSUInteger {
    HJListTypeAll = 1 ,
    HJListTypePayed = 2,
    HJListTypeSettlemented = 3,
    HJListTypeFailed = 4,
} HJListType;

@interface HJOrderListVC : HJSuperViewController
@property (nonatomic, assign) HJListType type;
@end


