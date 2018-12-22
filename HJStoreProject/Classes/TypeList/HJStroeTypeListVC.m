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
        rightView.categoryId = category.categoryId;
        rightView.tag = category.categoryId;
        [menutitles addObject:category.name];
        [rightViews addObject:rightView];
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

    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    //设置圆角效果
    bgView.layer.cornerRadius = 14;
    bgView.layer.masksToBounds = YES;
    
    bgView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    
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
