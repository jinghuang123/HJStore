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
#import "HJOrderListVC.h"
#import "HJInvitationListVC.h"
#import "HJEarningVC.h"

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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
    
    weakify(self)
    meView.settingClick = ^(id obj,HJClickItemType type) {
        [weak_self responsToItemClickWithType:type];
    };
}

- (void)responsToItemClickWithType:(HJClickItemType)type {
    switch (type) {
        case HJClickItemTypeHead:
        {
            HJUserInfoSetVC *setVC = [[HJUserInfoSetVC alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        case HJClickItemTypeWithDrawal:
            
            break;
        case HJClickItemTypeEarn:
        {
            HJEarningVC *earningVC = [[HJEarningVC alloc] init];
            earningVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:earningVC animated:YES];
        }
            break;
        case HJClickItemTypeOrder:
        {
            HJOrderListVC *orderVC = [[HJOrderListVC alloc] init];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case HJClickItemTypeFence:
        {
            HJFencePageVC *fenceVC = [[HJFencePageVC alloc] init];
            fenceVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fenceVC animated:YES];
        }
            
            break;
        case HJClickItemTypeInvitation:
        {
            HJInvitationListVC *invitationVC = [[HJInvitationListVC alloc] init];
            invitationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invitationVC animated:YES];
        }
            
            break;
            
        default:
            break;
    }
    
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
