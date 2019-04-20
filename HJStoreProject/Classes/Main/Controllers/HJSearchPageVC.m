//
//  HJSearchPageVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSearchPageVC.h"
#import <HMSegmentedControl.h>
#import "HMSegmentedControl+SelectionIndicatorLayer.h"
#import "HJSearchVC.h"
#import "HJSearchListVC.h"

@interface HJSearchPageVC () <UISearchBarDelegate>
@property (nonatomic, strong) HMSegmentedControl *segment;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation HJSearchPageVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (instancetype)init {
    if(self = [super init]) {
        for (NSInteger i = 1; i < 3; i++) {
            weakify(self)
            HJSearchVC *searchVC = [[HJSearchVC alloc] init];
            searchVC.search_type = i;
            searchVC.onItemTapClick = ^(NSString *str) {
                [weak_self pushToSearchResultWithSearchStr:str];
            };
            [self.viewControllers addObject:searchVC];
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBarButtonItem];
    // Do any additional setup after loading the view.
    CGFloat originY = MaxHeight >= ENM_SCREEN_H_X ? 84 : 64;
    NSArray *titles = @[@"APP内搜索",@"全网搜索"];
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

- (void)setBarButtonItem {
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width - 40, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 40, 30)];
    
    searchBar.placeholder = @"搜索内容";
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    UITextField *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
    [searchTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.backgroundColor = RGBA(234, 235, 237, 1.0);;
    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier2"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    cancleBtn.hidden = YES;

    
    UIButton *rightNav = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightNav setBackgroundImage:[UIImage imageNamed:@"search_Nav_right"] forState:UIControlStateNormal];
    [rightNav setTitle:@"搜索" forState:UIControlStateNormal];
    rightNav.titleLabel.font = [UIFont systemFontOfSize:11];
    rightNav.titleLabel.textColor = [UIColor whiteColor];
    [rightNav addTarget:self action:@selector(onClickSearch) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightNav];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
}

- (void)onClickSearch {
    NSString *searchStr = self.searchBar.text;
    [self pushToSearchResultWithSearchStr:searchStr];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self pushToSearchResultWithSearchStr:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
}

- (void)pushToSearchResultWithSearchStr:(NSString *)str {
    HJSearchListVC *searchListVC = [[HJSearchListVC alloc] init];
    searchListVC.search_type = self.segment.selectedSegmentIndex+1;
    searchListVC.searchTip = str;
    [self.navigationController pushViewController:searchListVC animated:NO];
}


- (void)segmentedControlChangedValue:(UISegmentedControl *)sender {
    [self scrollToPageAtIndex:sender.selectedSegmentIndex animated:YES];
    
}

- (void)didEndDeceleratingToPageAtIndex:(NSInteger)index {
    [self.segment setSelectedSegmentIndex:index animated:YES];
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
