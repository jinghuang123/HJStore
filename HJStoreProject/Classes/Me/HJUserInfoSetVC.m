//
//  HJUserInfoSetVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserInfoSetVC.h"
#import "HJUserInfoView.h"

@interface HJUserInfoSetVC ()

@end

@implementation HJUserInfoSetVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    HJUserInfoView *selfView = [[HJUserInfoView alloc] init];
    [self.view addSubview:selfView];
    [selfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_offset(0);
    }];
}



@end
