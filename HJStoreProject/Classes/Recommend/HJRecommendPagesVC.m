//
//  HJRecommendPagesVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/17.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJRecommendPagesVC.h"
#import <HMSegmentedControl.h>
#import "HMSegmentedControl+SelectionIndicatorLayer.h"
#import "HJRecommendRequest.h"
#import "HJRecommendVC.h"
#import "HJProductDetailVC.h"


@interface HJRecommendPagesVC ()
@property (strong, nonatomic) HMSegmentedControl *segment;
@property (nonatomic, strong) NSMutableArray *titles;
@property (nonatomic, strong) NSArray *categorys;
@end

@implementation HJRecommendPagesVC

- (instancetype)init {
    if (self = [super init]) {
        [[HJRecommendRequest shared] getRecommendCategorysWithId:@"0" success:^(NSArray* categorys) {
            self.categorys = categorys;
            for (HJRecommendCategorys *model in categorys) {
                HJRecommendVC *recommendVC = [[HJRecommendVC alloc] init];
                recommendVC.itemDidSelected = ^(GoodsItem *item) {
                    HJProductDetailVC *detailVC = [[HJProductDetailVC alloc] init];
                    detailVC.hidesBottomBarWhenPushed = YES;
                    detailVC.productId = [item.product_id integerValue];
                    [detailVC setNavBackItem];
                    [self.navigationController pushViewController:detailVC animated:YES];
                };
                recommendVC.category = model;
                [self.viewControllers addObject:recommendVC];
                [self.titles addObject:model.name];
            }
        } fail:^(NSError *error) {
            
        }];
    }
    return self;
}

- (NSMutableArray *)titles {
    if(!_titles){
        _titles = [[NSMutableArray alloc] init];
    }
    return _titles;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HMSegmentedControl *segment = [[HMSegmentedControl alloc] initWithSectionTitles:self.titles];
    self.segment = segment;
    
    [segment addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    segment.backgroundColor = [UIColor clearColor];
    segment.selectionIndicatorColor = [UIColor redColor];
    segment.titleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:14], NSForegroundColorAttributeName:[UIColor lightGrayColor]};
    segment.selectedTitleTextAttributes = @{NSFontAttributeName: [UIFont systemFontOfSize:16], NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#262f42"]};
    segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    CALayer *layer = segment.selectionIndicatorStripLayer;
    layer.cornerRadius = 2;
    layer.masksToBounds = YES;
    segment.selectionIndicatorHeight = 3;
    segment.frame = CGRectMake(0, 0, MaxWidth, 40);
    self.navigationItem.titleView = segment;
    [segment setUserDraggable:NO];
}

- (void)segmentedControlChangedValue:(UISegmentedControl *)sender {
    [self scrollToPageAtIndex:sender.selectedSegmentIndex animated:YES];
    
}

- (void)didEndDeceleratingToPageAtIndex:(NSInteger)index {
    [self.segment setSelectedSegmentIndex:index animated:YES];
}

@end
