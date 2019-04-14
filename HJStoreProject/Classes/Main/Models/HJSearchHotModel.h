//
//  HJSearchHotModel.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/4/14.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJSearchHotModel :NSObject
@property (nonatomic , copy) NSString              * hot_id;
@property (nonatomic , copy) NSString              * keyword;
@property (nonatomic , assign) NSInteger              num;
@property (nonatomic , assign) NSInteger              updatetime;

@end
