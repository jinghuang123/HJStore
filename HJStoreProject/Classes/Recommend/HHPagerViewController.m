//
//  HHPagerViewController.m
//  Smartpaw
//
//  Created by zhangxq on 2017/10/30.
//  Copyright © 2017年 hihisoft. All rights reserved.
//

#import "HHPagerViewController.h"

static NSString * const kHHPagerViewControllerCellReuseID = @"kHHPagerViewControllerCellReuseID";

@interface HHPagerViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation HHPagerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *containerView = [[UIView alloc]init];
    _containerView = containerView;
    [self.view addSubview:containerView];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsZero;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _layout = layout;
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView = collectionView;
    if (@available(iOS 11.0, *)) {
        _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kHHPagerViewControllerCellReuseID];
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    [containerView addSubview:collectionView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self layoutcontainerView];
    [self didLayoutcontainerView];
    self.collectionView.frame = self.containerView.bounds;
}

+ (BOOL)useBottomLayoutGuide {
    return YES;
}

- (void)layoutcontainerView {
    CGFloat top = self.topLayoutGuide.length;
    CGFloat bottom = [[self class] useBottomLayoutGuide] ? self.bottomLayoutGuide.length : 0;
    CGFloat height = CGRectGetHeight(self.view.frame) - top - bottom;
    self.containerView.frame = CGRectMake(0, top, CGRectGetWidth(self.view.frame), height);
}
- (void)didLayoutcontainerView {
    if (self.layout && !CGSizeEqualToSize(self.containerView.frame.size, self.layout.itemSize)) {
        self.layout.itemSize = self.containerView.frame.size;
        [self.collectionView reloadData];
    }
}

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [[NSMutableArray alloc] init];
    }
    return _viewControllers;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kHHPagerViewControllerCellReuseID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = indexPath.row < self.viewControllers.count ? self.viewControllers[indexPath.row] : nil;
    if (viewController) {
        [viewController beginAppearanceTransition:YES animated:NO];
        [cell.contentView addSubview:viewController.view];
        viewController.view.frame = cell.contentView.bounds;
        [viewController endAppearanceTransition];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = indexPath.row < self.viewControllers.count ? self.viewControllers[indexPath.row] : nil;
    if (viewController) {
        [viewController beginAppearanceTransition:NO animated:NO];
        [viewController.view removeFromSuperview];
        [viewController endAppearanceTransition];
    }
}

@synthesize viewControllers = _viewControllers;
- (void)setViewControllers:(NSArray<UIViewController *> *)viewControllers {
    [_viewControllers setArray:viewControllers];
    for (UIViewController *viewController in viewControllers) {
        [self addChildViewController:viewController];
        [viewController didMoveToParentViewController:self];
    }
    [self.collectionView reloadData];
}

- (void)scrollToPageAtIndex:(NSInteger)index animated:(BOOL)animated {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat width = CGRectGetWidth(self.containerView.frame);
    if (width > 0) {
        NSInteger index = round(scrollView.contentOffset.x / width);
        [self didEndDeceleratingToPageAtIndex:index];
    }
}

- (void)didEndDeceleratingToPageAtIndex:(NSInteger)index {}

@end
