//
//  HJShareVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareVC.h"
#import "HJShareCell.h"
#import "HJShareInstance.h"

@interface HJShareVC ()  <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) NSArray *selectedImages;
@end

@implementation HJShareVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableview];
    // Do any additional setup after loading the view.
    [self setupButtons];
}

- (UITableView *)tableview {
    if (!_tableview) {
        UITableView *tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight - 49)];
        _tableview = tableView;
        tableView.backgroundColor = RGB(245, 245, 245);;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;

        tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headRefresh)];
    }
    return _tableview;
}

- (void)setupButtons {
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setTitle:@"复制淘口令" forState:UIControlStateNormal];
    [copyButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    copyButton.layer.cornerRadius = 3;
    copyButton.layer.borderColor = [UIColor redColor].CGColor;
    copyButton.layer.borderWidth = 1.0;
    copyButton.titleLabel.font = PFR13Font;
    copyButton.clipsToBounds = YES;
    [self.view addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-5);
        make.width.mas_equalTo((MaxWidth - 30)/2);
        make.height.mas_equalTo(39);
    }];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"分享图片" forState:UIControlStateNormal];
    [shareButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = PFR13Font;
    shareButton.layer.borderColor = [UIColor redColor].CGColor;
    shareButton.layer.cornerRadius = 3;
    shareButton.layer.borderWidth = 1.0;
    shareButton.clipsToBounds = YES;
    [shareButton addTarget:self action:@selector(sharedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:shareButton];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-5);
        make.width.mas_equalTo((MaxWidth - 30)/2);
        make.height.mas_equalTo(39);
    }];
}


- (void)sharedAction {
    NSArray * items =  self.selectedImages;    //分享图片 数组
    
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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.tableview.mj_header endRefreshing];
    });
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 10)];
        view.backgroundColor = self.tableview.backgroundColor;
        return view;
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, 0)];
        view.backgroundColor = self.tableview.backgroundColor;
        return view;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HJShareCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJShareCell"];
        if (!cell) {
            cell = [[HJShareCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HJShareCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellWithModel:self.shareModel];
        weakify(self)
        cell.couponShowBlock = ^(id obj) {
            weak_self.shareModel.showCoupon = !self.shareModel.showCoupon;
            [weak_self.tableview reloadData];
        };
        return cell;
    }else{
        HJShareImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJShareImagesCell"];
        if (!cell) {
            cell = [[HJShareImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HJShareImagesCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell updateCellWithModel:self.shareModel];
        self.selectedImages = [cell getSelectedImages];
        cell.didImagesSelectedUpdateBlock = ^(NSArray *images) {
            self.selectedImages = images;
        };
        return cell;
    }
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return self.shareModel.showCoupon ? 240 : 225;
    }else{
        return (MaxWidth - 50)/2 * 667/375 + 20;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}
@end
