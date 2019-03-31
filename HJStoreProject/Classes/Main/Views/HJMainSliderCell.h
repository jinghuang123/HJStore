//
//  HJMainSliderCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/30.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJSuperView.h"
#import "HJBannerModel.h"

@interface HJMainSliderView : UICollectionReusableView
/* 轮播图数组 url*/
@property (copy , nonatomic) NSArray *imageGroupArray;
/* 轮播图数组 图片对象 */
@property (copy , nonatomic) NSArray *bannerItems;

@property (copy , nonatomic) cellItemClick bannerCellItemClick;
@end

@interface HJMainSliderCell : UICollectionViewCell
/* 轮播图数组 url*/
@property (copy , nonatomic) NSArray *imageGroupArray;
/* 轮播图数组 图片对象 */
@property (copy , nonatomic) NSArray *bannerItems;

@property (copy , nonatomic) cellItemClick bannerCellItemClick;

@property (assign , nonatomic) BOOL showPageControl;
@end


