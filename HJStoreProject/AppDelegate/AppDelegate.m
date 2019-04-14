//
//  AppDelegate.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "AppDelegate.h"
#import "HJTabBarVC.h"
#import "HJMainRequest.h"
#import "HJCategoryRequest.h"
#import "AlibcManager.h"
#import "HJShareInstance.h"
#import "HJPopToSearchViewController.h"
#import "HJSearchListVC.h"
#import "HJUserInfoModel.h"
#import "HJSystemInfoInstance.h"
#define kLastSearchKey @"kLastSearchKey"

@interface AppDelegate ()
@property (nonatomic, strong) HJPopToSearchViewController *searchPodVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    [AlibcManager shared];
    
    [[HJShareInstance shareInstance] registerShareSDK];
    [[HJSystemInfoInstance shared] getSearchHots];
    [[HJCategoryRequest shared] getCategoryCache:NO success:^(id responseObject) {
    } fail:^(NSError *error) {
    }];
    
    
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if (userInfo.token && userInfo.token.length > 0) {
        [[HJMainRequest shared] getEarningConfigerSuccess:^(HJEarningModel *earning) {
        } fail:^(NSError *error) {
        }];
    }
    
    
    [NSThread sleepForTimeInterval:0.5];
    HJTabBarVC *tabbarVc = [[HJTabBarVC alloc] init];
    self.window.rootViewController = tabbarVc;
    
    return YES;
}





- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    NSString *lastStr = [NSUserDefaults jk_stringForKey:kLastSearchKey];
    if(pasteboard.string && ![lastStr isEqualToString:pasteboard.string] && ![pasteboard.string isEqualToString:@""]){
        [self popSearchView:pasteboard.string];
        [NSUserDefaults jk_setObject:pasteboard.string forKey:kLastSearchKey];
    }else{
        
    }
  
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.

}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    
    // 新接口写法
    if (![[AlibcTradeSDK sharedInstance] application:application
                                             openURL:url
                                             options:options]) {
        //处理其他app跳转到自己的app，如果百川处理过会返回YES
    }
    return YES;
}

- (void)popSearchView:(NSString *)searchTip {
    self.searchPodVC = [[HJPopToSearchViewController alloc] initWithShowFrame:CGRectMake(0, 0 ,MaxWidth, MaxHeight)
                                                      ShowStyle:MYPresentedViewShowStyleSuddenStyle
                                                       callback:^(id obj) {
                                                   
                                                       }];
    self.searchPodVC.clearBack = YES;
    self.searchPodVC.searchTip = searchTip;
    weakify(self)
    self.searchPodVC.searchBlock = ^(NSString *key) {
        HJSearchListVC *searchList = [[HJSearchListVC alloc] init];
        searchList.searchTip = key;
        [weak_self.searchPodVC dismissViewControllerAnimated:YES completion:nil];
        HJTabBarVC *tabBar = (HJTabBarVC *)weak_self.window.rootViewController;
        HJNavigationVC *controller = [tabBar.viewControllers objectAtIndex:tabBar.selectedIndex];
        UIViewController *vc = controller.topViewController;
        searchList.hidesBottomBarWhenPushed = YES;
        [vc.navigationController pushViewController:searchList animated:YES];
    };
    [self.window.rootViewController presentViewController:self.searchPodVC animated:YES completion:nil];
}


@end
