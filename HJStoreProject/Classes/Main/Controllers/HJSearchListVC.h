//
//  HJSearchListVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"



@interface HJSearchListVC : HJSuperViewController
@property (nonatomic, assign) NSInteger search_type;
@property (nonatomic,strong) NSString *searchTip;
@property (nonatomic,assign) CGPoint showPopPoint;
@end

