//
//  HJSearchVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/3.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJMainVC.h"
#import "LLSearchView.h"

@interface HJSearchVC : HJSuperViewController
@property (nonatomic, assign) NSInteger search_type;
@property (nonatomic, copy) TapActionBlock onItemTapClick;
@end


