//
//  HJShareCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJShareModel.h"
#import "HJRecommendModel.h"

typedef void(^didImagesSelectedUpdate)(id obj);
typedef void(^imageViewSelected)(int state);



@interface HJShareImageView : UIImageView
@property (nonatomic,strong) UIButton *selBtn;
@property (nonatomic, copy) imageViewSelected imageSelectBlock;
@end

@interface HJShareImagesCell : UITableViewCell

@property (nonatomic, copy) didImagesSelectedUpdate didImagesSelectedUpdateBlock;
- (void)updateCellWithShareModel:(HJShareModel *)share mainImage:(UIImage *)mainImage recommendInfo:(HJRecommendModel *)info;

- (NSArray *)getSelectedImages;
@end


