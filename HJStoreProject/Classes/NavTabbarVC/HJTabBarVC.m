//
//  HJTabBarVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJTabBarVC.h"


@interface HJTabBarVC ()
@property (nonatomic, strong) NSMutableArray *tabBarItems;
@end

@implementation HJTabBarVC

- (void)dealloc {
    NSLog(@"HJTabBarVC dealloc");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewContorller];
    self.selectedViewController = [self.viewControllers objectAtIndex:0]; //默认选择商城index为1
}

- (NSMutableArray *)tabBarItems {
    if (_tabBarItems == nil) {
        _tabBarItems = [NSMutableArray array];
    }
    return _tabBarItems;
}

#pragma mark - 添加子控制器
- (void)addChildViewContorller {
    NSArray *childArray = @[
                            @{HJStroeTabbarClassKey  : @"HJSegemengVC",
                              HJStroeTabbarTitleKey  : @"首页",
                              HJStroeTabbarImgKey    : @"icon_home_n",
                              HJStroeTabbarSelImgKey : @"icon_home"},
                            
                            @{HJStroeTabbarClassKey  : @"HJStroeTypeListVC",
                              HJStroeTabbarTitleKey  : @"分类",
                              HJStroeTabbarImgKey    : @"icon_category_n",
                              HJStroeTabbarSelImgKey : @"icon_category"},
                            
                            @{HJStroeTabbarClassKey  : @"HJRecommendPagesVC",
                              HJStroeTabbarTitleKey  : @"美粉圈",
                              HJStroeTabbarImgKey    : @"icon_Recommend_n",
                              HJStroeTabbarSelImgKey : @"icon_Recommend"},
                            
                            @{HJStroeTabbarClassKey  : @"HJMineVC",
                              HJStroeTabbarTitleKey  : @"我的",
                              HJStroeTabbarImgKey    : @"icon_me_n",
                              HJStroeTabbarSelImgKey : @"icon_me"},
                            ];
    [childArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
        UIViewController *vc = [NSClassFromString(dict[HJStroeTabbarClassKey]) new];
        HJNavigationVC *nav = [[HJNavigationVC alloc] initWithRootViewController:vc];
        UITabBarItem *item = nav.tabBarItem;
        item.image = [UIImage imageNamed:dict[HJStroeTabbarImgKey]];
        item.selectedImage = [[UIImage imageNamed:dict[HJStroeTabbarSelImgKey]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} forState:UIControlStateSelected];
        [item setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor lightGrayColor]} forState:UIControlStateNormal];
        [item setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} forState:UIControlStateNormal];
        item.title = dict[HJStroeTabbarTitleKey];
//        item.imageInsets = UIEdgeInsetsMake(6, 0,-6, 0);//（当只有图片的时候）需要自动调整
        [self addChildViewController:nav];
        // 添加tabBarItem至数组
        [self.tabBarItems addObject:vc.tabBarItem];
    }];
}

@end
