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
@interface HJSegemengVC()
@property (strong , nonatomic) UITextField *textField;
@end
@implementation HJSegemengVC

- (void)viewDidLoad {
    [super viewDidLoad];
    HJMainVC *mainVC1 = [[HJMainVC alloc] init];
    HJMainVC *mainVC2 = [[HJMainVC alloc] init];
    HJMainVC *mainVC3 = [[HJMainVC alloc] init];
    HJMainVC *mainVC4 = [[HJMainVC alloc] init];
    HJMainVC *mainVC5 = [[HJMainVC alloc] init];
    HJMainVC *mainVC6 = [[HJMainVC alloc] init];
    HJMainVC *mainVC7 = [[HJMainVC alloc] init];
    HJMainVC *mainVC8 = [[HJMainVC alloc] init];
    HJMainVC *mainVC9 = [[HJMainVC alloc] init];
    HJMainVC *mainVC10 = [[HJMainVC alloc] init];
    NSArray* names = @[@"头条",@"视频",@"娱乐",@"体育",@"段子",@"新时代",@"本地",@"网易号",@"微咨询",@"财经"];
    NSArray* controllers = @[mainVC1,mainVC2,mainVC3,mainVC4,mainVC5,mainVC6,mainVC7,mainVC8,mainVC9,mainVC10];
    
    
    /*
     *   controllers长度和names长度必须一致，否则将会导致cash
     *   segmentController在一个屏幕里最多显示6个按钮，如果超过6个，将会自动开启滚动功能，如果不足6个，按钮宽度=父view宽度/x  (x=按钮个数)
     */
    ZXSegmentController* segmentController = [[ZXSegmentController alloc] initWithControllers:controllers
                                                                               withTitleNames:names
                                                                             withDefaultIndex:8
                                                                               withTitleColor:[UIColor grayColor]
                                                                       withTitleSelectedColor:[UIColor redColor]
                                                                              withSliderColor:[UIColor redColor]];
    [self.view addSubview:segmentController.view];
    [segmentController didMoveToParentViewController:self];
    [segmentController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(64);
        make.left.right.bottom.mas_equalTo(0);
    }];
    [self setupNavItems];
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
