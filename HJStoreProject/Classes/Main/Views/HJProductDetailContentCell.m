//
//  HJProductDetailContentCell.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/12/31.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJProductDetailContentCell.h"
#import "HJMainRequest.h"

@interface HJProductDetailContentCell ()
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UIImageView *preIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *soldCountLabel;
@property (nonatomic, strong) UILabel *earningLabel;
@property (nonatomic, strong) UILabel *conponsValueLabel;
@property (nonatomic, strong) UILabel *conponsDateLabel;
@property (nonatomic, strong) UILabel *storeName;
@property (nonatomic, strong) UIButton *collectionBtn;
@property (nonatomic, strong) UILabel *collectionTip;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) UIImageView *conponsImageView;
@end

@implementation HJProductDetailContentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {

    
    UIImageView *preIcon = [[UIImageView alloc] init];
    _preIcon = preIcon;
    [self.contentView addSubview:preIcon];
    [preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(12);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    titleLabel.numberOfLines = 0;
    titleLabel.font = PFR14Font;
    titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.top.mas_offset(6);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(45);
    }];
    
    UILabel *tip = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 20)];
    tip.layer.cornerRadius = 10;
    tip.textAlignment = NSTextAlignmentCenter;
    tip.clipsToBounds = YES;
    tip.textColor = [UIColor whiteColor];
    tip.text = @"券后价";
    tip.font = PFR14Font;
    tip.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:tip];
    [tip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(15);
        make.left.mas_equalTo(titleLabel.mas_left).offset(0);
        make.width.mas_equalTo(67);
        make.height.mas_equalTo(21);
    }];
    
    
    UILabel *priceLabel = [[UILabel alloc] init];
    _priceLabel = priceLabel;
    priceLabel.textColor = [UIColor redColor];
    priceLabel.font = PFR18Font;
    [self.contentView addSubview:priceLabel];
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tip.mas_right).offset(10);
        make.centerY.mas_equalTo(tip.mas_centerY).offset(0);
        make.right.mas_offset(-20);
        make.height.mas_equalTo(25);
    }];
    
    UILabel *soldCountLabel =  [[UILabel alloc] init];
    _soldCountLabel = soldCountLabel;
    soldCountLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    soldCountLabel.font = [UIFont systemFontOfSize:12];
    soldCountLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:soldCountLabel];
    [soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(tip.mas_left).offset(0);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _collectionBtn = collectionBtn;
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"collected_n"] forState:UIControlStateNormal];
    [collectionBtn setBackgroundImage:[UIImage imageNamed:@"collected_h"] forState:UIControlStateSelected];
    [collectionBtn addTarget:self action:@selector(collectionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:collectionBtn];
    [collectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-30);
        make.width.height.mas_equalTo(25);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(0);
    }];
    UILabel *collectionTip =  [[UILabel alloc] init];
    _collectionTip = collectionTip;
    collectionTip.textColor = [UIColor grayColor];
    collectionTip.text = @"收藏";
    collectionTip.font = [UIFont systemFontOfSize:11];
    collectionTip.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:collectionTip];
    [collectionTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(collectionBtn);
        make.width.mas_equalTo(30);
        make.top.mas_equalTo(collectionBtn.mas_bottom).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    
    UIImageView *earnBgImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earn_bg"]];
    earnBgImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:earnBgImageView];
    [earnBgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.mas_equalTo(75);
        make.top.mas_equalTo(priceLabel.mas_bottom).offset(6);
        make.height.mas_equalTo(23);
    }];
    [earnBgImageView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.shareToEarnBlock) {
            self.shareToEarnBlock(nil);
        }
    }];
    
    UIImageView *earnPreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earn_pre"]];
    [earnBgImageView addSubview:earnPreIcon];
    [earnPreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(8);
        make.width.mas_equalTo(10);
        make.top.mas_equalTo(6);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *earningLabel =  [[UILabel alloc] init];
    _earningLabel = earningLabel;
    earningLabel.textColor = [UIColor whiteColor];
    earningLabel.font = [UIFont systemFontOfSize:10];
    earningLabel.textAlignment = NSTextAlignmentLeft;
    [earnBgImageView addSubview:earningLabel];
    [earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnPreIcon.mas_right).offset(5);
        make.width.mas_equalTo(50);
        make.bottom.mas_offset(0);
        make.height.mas_equalTo(23);
    }];
    
    UIImageView *conponsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"conponsImage_bg"]];
    _conponsImageView = conponsImageView;
    conponsImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:conponsImageView];
    [conponsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(earnBgImageView.mas_bottom).offset(10);
        make.left.mas_offset(26);
        make.right.mas_offset(-26);
        make.height.mas_equalTo(60);
    }];
    [conponsImageView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (self.conponGetBlock) {
            self.conponGetBlock(nil);
        }
    }];
    
    UILabel *getConponsTip = [[UILabel alloc] init];
    getConponsTip.text = @"立即领取";
    getConponsTip.textColor = [UIColor whiteColor];
    getConponsTip.font = [UIFont systemFontOfSize:13];
    [conponsImageView addSubview:getConponsTip];
    [getConponsTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.mas_offset(20);
        make.right.mas_offset(-30);
        make.width.mas_equalTo(55);
    }];
    
    UILabel *conponsValueLabel = [[UILabel alloc] init];
    _conponsValueLabel = conponsValueLabel;
    conponsValueLabel.text = @"100元优惠券";
    conponsValueLabel.textColor = [UIColor whiteColor];
    conponsValueLabel.font = [UIFont systemFontOfSize:16];
    conponsValueLabel.textAlignment = NSTextAlignmentCenter;
    [conponsImageView addSubview:conponsValueLabel];
    [conponsValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(20);
        make.top.mas_offset(10);
        make.left.mas_offset(30);
        make.right.mas_equalTo(getConponsTip.mas_left).offset(-50);
    }];
    
    UILabel *conponsDateLabel = [[UILabel alloc] init];
    _conponsDateLabel = conponsDateLabel;
    conponsDateLabel.text = @"";
    conponsDateLabel.textColor = [UIColor whiteColor];
    conponsDateLabel.font = [UIFont systemFontOfSize:10];
    conponsDateLabel.textAlignment = NSTextAlignmentCenter;
    [conponsImageView addSubview:conponsDateLabel];
    [conponsDateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(conponsValueLabel.mas_bottom).offset(5);
        make.left.mas_offset(20);
        make.right.mas_equalTo(getConponsTip.mas_left).offset(-40);
    }];
    
    UILabel *storeName = [[UILabel alloc] init];
    _storeName = storeName;
    storeName.textColor = [UIColor blackColor];
    storeName.font = PFR13Font;
    [self.contentView addSubview:storeName];
    [storeName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(conponsImageView.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    
}

- (void)setIffavourite:(BOOL)favourite {
    if (favourite) {
        self.collectionBtn.selected = YES;
        self.collectionTip.textColor = [UIColor redColor];
    }else{
        self.collectionTip.textColor = [UIColor grayColor];
        self.collectionBtn.selected = NO;
    }
}

- (void)setcontentWithModel:(HJRecommendModel *)item {
    self.itemId = item.item_id;
    CGFloat final_value = [item.zk_final_price floatValue];
    CGFloat couponValue = [item.coupon_amount floatValue];
    NSString *value = [NSString stringWithFormat:@"%.2f", final_value - couponValue];
    _priceLabel.text = [NSString stringWithFormat:@"%@   ¥%@",value,item.zk_final_price];
    //3.初始化NSTextAttachment对象
    if(item.user_type == 0) {
        _preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        _preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }
    _soldCountLabel.text = [NSString stringWithFormat:@"已售%ld",item.volume];
    _earningLabel.text = [NSString stringWithFormat:@"赚￥%.2f",item.earning];
    _storeName.text = item.nick;
    _conponsValueLabel.text = [NSString stringWithFormat:@"%ld元优惠券",[item.coupon_amount integerValue]];
    _conponsDateLabel.text = item.coupon_start_time ? [NSString stringWithFormat:@"%@~%@",item.coupon_start_time,item.coupon_end_time] : @"";

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 20.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _titleLabel.attributedText = attributedString;
    


    
    
    NSInteger final_price_length = value.length + 1;
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%@",_priceLabel.text]];
    
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(0, 1)];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:18] range:NSMakeRange(1, final_price_length)];

    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(final_price_length, newPriceString.length - final_price_length)];
    [newPriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(final_price_length + 2, newPriceString.length - final_price_length - 2)];
    [newPriceString addAttribute:NSForegroundColorAttributeName value:[UIColor lightGrayColor] range:NSMakeRange(final_price_length, newPriceString.length - final_price_length)];
    _priceLabel.attributedText = newPriceString;
    
    if (!item.coupon_amount) {
        [_conponsImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(20);
        }];
        _conponsImageView.hidden = YES;
    }else{
        _conponsImageView.hidden = NO;
        [_conponsImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(60);
        }];
    }
}

- (void)collectionAction:(UIButton *)sender {
    NSLog(@"collectionAction");
    sender.selected = !sender.selected;
    [self setIffavourite:sender.selected];
    NSString *status = sender.selected ? @"add" : @"cancel";
    [[HJMainRequest shared] postFavouriteWithItemId:self.itemId status:status success:^(id responseObject) {
    } fail:^(NSError *error) {
    }];
}
@end


@implementation HJProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.contentView.backgroundColor = RGB(245, 245, 245);;
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-5);
    }];
    UILabel *titleTip = [[UILabel alloc] init];
    titleTip.text = @"查看商品详情";
    titleTip.font = PFR14Font;
    titleTip.textColor = [UIColor blackColor];
    [contentV addSubview:titleTip];
    [titleTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_equalTo(contentV.mas_centerY).offset(0);
        make.height.mas_equalTo(20);
    }];
}

@end


@implementation HJProductDetailTipCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}




- (void)setUpUI {
    self.contentView.backgroundColor = RGB(245, 245, 245);;
    UIView *contentV = [[UIView alloc] init];
    contentV.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentV];
    [contentV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(0);
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor redColor];
    UILabel *tipLabel = [[UILabel alloc] init];
    tipLabel.textColor = [UIColor redColor];
    tipLabel.font = [UIFont systemFontOfSize:13];
    tipLabel.text = @"猜你喜欢";
    tipLabel.textAlignment = NSTextAlignmentCenter;
    UIView *rightView = [[UIView alloc] init];
    rightView.backgroundColor = [UIColor redColor];
    
    
    [self.contentView addSubview:leftView];
    [self.contentView addSubview:rightView];
    [self.contentView addSubview:tipLabel];
    
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(tipLabel.mas_left).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(60);
        make.height.mas_equalTo(0.5);
        make.left.mas_equalTo(tipLabel.mas_right).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
    
    [tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(100);
        make.height.mas_equalTo(25);
        make.centerX.mas_equalTo(self.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.mas_centerY).offset(0);
    }];
}

@end


@interface HJGoodItemsSingleCell ()

/* 图片 */
@property (strong , nonatomic)UIImageView *goodsImageView;
/* 标题 */
@property (strong , nonatomic)UILabel *goodsLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *priceLabel;
/* 价格 */
@property (strong , nonatomic)UILabel *nowPriceLabel;
/* 销售量 */
@property (strong , nonatomic)UILabel *soldCountLabel;

@property (strong , nonatomic)UIImageView *preIcon;
@property (strong , nonatomic)UIImageView *couponIcon;

@property (strong , nonatomic)UILabel *couponLabel;

@property (strong , nonatomic) UILabel *earningLabel;
@end


@implementation HJGoodItemsSingleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpUI];
    }
    return self;
}




- (void)setUpUI {
    self.backgroundColor = [UIColor whiteColor];
    _goodsImageView = [[UIImageView alloc] init];
    _goodsImageView.layer.cornerRadius = 5;
    _goodsImageView.clipsToBounds = YES;
    _goodsImageView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:_goodsImageView];
    
    
    
    _goodsLabel = [[UILabel alloc] init];
    _goodsLabel.font = PFR14Font;
    _goodsLabel.numberOfLines = 2;
    _goodsLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:_goodsLabel];
    
    _preIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_preIcon];
    
    
    _nowPriceLabel = [[UILabel alloc] init];
    _nowPriceLabel.textAlignment = NSTextAlignmentLeft;
    _nowPriceLabel.textColor = [UIColor grayColor];
    _nowPriceLabel.font = PFR8Font;
    [self.contentView addSubview:_nowPriceLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textColor = [UIColor redColor];
    _priceLabel.font = PFR12Font;
    [self addSubview:_priceLabel];
    
    _couponIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_couponIcon];
    
    _couponLabel = [[UILabel alloc] init];
    _couponLabel.font = [UIFont systemFontOfSize:9];
    _couponLabel.textAlignment = NSTextAlignmentCenter;
    _couponLabel.textColor = [UIColor redColor];
    [_couponIcon addSubview:_couponLabel];
    
    _earningLabel =  [[UILabel alloc] init];
    _earningLabel.backgroundColor = [UIColor jk_colorWithHexString:@"#E32828"];
    _earningLabel.textColor = [UIColor whiteColor];
    _earningLabel.layer.cornerRadius = 10;
    _earningLabel.clipsToBounds = YES;
    _earningLabel.font = [UIFont systemFontOfSize:10];
    _earningLabel.jk_edgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    UIImageView *earnpreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earn_pre"]];
    [_earningLabel addSubview:earnpreIcon];
    [earnpreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.centerY.equalTo(self.earningLabel);
        make.width.height.mas_equalTo(10);
    }];
    [self.contentView addSubview:_earningLabel];
    
    _soldCountLabel =  [[UILabel alloc] init];
    _soldCountLabel.textColor = [UIColor jk_colorWithHexString:@"#8F8F8F"];
    _soldCountLabel.font = [UIFont systemFontOfSize:9];
    _soldCountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_soldCountLabel];
    
}


#pragma mark - 布局
- (void)layoutSubviews {
    [super layoutSubviews];
    weakify(self)
    [_goodsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(5);
        make.top.mas_offset(5);
        make.width.height.mas_equalTo(140);
    }];
    
    [_preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.top.mas_offset(18);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    
    [_goodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.top.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_equalTo(40);
    }];
    
    [_couponIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.top.mas_equalTo(weak_self.goodsLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(57);
        make.height.mas_equalTo(19);
    }];
    
    [_couponLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.top.mas_offset(5);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(10);
    }];
    
    [_earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.width.mas_equalTo(62);
        make.top.mas_equalTo(weak_self.couponIcon.mas_top).offset(0);
        make.height.mas_equalTo(20);
    }];
    
    [_nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.couponIcon.mas_left).offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(weak_self.couponIcon.mas_bottom).offset(10);
    }];
    
    [_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weak_self.goodsImageView.mas_right).offset(5);
        make.right.mas_offset(-15);
        make.top.mas_equalTo(weak_self.nowPriceLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [_soldCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(weak_self.nowPriceLabel.mas_bottom).offset(10);
    }];
    _goodsLabel.userInteractionEnabled = YES;
    _preIcon.userInteractionEnabled = YES;
    self.contentView.userInteractionEnabled = YES;
    [_goodsLabel jk_addLongPressActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weak_self.contentView becomeFirstResponder]; //
        UIMenuItem *copyLink = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copy:)];
        [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObjects:copyLink, nil]];
        [[UIMenuController sharedMenuController] setTargetRect:weak_self.goodsLabel.frame inView:self];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }];
}


- (BOOL)canBecomeFirstResponder{
    return YES;
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(copy:));
}
- (void)copy:(id)sender{
    UIPasteboard *pasteBoard = [UIPasteboard generalPasteboard];
    pasteBoard.string = self.goodsLabel.text;
}


- (void)setItemCellWithItem:(HJRecommendModel *)item {
    [_goodsImageView sd_setImageWithURLString:item.pict_url placeholderImage:PLACEHOLDER_ITEM];
    _priceLabel.text = [NSString stringWithFormat:@"券后 ¥%.2f",item.coupon_after_price];
    _nowPriceLabel.text = item.zk_final_price;
    //3.初始化NSTextAttachment对象
    if(item.user_type == 0) {
        _preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        _preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }
    [_couponIcon setImage:[UIImage imageNamed:@"CouponIcon"]];
    _couponLabel.text = [NSString stringWithFormat:@"¥ %ld",[item.coupon_amount integerValue]];
    _earningLabel.text = [NSString stringWithFormat:@"赚 %.2f",item.earning];
    _soldCountLabel.text = [NSString stringWithFormat:@"销量 %ld",item.volume];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:item.title];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 20.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, item.title.length)];
    _goodsLabel.attributedText = attributedString;
    
    
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",_priceLabel.text]];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:9] range:NSMakeRange(0, 2)];
    _priceLabel.attributedText = newPriceString;
    
    NSMutableAttributedString *currentPriceString = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"现价   %@  ",_nowPriceLabel.text]];
    [currentPriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(2, currentPriceString.length - 3)];
    _nowPriceLabel.attributedText = currentPriceString;
    
    
    if(!item.coupon_amount) {
        _couponIcon.hidden = YES;
        _nowPriceLabel.hidden = YES;
        _priceLabel.text = [NSString stringWithFormat:@"现价 ¥%.2f",item.coupon_after_price];
    }else{
        _couponIcon.hidden = NO;
        _nowPriceLabel.hidden = NO;
        _priceLabel.text = [NSString stringWithFormat:@"券后 ¥%.2f",item.coupon_after_price];
        
    }
}
@end
