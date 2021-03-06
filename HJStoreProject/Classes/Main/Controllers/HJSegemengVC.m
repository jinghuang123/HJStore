//
//  HJSegemengVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2018/12/12.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSegemengVC.h"
#import "HJMainVC.h"
#import "HJMainRequest.h"
#import "SegmentView.h"
#import "HJSearchVC.h"
#import "AlibcManager.h"
#import "HJSettingRequest.h"
#import "HJMeizhiCustomServiceVC.h"
#import "HJSystemInfoInstance.h"
#import "HJSearchPageVC.h"

@interface HJSegemengVC()
@property (strong , nonatomic) UITextField *textField;
@property (strong , nonatomic) SegmentView *segmentView;
@end
@implementation HJSegemengVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[HJSystemInfoInstance shared] getSearchHots];
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([HJNetworkType isConnected]) {
        [[HJMainRequest shared] getMainCategoryCache:YES success:^(NSArray *categorys) {
            [self setTopItemsWithArray:categorys];
        } fail:^(NSError *error) {
            HJCategoryModelsSaved *savedCategorys = [HJCategoryModelsSaved getSavedCategoryModels];
            [self setTopItemsWithArray:savedCategorys.categorys];
        }];
    }else{
        HJCategoryModelsSaved *savedCategorys = [HJCategoryModelsSaved getSavedCategoryModels];
        [self setTopItemsWithArray:savedCategorys.categorys];
    }
    [self setupNavItems];
}

- (void)setTopItemsWithArray:(NSArray *)categorys {
    NSMutableArray *totalCategorys = [[NSMutableArray alloc] init];
    [totalCategorys setArray:categorys];
    HJCategoryModel *mainOneCat = [[HJCategoryModel alloc] init];
    mainOneCat.categoryId = 0;
    mainOneCat.name = @"精选";
    mainOneCat.parent_id = 0;
    [totalCategorys insertObject:mainOneCat atIndex:0];
    NSMutableArray *datas = [[NSMutableArray alloc] init];
    NSMutableArray *names = [[NSMutableArray alloc] init];
    for (HJCategoryModel *category in totalCategorys) {
        HJMainVC *mainVC = [[HJMainVC alloc] init];
        mainVC.listType = HJMainVCProductListTypeMain;
        mainVC.headType = category.categoryId == 0 ? HJMainVCProductListHeadTypeMain : HJMainVCProductListHeadTypeList;
        mainVC.showType = category.categoryId == 0 ? signleLineShowDoubleGoods : singleLineShowOneGoods;
        mainVC.catteryId = category.categoryId;
        [names addObject:category.name];
        [datas addObject:mainVC];
    }
    [self setupUIWithCategorys:datas names:names];
}

- (void)setupUIWithCategorys:(NSArray *)Cacontrollers names:(NSArray *)names {
//    UISegmentedControl
    CGFloat yOffset = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    if (!_segmentView) {
        SegmentView *segmentView = [[SegmentView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight) controllers:Cacontrollers titleArray:names parentController:self];
        segmentView.selectedIndex = 0;
        HJMainVC *mainVC = [Cacontrollers objectAtIndex:0];
        [mainVC onClickSegmentItem];
        _segmentView = segmentView;
    }
    [self.view addSubview:_segmentView];
    [_segmentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yOffset);
        make.left.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
    _segmentView.selectedItemHelper = ^(NSUInteger index) {
        HJMainVC *mainVC = [Cacontrollers objectAtIndex:index];
        [mainVC onClickSegmentItem];
    };
}

- (void)setupNavItems {
    UIButton *leftNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftNav setBackgroundImage:[UIImage imageNamed:@"meizhilogo"] forState:UIControlStateNormal];
    [leftNav addTarget:self action:@selector(onClickLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftNav];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    
    UIButton *rightNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNav setBackgroundImage:[UIImage imageNamed:@"main_Nav_right"] forState:UIControlStateNormal];
    [rightNav addTarget:self action:@selector(onClickRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNav];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 30)];
    //设置圆角效果
    bgView.layer.cornerRadius = 14;
    bgView.layer.masksToBounds = YES;
    
    bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [bgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        HJSearchPageVC *searchvc = [[HJSearchPageVC alloc] init];
        searchvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchvc animated:YES];
    }];
    UIImageView *searchIcon= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_search_icon"]];
    searchIcon.frame = CGRectMake(5, 6, 22, 18);
    [bgView addSubview:searchIcon];
    UILabel *tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 2.5, 280, 25)];
    tiplabel.text = @"粘粘宝贝标题，先领券省钱再购物";
    tiplabel.textColor = [UIColor grayColor];
    tiplabel.textAlignment = NSTextAlignmentLeft;
    tiplabel.font = [UIFont systemFontOfSize:13];
    [bgView addSubview:tiplabel];

    
    self.navigationItem.titleView = bgView;
}


- (void)onClickSearchBtn {

}
- (void)onClickLeft {
    
}
- (void)onClickRight {
    
    [[HJSettingRequest shared] getServiceInfoSuccess:^(HJServiceInfoModel *service) {
        HJMeizhiCustomServiceVC *serviceVC = [[HJMeizhiCustomServiceVC alloc] init];
        serviceVC.serviceInfo = service;
        serviceVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:serviceVC animated:YES];
    } fail:^(NSError *error) {
        
    }];
    
}
@end
