//
//  HJShareCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareCell.h"
#import "XLPhotoBrowser.h"

@interface HJShareCell ()
@property (nonatomic,strong) UILabel *topTipLabel;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *couponLabel;
@property (nonatomic,strong) UILabel *downloadTipLabel;
@property (nonatomic,strong) UILabel *tipCopyLabel;
@property (nonatomic,strong) UILabel *showCouponLabel;
@property (nonatomic,strong) UIButton *selBtn;
@end


@implementation HJShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *topTip = [[UILabel alloc] init];
    _topTipLabel = topTip;
    topTip.jk_edgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    topTip.backgroundColor = [UIColor redColor];
    topTip.textColor = [UIColor whiteColor];
    topTip.text = @"    奖励收益预估 ¥3.24";
    topTip.font = PFR12Font;
    [self.contentView addSubview:topTip];
    
    UILabel *titleLab = [[UILabel alloc] init];
    _titleLab = titleLab;
    titleLab.textColor = [UIColor blackColor];
    titleLab.jk_edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    titleLab.font = PFR13Font;
    titleLab.numberOfLines = 3;
    titleLab.text = @"你妹的杨帆，你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹你妹妹你妹你妹你妹你妹";
    [self.contentView addSubview:titleLab];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    _priceLabel = priceLabel;
    priceLabel.text = @"【在售价】 22.32元";
    priceLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    priceLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    priceLabel.font = PFR13Font;
    [self.contentView addSubview:priceLabel];
    
    UILabel *couponLabel = [[UILabel alloc] init];
    _couponLabel = couponLabel;
    couponLabel.text = @"【券后价】 17.32元";
    couponLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    couponLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    couponLabel.font = PFR13Font;
    [self.contentView addSubview:couponLabel];
    UILabel *downloadTipLabel = [[UILabel alloc] init];
    _downloadTipLabel = downloadTipLabel;
    downloadTipLabel.text = @"【下载花生日记再省】 3.00元";
    downloadTipLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    downloadTipLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    downloadTipLabel.font = PFR13Font;
    [self.contentView addSubview:downloadTipLabel];

    
    UILabel *tipCopyLabel = [[UILabel alloc] init];
    _tipCopyLabel = tipCopyLabel;
    tipCopyLabel.text = @"下载这条信息¥nmddeQDdsWjpdxd¥,\n打开【手机淘宝】即可查看";
    tipCopyLabel.numberOfLines = 2;
    tipCopyLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    tipCopyLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    tipCopyLabel.font = PFR13Font;
    [self.contentView addSubview:tipCopyLabel];
    
    UILabel *lineLabel = [[UILabel alloc] init];
    lineLabel.text = @"----------";
    lineLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
    lineLabel.textColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.9];
    lineLabel.font = PFR13Font;
    [self.contentView addSubview:lineLabel];
    
   
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.6];
    [self.contentView addSubview:lineView];
    
    UIButton *selectedBtn = [[UIButton alloc] init];
    _selBtn = selectedBtn;
    [selectedBtn addTarget:self action:@selector(selectedBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
    [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
    [self.contentView addSubview:selectedBtn];
    [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(lineView.mas_bottom).offset(8);
        make.height.width.mas_equalTo(15);
    }];
    
    UILabel *showCouponLabel = [[UILabel alloc] init];
    _showCouponLabel = showCouponLabel;
    showCouponLabel.text = @"显示花生日记收益";
    showCouponLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 35, 0, 10);
    showCouponLabel.textColor = [UIColor redColor];
    showCouponLabel.font = PFR12Font;
    [self.contentView addSubview:showCouponLabel];
    
    [topTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.height.mas_equalTo(30);
    }];
    CGFloat h = [titleLab.text jk_heightWithFont:titleLab.font constrainedToWidth:MaxWidth - 20];
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(topTip.mas_bottom).offset(0);
        make.height.mas_equalTo(h + 25);
    }];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(0);
        make.height.mas_equalTo(15);
    }];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(15);
    }];
    [downloadTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(couponLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(15);
    }];
    
    [lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(downloadTipLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(10);
    }];
    
    [tipCopyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(lineLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-30);
        make.height.mas_equalTo(0.5);
    }];
    
    [showCouponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(8);
        make.height.mas_equalTo(15);
    }];
}



- (void)updateCellWithModel:(HJShareModel *)share {
    self.titleLab.text = share.title;
    self.topTipLabel.text = [NSString stringWithFormat:@"奖励收益预估 ¥%@",@"3.21"];
    NSString *value = [NSString stringWithFormat:@"%.2f", [share.zk_final_price floatValue] - [share.coupon_value floatValue]];
    self.priceLabel.text = [NSString stringWithFormat:@"【在售价】 %@元",share.reserve_price];
    self.couponLabel.text = [NSString stringWithFormat:@"【券后价】 %@元",value];
    self.downloadTipLabel.text = [NSString stringWithFormat:@"【下载花生日记再省】 %.2f元",3.21];
    self.tipCopyLabel.text = [NSString stringWithFormat:@"下载这条信息%@,\n打开【手机淘宝】即可查看",share.model];
    self.selBtn.selected = share.showCoupon;
    CGFloat downloadH = 0;
    if(share.showCoupon) {
        downloadH = 15;
    }
    [self.downloadTipLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_equalTo(self.couponLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(downloadH);
    }];
}

- (void)selectedBtnClick {
    if (self.couponShowBlock) {
        self.couponShowBlock(nil);
    }
}
@end


@implementation HJShareImageView
- (instancetype)init {
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleToFill;
        self.clipsToBounds = YES;
        UIView *selectedBgView = [[UIView alloc] init];
        selectedBgView.backgroundColor = [UIColor clearColor];
        [self addSubview:selectedBgView];
        [selectedBgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(0);
            make.right.mas_offset(0);
            make.width.height.mas_equalTo(35);
        }];
        [selectedBgView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [self imageSelectedAction:self.selBtn];
        }];
        UIButton *selectedBtn = [[UIButton alloc] init];
        _selBtn = selectedBtn;
        [selectedBtn addTarget:self action:@selector(imageSelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_unselected"] forState:UIControlStateNormal];
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"icon_selected"] forState:UIControlStateSelected];
        [selectedBgView addSubview:selectedBtn];
        [selectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(5);
            make.right.mas_offset(-5);
            make.width.height.mas_equalTo(15);
        }];
    }
    
    return self;
}

- (void)imageSelectedAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.imageSelectBlock) {
        self.imageSelectBlock(sender.state);
    }
}


@end

@interface HJShareImagesCell () <XLPhotoBrowserDatasource>
@property (nonatomic,strong) HJShareImageView *leftImageV;
@property (nonatomic,strong) HJShareImageView *rightImage1;
@property (nonatomic,strong) HJShareImageView *rightImage2;
@property (nonatomic,strong) HJShareImageView *rightImage3;
@property (nonatomic,strong) HJShareImageView *rightImage4;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,strong) NSMutableArray *images;

@end
@implementation HJShareImagesCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (NSMutableArray *)imageViews {
    if(!_imageViews) {
        _imageViews = [[NSMutableArray alloc] init];
    }
    return _imageViews;
}

- (NSMutableArray *)images {
    if(!_images) {
        _images = [[NSMutableArray alloc] init];
    }
    return _images;
}

- (void)setupUI {
    HJShareImageView *leftImageV = [[HJShareImageView alloc] init];
    _leftImageV = leftImageV;
    leftImageV.selBtn.selected = YES;
    [self.contentView addSubview:leftImageV];
    CGFloat wid = (MaxWidth - 50)/2;
    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(20);
        make.width.mas_equalTo(wid);
        make.height.mas_equalTo(wid*1704/972);
    }];
    
    CGFloat rightItemSize = (MaxWidth - 60)/4;
    HJShareImageView *rightImage1 = [[HJShareImageView alloc] init];
    _rightImage1 = rightImage1;
    [self.contentView addSubview:rightImage1];
    rightImage1.image = [UIImage imageNamed:@"default_share"];
    [rightImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(leftImageV.mas_right).offset(10);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    
    HJShareImageView *rightImage2 = [[HJShareImageView alloc] init];
    _rightImage2 = rightImage2;
    [self.contentView addSubview:rightImage2];
    rightImage2.image = [UIImage imageNamed:@"default_share"];
    [rightImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightImage1.mas_bottom).offset(10);
        make.left.mas_equalTo(rightImage1.mas_left).offset(0);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    
    HJShareImageView *rightImage3 = [[HJShareImageView alloc] init];
    _rightImage3 = rightImage3;
    [self.contentView addSubview:rightImage3];
    rightImage3.image = [UIImage imageNamed:@"default_share"];
    [rightImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightImage2.mas_bottom).offset(10);
        make.left.mas_equalTo(rightImage2.mas_left).offset(0);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    
    HJShareImageView *rightImage4 = [[HJShareImageView alloc] init];
    _rightImage4 = rightImage4;
    [self.contentView addSubview:rightImage4];
    rightImage4.image = [UIImage imageNamed:@"default_share"];
    [rightImage4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_equalTo(rightImage1.mas_right).offset(10);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    [self.imageViews addObject:rightImage1];
    [self.imageViews addObject:rightImage2];
    [self.imageViews addObject:rightImage3];
    [self.imageViews addObject:rightImage4];
    
    weakify(self)
    [leftImageV jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self showImage:weak_self.images index:0];
    }];
    leftImageV.imageSelectBlock = ^(int state) {
        [self didImagesSelectedStateUpdate];
    };
    [rightImage1 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self showImage:weak_self.images index:1];
    }];
    rightImage1.imageSelectBlock = ^(int state) {
        [self didImagesSelectedStateUpdate];
    };
    [rightImage2 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self showImage:weak_self.images index:2];
    }];
    rightImage2.imageSelectBlock = ^(int state) {
        [self didImagesSelectedStateUpdate];
    };
    [rightImage3 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self showImage:weak_self.images index:3];
    }];
    rightImage3.imageSelectBlock = ^(int state) {
        [self didImagesSelectedStateUpdate];
    };
    [rightImage4 jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self showImage:weak_self.images index:4];
    }];
    rightImage4.imageSelectBlock = ^(int state) {
        [self didImagesSelectedStateUpdate];
    };
}

- (void)didImagesSelectedStateUpdate {
    NSArray *images = [self getSelectedImages];
    if (self.didImagesSelectedUpdateBlock) {
        self.didImagesSelectedUpdateBlock(images);
    }
}
    
- (void)updateCellWithModel:(HJShareModel *)share {
    _leftImageV.image = share.mainImage;
    [share.images enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
       HJShareImageView *imagV = [self.imageViews objectAtIndex:idx];
        [imagV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"list_holder"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
    }];
    [self.images addObject:share.mainImage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (HJShareImageView *imageV in self.imageViews) {
            [self.images addObject:imageV.image];
        }
    });
}

- (NSArray *)getSelectedImages {
    NSMutableArray *images = [[NSMutableArray alloc] init];
    if (_leftImageV.selBtn.selected) {
        UIImage *image = _leftImageV.image;
        [images addObject:image];
    }
    for (HJShareImageView *imageV in self.imageViews) {
        if (imageV.selBtn.selected) {
            UIImage *image = imageV.image;
            NSLog(@"size:%f,%f",image.size.width,image.size.height);
            [images addObject:image];
        }
    }
    return images;
}

- (void) showImage:(NSArray *)images index:(NSInteger)index{
    XLPhotoBrowser *browser = [XLPhotoBrowser showPhotoBrowserWithImages:self.images currentImageIndex:index];
    browser.pageDotColor = [UIColor lightGrayColor]; ///< 此属性针对动画样式的pagecontrol无效
    browser.currentPageDotColor = [UIColor whiteColor];
    browser.browserStyle = XLPhotoBrowserStyleSimple;
    browser.pageControlStyle = XLPhotoBrowserPageControlStyleClassic;
}

@end
