//
//  HJMainPodVC.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "MYPresentedController.h"
//排序方式，1->综合，2->优惠券面值由低到高，3->优惠券面值由高到低，4->预估收益由高到低，5->卷后价由低到高，6->卷后价由高到低，7->销量由低到高，8->销量由高到低

typedef NS_ENUM(NSUInteger, HJSortType) {
    HJSortTypeTotal = 1,
    HJSortTypeHtoL,
    HJSortTypeLtoH,
    HJSortTypeEarnH,
    HJSortTypePriceLtoH,
    HJSortTypePriceHtoL,
    HJSortTypeShellCountLtoH,
    HJSortTypeShellCountHtoL,
};

@interface HJSortTypeSelectCell : UITableViewCell
@property (nonatomic ,strong) UILabel *itemName;
@end

@interface HJMainPodVC : MYPresentedController
@property (nonatomic ,assign) BOOL isPopState;
@property (nonatomic, copy) void(^popDismissBlock)(BOOL state);
@property (nonatomic, copy) void(^didSelectedRowBlock)(NSInteger row);
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,strong) NSArray *dataSource;
@property (nonatomic ,assign) CGPoint showViewPoint;
@property (nonatomic ,assign) CGSize viewSize;
@property (nonatomic ,assign) HJSortType selectedIndex;
@end


