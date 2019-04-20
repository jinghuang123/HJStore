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
#import "HJMainSliderCell.h"
#import "HJSettingRequest.h"


static NSString *const HJRecmomendItemCellIdentifier = @"HJRecmomendItemCell";

@interface HJRecommendVC () <UITableViewDelegate,UITableViewDataSource>
@property (assign , nonatomic) NSInteger pageNo;
@property (assign , nonatomic) NSInteger pageSize;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, strong) NSArray *banners;
@property (nonatomic, strong) NSMutableArray *shareImages;
@property (nonatomic, strong) HJMainSliderView *adSliderCellView;
@end

@implementation HJRecommendVC

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] init];
    }
    return _dataSource;
}

- (NSMutableArray *)shareImages {
    if(!_shareImages) {
        _shareImages = [[NSMutableArray alloc] init];
    }
    return _shareImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    CGFloat navH = MaxHeight >= ENM_SCREEN_H_X ? HJTopNavH + 60 : HJTopNavH;
    self.pageSize = 20;
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight - navH) style:UITableViewStylePlain];
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

- (void)setShareViewWithModel:(HJRecommendModel *)goodItem {
    HJShareMainImageView *imageV = [[HJShareMainImageView alloc] initWithFrame:CGRectMake(MaxWidth, 0, 375, 667) andDetailModel:goodItem];
    [self.view addSubview:imageV];
    [self getShareImage:imageV success:^(UIImage *shareImage) {
        [self.shareImages addObject:shareImage];
    }];
}

- (void)getShareImage:(UIView *)imageView success:(CompletionSuccessBlock)success {
    UIGraphicsBeginImageContextWithOptions(imageView.mj_size,NO, 0.0);//设置截屏大小
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    success(image);
}


- (void)sharedAction {
    NSArray * items = self.shareImages;    //分享图片 数组
    
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
    
    [[HJSettingRequest shared] getBannersWithType:3 Success:^(NSArray *banners) {
        self.adSliderCellView.bannerItems = banners;
        self.banners = banners;
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (HJBannerModel *banner in banners) {
            NSString *realUrl = [banner.banner_image hasPrefix:@"http"] ? banner.banner_image : [NSString stringWithFormat:@"%@%@",kHHWebServerBaseURL,banner.banner_image];
            [images addObject:realUrl];
        }
        self.adSliderCellView.imageGroupArray = images;
        [self.tableView reloadData];
    } fail:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return self.banners.count > 0 ? 150 : 0;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CGFloat adViewH = self.banners.count > 0 ? 150 : 0;
    if (!self.adSliderCellView) {
        HJMainSliderView *adSliderCellView = [[HJMainSliderView alloc] initWithFrame:CGRectMake(8, 0, MaxWidth, adViewH)];
        _adSliderCellView = adSliderCellView;
        adSliderCellView.backgroundColor = [UIColor clearColor];
        adSliderCellView.imageGroupArray = @[@""];
        [self.view addSubview:adSliderCellView];
        [adSliderCellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.right.mas_offset(0);
            make.height.mas_equalTo(adViewH);
            make.top.mas_offset(0);
        }];
        adSliderCellView.bannerCellItemClick = ^(HJBannerModel *banner) {
            //        [self onItemClickWithType:HJClickItemTypeADS params:banner];
        };
    }
    return self.adSliderCellView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self.tableView fd_heightForCellWithIdentifier:HJRecmomendItemCellIdentifier cacheByIndexPath:indexPath configuration:^(HJRecommendItemCell *cell) {
        [self setupModelOfCell:cell atIndexPath:indexPath];
    }] + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJRecommendItemCell *cell = [tableView dequeueReusableCellWithIdentifier:HJRecmomendItemCellIdentifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    cell.itemDidSelected = ^(HJRecommendModel *item) {
        if (self.itemDidSelected) {
            self.itemDidSelected(item);
        }
    };
    cell.shareClickBlock = ^(HJRecommendItemModel *item) {
        [self.shareImages removeAllObjects];
        [self shareWithItem:item];
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
    cell.model = self.dataSource[indexPath.row];
    [cell.collectionView reloadData];
}


- (void)shareWithItem:(HJRecommendItemModel *)item {
    if (self.shareClick) {
        self.shareClick(item);
    }
}

@end
