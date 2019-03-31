//
//  OneView.m
//  LinkageMenu
//
//  Created by 风间 on 2017/3/10.
//  Copyright © 2017年 EmotionV. All rights reserved.
//

#import "OneView.h"
#import "HJGridCell.h"

@interface HJOneViewHead()

@end

@implementation HJOneViewHead

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]){
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(10);
        make.height.mas_equalTo(35);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5];
    [self addSubview:lineView];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-1);
        make.height.mas_equalTo(0.5);
    }];
}


@end

@interface OneView()


@end

static NSString *const HJGridCellIdentifier = @"HJGridCell";
static NSString *const HJOneViewHeadViewIdentifier = @"HJOneViewHeadView";

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
        [_collectionView registerClass:[HJOneViewHead class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJOneViewHeadViewIdentifier];

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
    CGFloat cellHeight = 65;
    return CGSizeMake(cellWidth, cellHeight);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] init];
    if (kind == UICollectionElementKindSectionHeader){
        HJOneViewHead *headerView = [collectionView  dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HJOneViewHeadViewIdentifier forIndexPath:indexPath];
        headerView.backgroundColor = [UIColor whiteColor];
        headerView.titleLabel.text = self.title;
        reusableview = headerView;
    }
    return reusableview;
}

#pragma mark - head宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.frame.size.width, 55); //section高
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HJGridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HJGridCellIdentifier forIndexPath:indexPath];
    HJCategoryModel *subCategory = [self.dataArray objectAtIndex:indexPath.row];
    [cell updeteCellWithGridItem:subCategory];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    HJCategoryModel *subCategory = [self.dataArray objectAtIndex:indexPath.row];
    NSLog(@"HJCategoryModel ID:%@",subCategory.categoryId);
    if (self.subCategoryCellClick) {
        self.subCategoryCellClick(subCategory);
    }
}

@end
