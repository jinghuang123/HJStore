//
//  HJEarnDetailPage.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJEarnDetailPage.h"
#import "HJEarnDetailVC.h"
#import <HMSegmentedControl.h>
#import "HMSegmentedControl+SelectionIndicatorLayer.h"


@interface HJEarnDetailPage ()
@property (nonatomic, strong) HMSegmentedControl *segment;
@end

@implementation HJEarnDetailPage
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor jk_colorWithHexString:@"#E32828"];
}

- (instancetype)init {
    if(self = [super init]) {
        for (NSInteger i = 0; i < 2; i++) {
            HJEarnDetailVC *earnDetailList = [[HJEarnDetailVC alloc] init];
            earnDetailList.type = i;
            [self.viewControllers addObject:earnDetailList];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat originY = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    NSArray *titles = @[@"收益明细",@"订单维权"];
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    _segment = segment;
    [segment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segment.backgroundColor = [UIColor whiteColor];
    segment.selectionIndicatorColor = [UIColor redColor];
    segment.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#333333"],NSBaselineOffsetAttributeName:@(-10)};
    segment.selectedTitleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#E32828"]};
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    CALayer *layer = segment.selectionIndicatorStripLayer;
    layer.cornerRadius = 0.5;
    layer.masksToBounds = YES;
    segment.selectionIndicatorHeight = 1;
    segment.frame = CGRectMake(0, originY, MaxWidth, 40);
    [self.view addSubview:segment];
}


- (void)segmentedControlChangedValue:(UISegmentedControl *)sender {
    [self scrollToPageAtIndex:sender.selectedSegmentIndex animated:YES];
    
}

- (void)didEndDeceleratingToPageAtIndex:(NSInteger)index {
    [self.segment setSelectedSegmentIndex:index animated:YES];
}


@end
