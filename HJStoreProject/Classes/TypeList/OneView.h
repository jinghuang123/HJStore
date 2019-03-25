//
//  OneView.h
//  LinkageMenu
//
//  Created by 风间 on 2017/3/10.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "HJSuperView.h"
#import "HJCategoryModel.h"



@interface OneView : HJSuperView <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSString *categoryId;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, copy) cellItemClick subCategoryCellClick;
@end
