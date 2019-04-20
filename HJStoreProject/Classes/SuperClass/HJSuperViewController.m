//
//  HJSuperViewController.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"
#import "YFPolicyWebVC.h"
#import "HJUserInfoModel.h"
#import "HJEarningModel.h"
#import "HJLoginVC.h"

@interface HJSuperViewController ()<UIGestureRecognizerDelegate>

@end

@implementation HJSuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(245, 245, 245);
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    self.navigationController.interactivePopGestureRecognizer.delegate = self;
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
}

- (void)setNavBackItem {
    UIView *backView = [[UIView alloc] init];
    backView.frame = CGRectMake(0, 0, 60, 64);
    backView.backgroundColor = [UIColor clearColor];
    UIImage *img = [UIImage imageNamed:@"NavBar_backImg"];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 22, 40);
    [btn setImage:img forState:UIControlStateNormal];
    [backView addSubview:btn];
    [backView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self backButtonClick];
    }];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithCustomView:backView];
    self.navigationItem.leftBarButtonItem = backButton;
}


    

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)pushToLoginVC:(BOOL)hideClose closeBlock:(closeBlock)block{
    HJLoginVC *login = [[HJLoginVC alloc] init];
    login.closeHide = hideClose;
    login.closeBlock = block;
    login.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:login animated:YES];
}

- (void)showTaobaoAuthorDailogSuccess:(CompletionSuccessBlock)success {
    weakify(self)
    HJEarningModel *configer = [HJEarningModel getSavedEarnConfiger];
    if (configer.relation_id && configer.relation_id.length > 0 && configer.special_id && configer.special_id.length > 0) {
        success(nil);
    }else {
        HJTaobaoAuthorPopVC *pop = [[HJTaobaoAuthorPopVC alloc] initWithShowFrame:CGRectMake(0, 0 ,MaxWidth, MaxHeight)
                                                                        ShowStyle:MYPresentedViewShowStyleSuddenStyle
                                                                         callback:^(id obj) {
                                                                         }];
        pop.clearBack = YES;
        weakify(pop)
        pop.authorPushClick = ^(id obj) {
            [weak_self gotoAuthor:weak_pop success:success];
        };
        [self presentViewController:pop animated:YES completion:nil];
        
    }

}

- (void)gotoAuthor:(HJTaobaoAuthorPopVC *)pop success:(CompletionSuccessBlock)suc{
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    HJEarningModel *configer = [HJEarningModel getSavedEarnConfiger];
    NSString *uid = userInfo.user_id;
    NSString *key = configer.appkey;
    NSString *url = [NSString stringWithFormat:@"http://oauth.m.taobao.com/authorize?response_type=code&client_id=%@&redirect_uri=http://app.meizhi1000.com/index/taobaoAuth/saveScPublisherInfo&state=%@&view=web",key,uid];
    YFPolicyWebVC *web = [[YFPolicyWebVC alloc] init];
    web.taobaoAuthorSuccess = ^(id obj) {
        suc(nil);
    };
    web.policyUrl = url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
    [pop dismissViewControllerAnimated:YES completion:nil];

}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}



@end
