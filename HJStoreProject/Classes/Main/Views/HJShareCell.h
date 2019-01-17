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
typedef void(^didImagesSelectedUpdate)(id obj);
typedef void(^imageViewSelected)(int state);
@interface HJShareCell : UITableViewCell
@property (nonatomic, copy) couponShowSelected couponShowBlock;
- (void)updateCellWithModel:(HJShareModel *)share;

@end


@interface HJShareImageView : UIImageView
@property (nonatomic,strong) UIButton *selBtn;
@property (nonatomic, copy) imageViewSelected imageSelectBlock;
@end

@interface HJShareImagesCell : UITableViewCell

@property (nonatomic, copy) didImagesSelectedUpdate didImagesSelectedUpdateBlock;
- (void)updateCellWithModel:(HJShareModel *)share;

- (NSArray *)getSelectedImages;
@end


