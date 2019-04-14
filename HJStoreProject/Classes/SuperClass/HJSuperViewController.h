//
//  HJSuperViewController.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJTaobaoAuthorPopVC.h"


@interface HJSuperViewController : UIViewController
- (void)backButtonClick;
- (void)setNavBackItem;
- (void)pushToLoginVC:(BOOL)hideClose;
- (void)showTaobaoAuthorDailogSuccess:(CompletionSuccessBlock)success;
@end

