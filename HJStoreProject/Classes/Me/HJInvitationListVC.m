//
//  HJInvitationListVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/3/10.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJInvitationListVC.h"

@interface HJInvitationListVC ()

@end

@implementation HJInvitationListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
