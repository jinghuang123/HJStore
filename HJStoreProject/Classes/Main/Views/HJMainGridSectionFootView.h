//
//  HJMainGridSectionFootView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/3.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HJMainGridSectionFootView : UICollectionReusableView
@property (nonatomic,strong) NSArray *titles;
@property (nonatomic,copy) void(^rollingDidSelected)(NSInteger index);
@end


