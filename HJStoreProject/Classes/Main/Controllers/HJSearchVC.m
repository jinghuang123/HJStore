//
//  HJSearchVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/3.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSearchVC.h"
#import "HJSearchListVC.h"

#import "HJSystemInfoInstance.h"

@interface HJSearchVC () 
@property (nonatomic,strong) UITextField *textView;
@property (nonatomic,strong) LLSearchView *searchView;
@property (nonatomic, strong) NSMutableArray *hotArray;
@end

@implementation HJSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.searchView];

}

- (NSMutableArray *)hotArray {
    if (!_hotArray) {
        self.hotArray = [HJSystemInfoInstance shared].searchHots;
    }
    return _hotArray;
}

- (LLSearchView *)searchView {
    if (!_searchView) {
        self.searchView = [[LLSearchView alloc] initWithFrame:CGRectMake(0, 40, MaxWidth, MaxHeight) hotArray:self.hotArray historyArray:nil];
        weakify(self)
        _searchView.tapAction = ^(NSString *str) {
            [weak_self pushToSearchResultWithSearchStr:str];
        };
    }
    return _searchView;
}

- (void)pushToSearchResultWithSearchStr:(NSString *)str {
    if (self.onItemTapClick) {
        self.onItemTapClick(str);
    }
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
