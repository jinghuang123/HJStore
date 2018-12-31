//
//  OneView.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/10.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "OneView.h"
#import "HJGridCell.h"
@interface OneView()


@end

static NSString *const HJGridCellIdentifier = @"HJGridCell";

@implementation OneView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {

    }
    return self;
}


- (void)setDataArray:(NSArray *)dataArray{
    
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[HJGridCell class] forCellWithReuseIdentifier:HJGridCellIdentifier];
        _collectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.collectionView];
    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat cellWidth = (self.frame.size.width - 5.0) / 3.0;
    CGFloat cellHeight = itemsize + 30;
    return CGSizeMake(cellWidth, cellHeight);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGridCellIdentifier forIndexPath:indexPath];
    HJCategoryModel *subCategory = [self.dataArray objectAtIndex:indexPath.row];
    [cell updeteCellWithGridItem:subCategory];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJCategoryModel *subCategory = [self.dataArray objectAtIndex:indexPath.row];
    NSLog(@"HJCategoryModel ID:%ld",subCategory.categoryId);
    if (self.subCategoryCellClick) {
        self.subCategoryCellClick(subCategory);
    }
}

@end
