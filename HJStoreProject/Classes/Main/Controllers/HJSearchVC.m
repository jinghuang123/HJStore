//
//  HJSearchVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/3.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSearchVC.h"
#import "HJSearchListVC.h"
#import "LLSearchView.h"


@interface HJSearchVC () <UISearchBarDelegate>
@property (nonatomic,strong) UITextField *textView;
@property (nonatomic,strong) LLSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@property (nonatomic, strong) NSMutableArray *historyArray;
@property (nonatomic, strong) UISearchBar *searchBar;

@end

@implementation HJSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setBarButtonItem];
    [self.view addSubview:self.searchView];
}

- (NSMutableArray *)hotArray
{
    if (!_hotArray) {
        self.hotArray = [NSMutableArray arrayWithObjects:@"悦诗风吟", @"洗面奶", @"兰芝", @"面膜", @"篮球鞋", @"阿迪达斯", @"耐克", @"运动鞋", nil];
    }
    return _hotArray;
}

- (NSMutableArray *)historyArray
{
    if (!_historyArray) {
        _historyArray = [NSKeyedUnarchiver unarchiveObjectWithFile:KHistorySearchPath];
        if (!_historyArray) {
            self.historyArray = [NSMutableArray array];
        }
    }
    return _historyArray;
}

- (LLSearchView *)searchView
{
    if (!_searchView) {
        self.searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, 64, MaxWidth, MaxHeight - 64) hotArray:self.hotArray historyArray:self.historyArray];
        weakify(self)
        _searchView.tapAction = ^(NSString *str) {
            [weak_self pushToSearchResultWithSearchStr:str];
        };
    }
    return _searchView;
}

- (void)setBarButtonItem
{
    [self.navigationItem setHidesBackButton:YES];
    // 创建搜索框
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(5, 7, self.view.frame.size.width, 30)];
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(titleView.frame) - 15, 30)];

    searchBar.placeholder = @"搜索内容";
    searchBar.backgroundImage = [UIImage imageNamed:@"clearImage"];
    searchBar.delegate = self;
    searchBar.showsCancelButton = YES;
    UITextField *searchTextField = searchTextField = [searchBar valueForKey:@"_searchField"];
    [searchTextField setValue:[UIFont systemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
    searchTextField.font = [UIFont systemFontOfSize:14];
    searchTextField.backgroundColor = RGBA(234, 235, 237, 1.0);;
    [searchBar setImage:[UIImage imageNamed:@"sort_magnifier"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    UIButton *cancleBtn = [searchBar valueForKey:@"cancelButton"];
    //修改标题和标题颜色
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [titleView addSubview:searchBar];
    self.searchBar = searchBar;
    [self.searchBar becomeFirstResponder];
    self.navigationItem.titleView = titleView;
    
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:nil];
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
    searchListVC.searchTip = str;
    [self.navigationController pushViewController:searchListVC animated:NO];
}




- (void)cancel {
    [self.searchBar resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
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
