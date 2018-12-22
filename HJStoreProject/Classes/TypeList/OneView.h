//
//  OneView.h
//  LinkageMenu
//
//  Created by 风间 on 2017/3/10.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJCategoryModel.h"

@interface OneView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, assign) NSInteger categoryId;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;

@end
