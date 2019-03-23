//
//  HJOrderListItemModel.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/23.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface HJOrderListItemModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *order_id;
@property (nonatomic, strong) NSString *pay_price;
@property (nonatomic, strong) NSString *commission;
@property (nonatomic, assign) NSInteger create_time;
@property (nonatomic, strong) NSString *earning_time;
@property (nonatomic, strong) NSString *num_iid;
@property (nonatomic, strong) NSString *image;
@end


