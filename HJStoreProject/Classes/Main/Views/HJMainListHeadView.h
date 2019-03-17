//
//  HJMainListHeadView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^itemClickBlock)(id obj);
typedef void(^switchValueChangeBlock)(BOOL on);
@interface HJMainListHeadView : UICollectionReusableView

@end

@interface HJSortIcon : UIView
- (instancetype)initWithTitle:(NSString *)title;
@property (nonatomic, strong) UILabel *sortTitle;
@property (nonatomic, strong) UIImageView *sortImageView;
@end

@interface HJMainListHeadViewList : UICollectionReusableView

@property (nonatomic, copy) itemClickBlock showModeChangedBlock;
@property (nonatomic, copy) itemClickBlock sortTypeChengBlock;
@property (nonatomic, copy) switchValueChangeBlock switchChangeBlock;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) HJSortIcon *view1;
@property (nonatomic, strong) HJSortIcon *view2;
@property (nonatomic, strong) HJSortIcon *view3;
@end


