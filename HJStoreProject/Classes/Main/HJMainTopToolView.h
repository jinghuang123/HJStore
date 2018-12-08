//
//  HJMainTopToolView.h
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/3.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HJMainTopToolView : UIView
/** 左边Item点击 */
@property (nonatomic, copy) dispatch_block_t leftItemClickBlock;
/** 右边Item点击 */
@property (nonatomic, copy) dispatch_block_t rightItemClickBlock;
/** 搜索按钮点击点击 */
@property (nonatomic, copy) dispatch_block_t searchButtonClickBlock;
@end

NS_ASSUME_NONNULL_END
