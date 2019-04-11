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
    self.title = @"创建分享";
    [self setupButtons];
}

- (UITableView *)tableview {
    if (!_tableview) {
        UITableView *tableView  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MaxWidth, MaxHeight - 49)];
        _tableview = tableView;
        tableView.backgroundColor = RGB(245, 245, 245);;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.delegate = self;
        tableView.dataSource = self;
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJShareImagesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HJShareImagesCell"];
    if (!cell) {
        cell = [[HJShareImagesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HJShareImagesCell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell updateCellWithShareModel:self.shareModel mainImage:self.mainShareImage recommendInfo:self.detailmodel];
    self.selectedImages = [cell getSelectedImages];
    cell.didImagesSelectedUpdateBlock = ^(NSArray *images) {
        self.selectedImages = images;
    };
    return cell;
    
}

-(CGFloat )tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 667;
}

@end
