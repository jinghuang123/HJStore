//
//  HJFencePageVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/26.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJFencePageVC.h"
#import "HJFenceListVC.h"
#import <HMSegmentedControl.h>
#import "HMSegmentedControl+SelectionIndicatorLayer.h"


@interface HJFencePageVC ()
@property (nonatomic, strong) HMSegmentedControl *segment;
@end

@implementation HJFencePageVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (instancetype)init {
    if(self = [super init]) {
        for (NSInteger i = 0; i < 3; i++) {
            HJFenceListVC *fenceListVC = [[HJFenceListVC alloc] init];
            [self.viewControllers addObject:fenceListVC];
        }
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *titles = @[@"全部粉丝",@"直属粉丝",@"推荐粉丝"];
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:titles];
    _segment = segment;
    [segment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segment.backgroundColor = [UIColor clearColor];
    segment.selectionIndicatorColor = [UIColor redColor];
    segment.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:13], NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    segment.selectedTitleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15], NSForegroundColorAttributeName:[UIColor redColor]};
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    CALayer *layer = segment.selectionIndicatorStripLayer;
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    segment.selectionIndicatorHeight = 3;
    segment.frame = CGRectMake(0, 64, MaxWidth, 44);
    [self.view addSubview:segment];
}

- (void)segmentedControlChangedValue:(UISegmentedControl *)sender {
    [self scrollToPageAtIndex:sender.selectedSegmentIndex animated:YES];
    
}

- (void)didEndDeceleratingToPageAtIndex:(NSInteger)index {
    [self.segment setSelectedSegmentIndex:index animated:YES];
}

@end
