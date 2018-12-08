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

@interface HJStroeTypeListVC ()

@end

@implementation HJStroeTypeListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *menutitles = @[@"为您推荐",@"美容美妆",@"奶粉纸尿裤",@"母婴专区",@"箱包配饰",@"家居个护",@"营养保健",@"服饰鞋靴",@"海外直邮",@"数码家电",@"环球美食",@"运动户外",@"生鲜",@"国家馆",@"品牌馆"];
    NSMutableArray *views = [[NSMutableArray alloc] init];
    for (NSString *title in menutitles) {
        OneView *view = [[OneView alloc] init];
        HJGridItem *grid = [[HJGridItem alloc] init];
        view.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        [views addObject:view];
    }
    LinkageMenuView *lkMenu = [[LinkageMenuView alloc] initWithFrame:CGRectMake(0, 0,MaxWidth , MaxHeight - HJTabH) WithMenu:menutitles andViews:views];
    [self.view addSubview:lkMenu];
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
