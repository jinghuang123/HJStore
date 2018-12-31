//
//  HJMainListHeadView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/22.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^itemClickBlock)(id obj);
@interface HJMainListHeadView : UICollectionReusableView

@end

@interface HJMainListHeadViewList : UICollectionReusableView
@property (nonatomic, copy) itemClickBlock showModeChangedBlock;
@property (nonatomic, copy) itemClickBlock sortTypeChengBlock;

@end


