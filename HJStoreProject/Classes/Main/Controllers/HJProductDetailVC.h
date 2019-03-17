//
//  HJProductDetailVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "HJRecommendModel.h"

@interface HJProductDetailVC : HJSuperViewController
@property (nonatomic, strong) NSString *productId;
@property (nonatomic, strong) HJRecommendModel *searchModel;
@end


