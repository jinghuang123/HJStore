//
//  HJMineVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMineVC.h"
#import "HJSettingRequest.h"
#import "HJMainRequest.h"

@interface HJMineVC ()

@end

@implementation HJMineVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[HJMainRequest shared] getEarningConfigerSuccess:^(HJEarningModel *earning) {
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[HJSettingRequest shared] getApplyCashListSuccess:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
