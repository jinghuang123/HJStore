//
//  HJMainVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJMainRequest.h"
#import "HJSuperView.h"


@interface HJMainVC : HJSuperViewController
@property (nonatomic,assign) HJMainVCProductListHeadType headType;
@property (nonatomic,assign) HJMainVCProductListType listType;
@property (nonatomic,assign) NSInteger catteryId;
@property (assign , nonatomic) GoodsListShowType showType;


@property (nonatomic,copy) cellItemClick urlItemClickBlock;
@property (nonatomic,copy) cellItemClick productListItemClickBlock;
@property (nonatomic,copy) cellItemClick productDetailItemClickBlock;
@end


