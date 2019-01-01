//
//  HJProductDetailContentCell.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJProductDetailModel.h"
#import "HJSuperView.h"


@interface HJProductDetailContentCell : UITableViewCell
@property (nonatomic,copy) cellItemClick collectionSaveBlock;

- (void)setcontentWithModel:(HJProductDetailModel *)item;
@end


