//
//  HHPagerViewController.h
//  Smartpaw
//
//  Created by zhangxq on 2017/10/30.
//  Copyright © 2017年 hihisoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJSuperViewController.h"

@class HHPagerViewController;
@protocol HHPagerViewControllerDelegate<NSObject>
- (UIViewController *)pagerViewController:(HHPagerViewController *)pager
                   controllerForIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfChildViewControllersForPagerViewController:(HHPagerViewController *)pager;
@end

@interface HHPagerViewController : HJSuperViewController
@property (nonatomic, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong, readonly) UICollectionView *collectionView;
- (void)scrollToPageAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)didEndDeceleratingToPageAtIndex:(NSInteger)index;
@end
