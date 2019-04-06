//
//  HJGeneralInfo.h
//  HJStoreProject
//
//  Created by kinghuang on 2019/4/5.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HJGeneralInfo :NSObject
@property (nonatomic , assign) CGFloat              money;
@property (nonatomic , assign) CGFloat              cumulative_money;
@property (nonatomic , assign) CGFloat              today_money;
@property (nonatomic , assign) NSInteger              today_money_count;
@property (nonatomic , assign) CGFloat              today_money_else;
@property (nonatomic , assign) CGFloat              yesterday_money;
@property (nonatomic , assign) NSInteger              yesterday_money_count;
@property (nonatomic , assign) CGFloat              yesterday_money_else;
@property (nonatomic , assign) CGFloat              month_money;
@property (nonatomic , assign) CGFloat              month_money_count;
@property (nonatomic , assign) CGFloat              last_month_real_money;
@property (nonatomic , assign) CGFloat              last_month_real_money_count;
@property (nonatomic , assign) CGFloat              last_month_money;
@property (nonatomic , assign) CGFloat              last_month_money_count;

@end


