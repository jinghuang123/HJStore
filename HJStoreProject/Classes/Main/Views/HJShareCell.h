//
//  HJShareCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJShareModel.h"

typedef void(^couponShowSelected)(id obj);
@interface HJShareCell : UITableViewCell
@property (nonatomic, copy) couponShowSelected couponShowBlock;
- (void)updateCellWithModel:(HJShareModel *)share;

@end


@interface HJShareImageView : UIImageView
@property (nonatomic,strong) UIButton *selBtn;
@end

@interface HJShareImagesCell : UITableViewCell
- (void)updateCellWithModel:(HJShareModel *)share;
@end


