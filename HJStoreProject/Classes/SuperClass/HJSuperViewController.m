//
//  HJSuperViewController.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"

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
    btn.frame = CGRectMake(0, 10, 22, 22);
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



- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    return YES;
}

@end
