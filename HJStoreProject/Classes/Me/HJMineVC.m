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
#import "HJMeView.h"
#import "HJUserInfoSetVC.h"
#import "HJFencePageVC.h"

@interface HJMineVC ()

@end

@implementation HJMineVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
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
    
    HJMeView *meView = [[HJMeView alloc] init];
    [self.view addSubview:meView];
    [meView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    meView.settingClick = ^(id obj) {
        HJUserInfoSetVC *setVC = [[HJUserInfoSetVC alloc] init];
        [setVC setNavBackItem];
        setVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:setVC animated:YES];
    };
    
    [meView.earnView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
    [meView.orderView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
    [meView.fenceView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        HJFencePageVC *fenceVC = [[HJFencePageVC alloc] init];
        [fenceVC setNavBackItem];
        fenceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:fenceVC animated:YES];
    }];
    
    [meView.invitateView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
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
