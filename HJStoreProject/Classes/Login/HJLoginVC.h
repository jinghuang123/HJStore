//
//  HJLoginVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"


typedef void(^closeBlock)(id obj);
@interface HJLoginVC : HJSuperViewController
@property (nonatomic,strong) UIButton *closeButton;
@property (nonatomic,copy) closeBlock closeBlock;
@property (nonatomic,assign) BOOL closeHide;
@end

