//
//  HHBlogAssetView.h
//  Smartpaw
//
//  Created by zhangxq on 2017/8/18.
//  Copyright © 2017年 hihisoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HHBlogAssetView : UIImageView
@property (strong, nonatomic, readonly) UIImageView *videoIcon;
@property(nonatomic,assign) BOOL isVideo;
@property(nonatomic,assign) BOOL isblurImage;
@end
