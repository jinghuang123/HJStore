//
//  HJRecommendVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJRecommendVC.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "HJRecommendItemCell.h"
#import "HJShareMainImageView.h"
#import "HJProductDetailModel.h"
#import "HJMainRequest.h"


static NSString *const HJRecmomendItemCellIdentifier = @"HJRecmomendItemCell";

@interface HJRecommendVC () <UITableViewDelegate,UITableViewDataSource>
@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImage *shareImage;
@end

@implementation HJRecommendVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageSize = 20;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight - HJTopNavH) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = YES;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#f5f5f5"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
     [self.tableView registerNib:[UINib nibWithNibName:@"HJRecommendItemCell" bundle:nil] forCellReuseIdentifier:HJRecmomendItemCellIdentifier];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    [self.tableView.mj_header beginRefreshing];

}

- (void)setShareViewWithModel:(GoodsItem *)goodItem {
    HJProductDetailModel *detail = [[HJProductDetailModel alloc] init];
    detail.pict_url_image = goodItem.pict_url_image;
    detail.zk_final_price = goodItem.coupon_after_price;
    HJShareMainImageView *imageV = [[HJShareMainImageView alloc] initWithFrame:CGRectMake(MaxWidth, 0, 375, 667) andDetailModel:detail];
    [self.view addSubview:imageV];
    [self shareDataGet:[goodItem.product_id integerValue]];
}

- (void)shareDataGet:(NSInteger)productid {
//    [[HJMainRequest shared] getShareDataCache:YES productId:productid title:self.detailmodel.title url:self.detailmodel.coupon_click_url success:^(HJShareModel *share) {
//        HJShareVC *shareVC = [[HJShareVC alloc] init];
//        share.title = self.detailmodel.title;
//        share.product_id = self.productId;
//        share.reserve_price = self.detailmodel.reserve_price;
//        share.zk_final_price = self.detailmodel.zk_final_price;
//        share.coupon_value = self.detailmodel.coupon_value;
//        share.images = self.detailmodel.small_images;
//        share.mainImage = [weak_self getShareImage];
//        share.showCoupon = YES;
//        shareVC.shareModel = share;
//        [shareVC setNavBackItem];
//        [self.navigationController pushViewController:shareVC animated:YES];
//    } fail:^(NSError *error) {
//    }];
}



- (void)sharedAction {
    //    [[HJShareInstance shareInstance] shareToWechat:NO images:self.selectedImages callback:^(NSString *errorMsg) {
    //
    //    }];
    
    NSArray * items =  @[self.shareImage];    //分享图片 数组
    
    UIActivityViewController * activityCtl = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    //去除一些不需要的图标选项
    activityCtl.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                          UIActivityTypeAirDrop,
                                          UIActivityTypePostToTwitter,
                                          UIActivityTypeMessage,
                                          UIActivityTypeMail,
                                          UIActivityTypePrint,
                                          UIActivityTypeCopyToPasteboard,
                                          UIActivityTypeAssignToContact,
                                          UIActivityTypeSaveToCameraRoll,
                                          UIActivityTypeAddToReadingList ,
                                          UIActivityTypePostToFlickr ,
                                          UIActivityTypePostToVimeo,
                                          UIActivityTypePostToTencentWeibo,
                                          UIActivityTypeAirDrop ,
                                          UIActivityTypeOpenInIBooks];
    
    [self presentViewController:activityCtl animated:YES completion:nil];
    
}

- (void)headRefresh {
    self.pageNo = 1;
    [self refreshActionSuccess:^(id responseObject) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)footRefresh {
    self.pageNo++;
    [self refreshActionSuccess:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)refreshActionSuccess:(CompletionSuccessBlock)success {
    [[HJRecommendRequest shared] getRecommendListWithId:self.category.categoryId pageNo:self.pageNo pageSize:self.pageSize success:^(NSArray *items) {
        if (self.pageNo == 1) {
            [self.dataSource setArray:items];
             self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footRefresh)];
        }else{
            [self.dataSource addObjectsFromArray:items];
        }
        if (items.count < 20) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];//放到停止加载方法后面 不然会失效
        }
        [self.tableView reloadData];
        success(nil);
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:HJRecmomendItemCellIdentifier cacheByIndexPath:indexPath configuration:^(HJRecommendItemCell *cell) {
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJRecommendItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HJRecmomendItemCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.itemDidSelected = ^(GoodsItem *item) {
        if (self.itemDidSelected) {
            self.itemDidSelected(item);
        }
    };
    cell.shareClickBlock = ^(GoodsItem *item) {
        [self setShareViewWithModel:item];
    };
    [self setupModelOfCell:cell atIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 5)];
    view.backgroundColor = self.tableView.backgroundColor;
    return view;
}

- (void)setupModelOfCell:(HJRecommendItemCell *) cell atIndexPath:(NSIndexPath *) indexPath {
    cell.model = self.dataSource[indexPath.section];
    [cell.collectionView reloadData];
}

@end
