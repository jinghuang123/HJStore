//
//  HJProductDetailVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJProductDetailVC.h"
#import "HJMainRequest.h"
@interface HJProductDetailVC ()

@end

@implementation HJProductDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HJMainRequest shared] getProductDetailCache:YES productId:self.productId success:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
}


@end
