//
//  HJSegemengVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2018/12/12.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJSegemengVC.h"
#import "ZXSegmentController.h"
#import "HJMainVC.h"
#import "HJMainRequest.h"

@interface HJSegemengVC()
@property (strong , nonatomic) UITextField *textField;
@end
@implementation HJSegemengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[HJMainRequest shared] getMainCategoryCache:YES success:^(NSArray *categorys) {
        NSMutableArray *datas = [[NSMutableArray alloc] init];
        NSMutableArray *names = [[NSMutableArray alloc] init];
        for (HJCategoryModel *category in categorys) {
            HJMainVC *mainVC = [[HJMainVC alloc] init];
            mainVC.listType = HJMainVCProductListTypeMain;
            mainVC.headType = category.categoryId == 0 ? HJMainVCProductListHeadTypeMain : HJMainVCProductListHeadTypeList;
            mainVC.showType = category.categoryId == 0 ? signleLineShowDoubleGoods : singleLineShowOneGoods;
            mainVC.catteryId = category.categoryId;
            [names addObject:category.name];
            [datas addObject:mainVC];
        }
        [self setupUIWithCategorys:datas names:names];
    } fail:^(NSError *error) {
        
    }];
    [self setupNavItems];
}

- (void)setupUIWithCategorys:(NSArray *)Cacontrollers names:(NSArray *)names {
    ZXSegmentController* segmentController = [[ZXSegmentController alloc] initWithControllers:Cacontrollers
                                                                               withTitleNames:names
                                                                             withDefaultIndex:0
                                                                               withTitleColor:[UIColor grayColor]
                                                                       withTitleSelectedColor:[UIColor redColor]
                                                                              withSliderColor:[UIColor redColor]];
    [self.view addSubview:segmentController.view];
    [segmentController didMoveToParentViewController:self];
    CGFloat yOffset = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    [segmentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(yOffset);
        make.left.bottom.mas_offset(0);
        make.right.mas_offset(0);
    }];
}

- (void)setupNavItems {
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navRight"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;

    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navRight"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickRight)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    
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
@end
