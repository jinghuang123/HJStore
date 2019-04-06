//
//  HJUserInfoFootView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/24.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface HJUserInfoFootView : UITableViewHeaderFooterView
@property (nonatomic,strong) UIButton *quiteButton;
@property (nonatomic,copy) void(^commitBlock)(id obj);
@end


