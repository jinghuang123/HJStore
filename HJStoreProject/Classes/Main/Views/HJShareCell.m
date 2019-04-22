//
//  HJShareCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/1.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareCell.h"
#import "XLPhotoBrowser.h"
#import "UIView+XLExtension.h"

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
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"post_right_unselect"] forState:UIControlStateNormal];
        [selectedBtn setBackgroundImage:[UIImage imageNamed:@"post_right_selest"] forState:UIControlStateSelected];
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

@property (nonatomic,strong) UILabel *topTipLabel;

@property (nonatomic,strong) HJShareImageView *leftImageV;
@property (nonatomic,strong) HJShareImageView *rightImage1;
@property (nonatomic,strong) HJShareImageView *rightImage2;
@property (nonatomic,strong) HJShareImageView *rightImage3;
@property (nonatomic,strong) HJShareImageView *rightImage4;
@property (nonatomic,strong) NSMutableArray *imageViews;
@property (nonatomic,strong) NSMutableArray *images;

@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *priceLabel;
@property (nonatomic,strong) UILabel *couponLabel;
@property (nonatomic,strong) UILabel *downloadTipLabel;
@property (nonatomic,strong) UILabel *tipCopyLabel;
@property (nonatomic,strong)  HJShareModel *shareModel;

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
    
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(20, 10, MaxWidth - 40, 30)];
    topView.backgroundColor = [UIColor redColor];
    topView.layer.cornerRadius = 15;
    topView.clipsToBounds = YES;
    [self.contentView addSubview:topView];
    
    UIImageView *topLetIcon = [[UIImageView alloc] init];
    topLetIcon.image = [UIImage imageNamed:@"shear_Oval"];
    [topView addSubview:topLetIcon];
    [topLetIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(30);
        make.top.mas_offset(5);
        make.bottom.mas_offset(-5);
        make.width.height.mas_equalTo(20);
    }];
    
    UIImageView *topRightIcon = [[UIImageView alloc] init];
    topRightIcon.image = [UIImage imageNamed:@"share_Path"];
    [topView addSubview:topRightIcon];
    [topRightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.top.mas_offset(5);
        make.bottom.mas_offset(-5);
        make.width.mas_equalTo(13);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *topTipLabel = [[UILabel alloc] init];
    _topTipLabel = topTipLabel;
    topTipLabel.textColor = [UIColor whiteColor];
    topTipLabel.textAlignment = NSTextAlignmentCenter;
    topTipLabel.font = [UIFont systemFontOfSize:13];
    topTipLabel.text = [NSString stringWithFormat:@"预估收益  %.2f     分享朋友圈三部曲",3.32];
    [topView addSubview:topTipLabel];
    [topTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(topLetIcon.mas_right).offset(0);
        make.centerY.equalTo(topView);
        make.right.mas_equalTo(topRightIcon.mas_left).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    
    UIView *step1View = [[UIView alloc] initWithFrame:CGRectMake(20, 50, 180, 20)];
    [self addCrashLineBorderWithView:step1View line:NO];
    [self.contentView addSubview:step1View];
    
    
    UILabel *step1Tip = [[UILabel alloc] init];
    step1Tip.textAlignment = NSTextAlignmentCenter;
    step1Tip.text = @"第一步:选择图片发至朋友圈";
    step1Tip.textColor = [UIColor blackColor];
    step1Tip.font = [UIFont systemFontOfSize:12];
    [step1View addSubview:step1Tip];
    [step1Tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(step1View);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *downloadTip = [[UILabel alloc] init];
    downloadTip.userInteractionEnabled = YES;
    downloadTip.textAlignment = NSTextAlignmentCenter;
    downloadTip.text = @"保存选中图片";
    downloadTip.textColor = [UIColor jk_colorWithHexString:@"#e32828"];
    downloadTip.font = [UIFont systemFontOfSize:12];
    [self.contentView addSubview:downloadTip];
    [downloadTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.centerY.equalTo(step1View);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(20);
    }];
    [downloadTip jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self saveImagesSelected];
    }];
    
    UIImageView *downLoadIcon = [[UIImageView alloc] init];
    downLoadIcon.userInteractionEnabled = YES;
    downLoadIcon.image = [UIImage imageNamed:@"download_share"];
    [self.contentView addSubview:downLoadIcon];
    [downLoadIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(downloadTip.mas_left).offset(0);
        make.centerY.equalTo(step1View);
        make.height.width.mas_equalTo(16);
    }];
    [downLoadIcon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self saveImagesSelected];
    }];
    
    HJShareImageView *leftImageV = [[HJShareImageView alloc] init];
    _leftImageV = leftImageV;
    leftImageV.layer.borderColor = [[UIColor jk_colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5].CGColor;
    leftImageV.layer.borderWidth = 1;
    leftImageV.selBtn.selected = YES;
    [self.contentView addSubview:leftImageV];
    CGFloat wid = (MaxWidth - 50)/2;
    [leftImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(step1View.mas_bottom).offset(10);
        make.left.mas_offset(20);
        make.width.mas_equalTo(wid);
        make.height.mas_equalTo(wid*640/375);
    }];
    
    CGFloat rightItemSize = (MaxWidth - 60)/4;
    HJShareImageView *rightImage1 = [[HJShareImageView alloc] init];
    rightImage1.hidden = YES;
    rightImage1.layer.borderColor = [[UIColor jk_colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5].CGColor;
    rightImage1.layer.borderWidth = 1;
    _rightImage1 = rightImage1;
    [self.contentView addSubview:rightImage1];
    [rightImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(step1View.mas_bottom).offset(10);
        make.left.mas_equalTo(leftImageV.mas_right).offset(10);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    
    HJShareImageView *rightImage2 = [[HJShareImageView alloc] init];
    _rightImage2 = rightImage2;
    rightImage2.layer.borderColor = [[UIColor jk_colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5].CGColor;
    rightImage2.layer.borderWidth = 1;
    rightImage2.hidden = YES;
    [self.contentView addSubview:rightImage2];
    [rightImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightImage1.mas_bottom).offset(10);
        make.left.mas_equalTo(rightImage1.mas_left).offset(0);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    
    HJShareImageView *rightImage3 = [[HJShareImageView alloc] init];
    _rightImage3 = rightImage3;
    rightImage3.layer.borderColor = [[UIColor jk_colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5].CGColor;
    rightImage3.layer.borderWidth = 1;
    rightImage3.hidden = YES;
    [self.contentView addSubview:rightImage3];
//    rightImage3.image = PLACEHOLDER_ITEM;
    [rightImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(rightImage2.mas_bottom).offset(10);
        make.left.mas_equalTo(rightImage2.mas_left).offset(0);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    
    HJShareImageView *rightImage4 = [[HJShareImageView alloc] init];
    _rightImage4 = rightImage4;
    rightImage4.layer.borderColor = [[UIColor jk_colorWithHexString:@"#333333"] colorWithAlphaComponent:0.5].CGColor;
    rightImage4.layer.borderWidth = 1;
    rightImage4.hidden = YES;
    [self.contentView addSubview:rightImage4];
//    rightImage4.image = PLACEHOLDER_ITEM;
    [rightImage4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(step1View.mas_bottom).offset(10);
        make.left.mas_equalTo(rightImage1.mas_right).offset(10);
        make.width.mas_equalTo(rightItemSize);
        make.height.mas_equalTo(rightItemSize);
    }];
    [self.imageViews addObject:rightImage1];
    [self.imageViews addObject:rightImage2];
    [self.imageViews addObject:rightImage3];
    [self.imageViews addObject:rightImage4];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, wid*1704/972 + 70, MaxWidth - 40, 1)];
    [self addCrashLineBorderWithView:lineView line:YES];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(leftImageV.mas_bottom).offset(10);
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(1);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    _bottomView = bottomView;
    [self.contentView addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_equalTo(lineView.mas_bottom).offset(0);
    }];
    
    [self setBottomView];
    
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


- (void)setBottomView {
    
    UIView *step2View = [[UIView alloc] initWithFrame:CGRectMake(20, 10, 220, 20)];
    [self addCrashLineBorderWithView:step2View line:NO];
    [_bottomView addSubview:step2View];
    
    UILabel *step2Tip = [[UILabel alloc] init];
    step2Tip.textAlignment = NSTextAlignmentCenter;
    step2Tip.text = @"第二步:复制文案到朋友圈粘贴发表";
    step2Tip.textColor = [UIColor blackColor];
    step2Tip.font = [UIFont systemFontOfSize:12];
    [step2View addSubview:step2Tip];
    [step2Tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(step2View);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *copyTitleTip = [[UILabel alloc] init];
    copyTitleTip.userInteractionEnabled = YES;
    copyTitleTip.textAlignment = NSTextAlignmentCenter;
    copyTitleTip.text = @"复制文案";
    copyTitleTip.textColor = [UIColor jk_colorWithHexString:@"#e32828"];
    copyTitleTip.font = [UIFont systemFontOfSize:12];
    [_bottomView addSubview:copyTitleTip];
    [copyTitleTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.centerY.equalTo(step2View);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    [copyTitleTip jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self makeToast:@"复制文案成功" duration:1.0 position:CSToastPositionCenter];
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.contentLabel.text;
    }];

    UIImageView *copyTitleIcon = [[UIImageView alloc] init];
    copyTitleIcon.userInteractionEnabled = YES;
    copyTitleIcon.image = [UIImage imageNamed:@"share_copyicon"];
    [_bottomView addSubview:copyTitleIcon];
    [copyTitleIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(copyTitleTip.mas_left).offset(0);
        make.centerY.equalTo(step2View);
        make.height.width.mas_equalTo(16);
    }];
    [copyTitleIcon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
    
    }];
    
    UILabel *contentLabel = [[UILabel alloc] init];
    _contentLabel = contentLabel;
    contentLabel.textColor = [UIColor blackColor];
    contentLabel.jk_edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    contentLabel.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.1];
    contentLabel.layer.cornerRadius = 10;
    contentLabel.clipsToBounds = YES;
    contentLabel.font = PFR13Font;
    contentLabel.numberOfLines = 3;
    [_bottomView addSubview:contentLabel];
    [contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.mas_equalTo(step2View.mas_bottom).offset(10);
        make.height.mas_equalTo(60);
    }];
    
    UIView *step3View = [[UIView alloc] initWithFrame:CGRectMake(20, 110, 220, 20)];
    [self addCrashLineBorderWithView:step3View line:NO];
    [_bottomView addSubview:step3View];
    
    UILabel *step3Tip = [[UILabel alloc] init];
    step3Tip.textAlignment = NSTextAlignmentCenter;
    step3Tip.text = @"第三步:复制淘口令到朋友圈粘贴评论";
    step3Tip.textColor = [UIColor blackColor];
    step3Tip.font = [UIFont systemFontOfSize:12];
    [step3View addSubview:step3Tip];
    [step3Tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(step3View);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *copyTklTip = [[UILabel alloc] init];
    copyTklTip.userInteractionEnabled = YES;
    copyTklTip.textAlignment = NSTextAlignmentCenter;
    copyTklTip.text = @"复制淘口令";
    copyTklTip.textColor = [UIColor jk_colorWithHexString:@"#e32828"];
    copyTklTip.font = [UIFont systemFontOfSize:12];
    [_bottomView addSubview:copyTklTip];
    [copyTklTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.centerY.equalTo(step3View);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    [copyTklTip jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self copyTaokouling];
    }];
    
    UIImageView *copyTklIcon = [[UIImageView alloc] init];
    copyTklIcon.userInteractionEnabled = YES;
    copyTklIcon.image = [UIImage imageNamed:@"share_copyicon"];
    [_bottomView addSubview:copyTklIcon];
    [copyTklIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(copyTklTip.mas_left).offset(0);
        make.centerY.equalTo(step3View);
        make.height.width.mas_equalTo(16);
    }];
    [copyTklIcon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self copyTaokouling];
    }];
    
    
    UILabel *titleLab = [[UILabel alloc] init];
    _titleLab = titleLab;
    titleLab.textColor = [UIColor blackColor];
    titleLab.jk_edgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    titleLab.font = PFR13Font;
    titleLab.numberOfLines = 3;
    [_bottomView addSubview:titleLab];
    
    UILabel *priceLabel = [[UILabel alloc] init];
    _priceLabel = priceLabel;
    priceLabel.text = @"【在售价】 22.32元";
    priceLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    priceLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];;
    priceLabel.font = PFR11Font;
    [_bottomView addSubview:priceLabel];
    
    UILabel *couponLabel = [[UILabel alloc] init];
    _couponLabel = couponLabel;
    couponLabel.text = @"【券后价】 17.32元";
    couponLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    couponLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];;
    couponLabel.font = PFR11Font;
    [_bottomView addSubview:couponLabel];
    UILabel *downloadTipLabel = [[UILabel alloc] init];
    _downloadTipLabel = downloadTipLabel;
    downloadTipLabel.text = @"【下载花生日记再省】 3.00元";
    downloadTipLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    downloadTipLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];;
    downloadTipLabel.font = PFR11Font;
    [_bottomView addSubview:downloadTipLabel];
    
    
    UILabel *tipCopyLabel = [[UILabel alloc] init];
    _tipCopyLabel = tipCopyLabel;
    tipCopyLabel.text = @"下载这条信息¥nmddeQDdsWjpdxd¥,\n打开【手机淘宝】即可购买";
    tipCopyLabel.numberOfLines = 2;
    tipCopyLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
    tipCopyLabel.textColor = [UIColor jk_colorWithHexString:@"#333333"];;
    tipCopyLabel.font = PFR13Font;
    [_bottomView addSubview:tipCopyLabel];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(20, 50, MaxWidth - 40, 1)];
    [self addCrashLineBorderWithView:lineView line:YES];
    [_bottomView addSubview:lineView];


    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.top.mas_equalTo(step3View.mas_bottom).offset(10);
        make.height.mas_equalTo(60);
    }];
    
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLab);
        make.top.mas_equalTo(titleLab.mas_bottom).offset(0);
        make.height.mas_equalTo(10);
    }];
    [couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLab);
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(10);
    }];
    
    
    [downloadTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLab);
        make.top.mas_equalTo(couponLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(10);
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(downloadTipLabel.mas_bottom).offset(10);
        make.left.mas_offset(20);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(1);
    }];

    
    [tipCopyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLab);
        make.top.mas_equalTo(lineView.mas_bottom).offset(5);
        make.height.mas_equalTo(40);
    }];
}

- (void)didImagesSelectedStateUpdate {
    NSArray *images = [self getSelectedImages];
    if (self.didImagesSelectedUpdateBlock) {
        self.didImagesSelectedUpdateBlock(images);
    }
}
    
- (void)updateCellWithShareModel:(HJShareModel *)share mainImage:(UIImage *)mainImage recommendInfo:(HJRecommendModel *)info {
    _shareModel = share;
    _leftImageV.image = mainImage;
    [info.small_images enumerateObjectsUsingBlock:^(NSString *imageUrl, NSUInteger idx, BOOL * _Nonnull stop) {
       HJShareImageView *imagV = [self.imageViews objectAtIndex:idx];
        imagV.hidden = NO;
        [imagV sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:PLACEHOLDER_ITEM completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        }];
    }];
    [self.images addObject:mainImage];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        for (HJShareImageView *imageV in self.imageViews) {
            [self.images addObject:imageV.image];
        }
    });
    
    self.titleLab.text = info.title;
    self.priceLabel.text = [NSString stringWithFormat:@"【在售价】 %@元",info.reserve_price];
    self.couponLabel.text = [NSString stringWithFormat:@"【券后价】 %.2f元",info.coupon_after_price];
    self.downloadTipLabel.text = [NSString stringWithFormat:@"【下载美值APP再赚】 %.2f元",3.21];
    self.tipCopyLabel.text = [NSString stringWithFormat:@"复制这条信息%@，启动【手机淘宝】即可购买",share.model];
    self.topTipLabel.text = [NSString stringWithFormat:@"预估收益 %.2f    分享朋友圈三部曲",info.earning];
    self.contentLabel.text = info.title;
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


- (void)saveImagesSelected {
    NSArray *images = [self getSelectedImages];
    for (UIImage *image in images) {
        [self saveImageToAlbum:image];
    }
}

- (void)saveImageToAlbum:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self makeToast:msg duration:1.0 position:CSToastPositionCenter];
}

- (void)addCrashLineBorderWithView:(UIView *)view line:(BOOL)isLine{
    CAShapeLayer *border = [CAShapeLayer layer];
    
    //虚线的颜色
    border.strokeColor = [UIColor blackColor].CGColor;
    //填充的颜色
    border.fillColor = [UIColor clearColor].CGColor;
    
    //设置路径
    if(isLine){
        UIBezierPath *pat = [UIBezierPath bezierPath];
        [pat moveToPoint:CGPointMake(0, 0)];
        [pat addLineToPoint:CGPointMake(view.bounds.size.width, 0)];
        border.path = pat.CGPath;
    }else{
       border.path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:view.bounds.size.height/2].CGPath;
    }

    
    border.frame = view.bounds;
    //虚线的宽度
    border.lineWidth = 1.f;
    
    
    //设置线条的样式
    //    border.lineCap = @"square";
    //虚线的间隔
    border.lineDashPattern = @[@4, @2];
    
    [view.layer addSublayer:border];
}

- (void)copyTaokouling {
    NSMutableString *copyStr = [[NSMutableString alloc] init];
    [copyStr appendString:self.titleLab.text];
    [copyStr appendString:@"\n"];
    [copyStr appendString:self.priceLabel.text];
    [copyStr appendString:@"\n"];
    [copyStr appendString:self.couponLabel.text];
    [copyStr appendString:@"\n"];
    [copyStr appendString:self.downloadTipLabel.text];
    [copyStr appendString:@"\n"];
    [copyStr appendString:self.tipCopyLabel.text];
    [copyStr appendString:@"\n"];
    [self makeToast:@"复制淘口令成功" duration:1.0 position:CSToastPositionCenter];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = copyStr;
}

@end
