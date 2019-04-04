//
//  HJRecommendItemCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/19.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJRecommendItemCell.h"
#import "ZQJNearbyMasterCollectionCell.h"



static NSString *cellReuseID = @"cellReuseID";

@implementation HJRecommendItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ZQJNearbyMasterCollectionCell class] forCellWithReuseIdentifier:cellReuseID];

}

- (void)setModel:(HJRecommendItemModel *)model{
    _model = model;
    [_headImageV sd_setImageWithURLString:model.avatar placeholderImage:PLACEHOLDER_ITEM];
    _nameLabel.text = model.nickname;
    _timeLabel.text = [[NSDate dateWithTimeIntervalSince1970:model.createtime] jk_longDateString];
    _timeLabel.textColor = [UIColor jk_colorWithHexString:@"#4f4f4f"];
    NSString *htmlString = model.content;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attributedString addAttribute:NSFontAttributeName
                     value:[UIFont systemFontOfSize:14]
                     range:NSMakeRange(0,attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:[UIColor jk_colorWithHexString:@"#333333"]
                             range:NSMakeRange(0,attributedString.length)];
    
    _contentLabel.attributedText = attributedString;
    [_contentLabel sizeToFit];
    
    CGFloat contentWid = MaxHeight >= ENM_SCREEN_H_X ? MaxWidth - 35 : MaxWidth - 20;
    _contentHeight.constant = [self Calculating_Text_Height_2_Width:contentWid WithString:attributedString];
    CGFloat width = MaxWidth - 45;
    if (self.model.goods.count + self.model.images.count ==0)
    {
        self.height.constant = 0;
    }
    else
    {
        NSInteger count = self.model.goods.count > 0 ? self.model.goods.count: self.model.images.count;
        count = count > 9 ? 9 : count;
        CGFloat height = ((count - 1) / 3 + 1) * (width / 3) + (count - 1) / 3 * 15 ;
            self.height.constant = height;
    }
    weakify(self)
    [self.shareView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if(weak_self.shareClickBlock) {
            weak_self.shareClickBlock(weak_self.model);
        }
    }];
}


#pragma mark - colletionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger count = self.model.goods.count > 0 ? self.model.goods.count: self.model.images.count;
    count = count > 9 ? 9 : count;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ZQJNearbyMasterCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellReuseID forIndexPath:indexPath];
    if (self.model.goods.count > 0) {
        HJRecommendModel *item = self.model.goods[indexPath.row];
        [cell.imgV sd_setImageWithURLString:item.pict_url placeholderImage:PLACEHOLDER_ITEM];
        NSString *coupons = [NSString stringWithFormat:@"¥%.2f",item.coupon_after_price];
        CGFloat wid = [NSString widthOfString:coupons font:[UIFont systemFontOfSize:12] height:20] + 5;
        cell.couponvalueLabel.text = coupons;
        [cell.couponvalueLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(wid);
        }];
    }else{
        NSString *url = self.model.images[indexPath.row];
        [cell.imgV sd_setImageWithURLString:url placeholderImage:PLACEHOLDER_ITEM];
    }

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = MaxWidth - 45;
    if (self.model.goods.count!=0)
    {
        return CGSizeMake(width / 3, width / 3);
    }else if(self.model.images.count !=0){
        return CGSizeMake(width / 3, width / 3);
    }
    return CGSizeZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeZero;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeZero;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.model.goods.count > 0) {
        HJRecommendModel *item = self.model.goods[indexPath.row];
        if (self.itemDidSelected) {
            self.itemDidSelected(item);
        }
    }
}

- (CGFloat)Calculating_Text_Height_2_Width:(CGFloat)width WithString:(NSAttributedString *)string {
    CGRect frame = [string boundingRectWithSize:CGSizeMake(width, FLT_MAX) options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading) context:nil];
    NSLog(@"2:%@", NSStringFromCGRect(frame));
    return frame.size.height + 10;
}



@end
