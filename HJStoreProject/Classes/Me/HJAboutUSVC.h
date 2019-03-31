//
//  HJAboutUSVC.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/28.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJSuperViewController.h"


@interface HJAboutUSVC : HJSuperViewController <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end


