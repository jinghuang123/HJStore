//
//  HJPopToSearchViewController.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/4.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "MYPresentedController.h"


typedef void(^HJSearchBlock)(NSString *key);
@interface HJPopToSearchViewController : MYPresentedController
@property (nonatomic, strong) NSString *searchTip;
@property (nonatomic, copy) HJSearchBlock searchBlock;
@end


