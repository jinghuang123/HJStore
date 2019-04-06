//
//  HJStroeTypeListVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJStroeTypeListVC.h"
#import "LinkageMenuView.h"
#import "OneView.h"
#import "HJCategoryRequest.h"
#import "HJMainVC.H"
#import "HJSearchVC.h"


@interface HJStroeTypeListVC ()
@property (nonatomic,strong) NSMutableArray *dataSource;
@end

@implementation HJStroeTypeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[HJCategoryRequest shared] getCategoryCache:YES success:^(NSArray *categorys) {
        [self.dataSource setArray:categorys];
        [self setView];
    } fail:^(NSError *error) {
    }];
    [self setupNavItems];
}

- (void)setView {
    NSMutableArray *rightViews = [[NSMutableArray alloc] init];
    NSMutableArray *menutitles = [[NSMutableArray alloc] init];
    for (HJCategoryModel *category in self.dataSource) {
        OneView *rightView = [[OneView alloc] init];
        rightView.title = category.name;
        rightView.categoryId = category.categoryId;
        rightView.tag = [category.categoryId integerValue];
        [menutitles addObject:category.name];
        [rightViews addObject:rightView];
        weakify(self)
        rightView.subCategoryCellClick = ^(HJCategoryModel *model) {
            HJMainVC *productListVC = [[HJMainVC alloc] init];
            productListVC.hidesBottomBarWhenPushed = YES;
            productListVC.catteryId = model.categoryId;
            productListVC.headType  = HJMainVCProductListHeadTypeList;
            productListVC.listType = HJMainVCProductListTypeList;
            productListVC.showType = singleLineShowOneGoods;
            CGFloat pointY = MaxHeight >= ENM_SCREEN_H_X ? 128 : 103;
            productListVC.showPopPoint = CGPointMake(0, pointY);
            [weak_self.navigationController pushViewController:productListVC animated:YES];
        };
    }
    LinkageMenuView *lkMenu = [[LinkageMenuView alloc] initWithFrame:CGRectMake(0, HJNavH , MaxWidth , MaxHeight - HJTabH) WithMenu:menutitles andViews:rightViews];
    lkMenu.ItemSelectedBlock = ^(OneView *rightView) {
        [[HJCategoryRequest shared] getSubCategoryCache:YES parentId:rightView.categoryId success:^(NSArray *categorys) {
            NSLog(@"rightViewTag = %ld",rightView.tag);
            [rightView setDataArray:categorys];
        } fail:^(NSError *error) {
        }];
    };
    [lkMenu setDefaultViewContent];
    [self.view addSubview:lkMenu];
    
}

- (NSMutableArray *)dataSource {
    if(!_dataSource){
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)setupNavItems {
    UIButton *leftNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftNav setBackgroundImage:[UIImage imageNamed:@"main_Nav_left"] forState:UIControlStateNormal];
    [leftNav addTarget:self action:@selector(onClickLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithCustomView:leftNav];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    
    UIButton *rightNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNav setBackgroundImage:[UIImage imageNamed:@"main_Nav_right"] forState:UIControlStateNormal];
    [rightNav addTarget:self action:@selector(onClickRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNav];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //设置圆角效果
    bgView.layer.cornerRadius = 14;
    bgView.layer.masksToBounds = YES;
    
    bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [bgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        HJSearchVC *searchvc = [[HJSearchVC alloc] init];
        searchvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchvc animated:YES];
    }];
    
    UIImageView *searchIcon= [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_search_icon"]];
    searchIcon.frame = CGRectMake(5, 6, 22, 18);
    [bgView addSubview:searchIcon];
    UILabel *tiplabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 2.5, 280, 25)];
    tiplabel.text = @"粘粘宝贝标题，先领劵省钱再购物";
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
