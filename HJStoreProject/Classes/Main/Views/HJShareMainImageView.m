//
//  HJShareMainImageView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareMainImageView.h"
@interface HJShareMainImageView ()
@property (nonatomic,strong) HJRecommendModel *detail;
@end



@implementation HJShareMainImageView

- (instancetype)initWithFrame:(CGRect)frame andDetailModel:(HJRecommendModel *)detail {
    if (self = [super initWithFrame:frame]) {
        self.detail = detail;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.detail.pict_url]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(0);
        make.top.mas_offset(0);
        make.right.mas_offset(0);
        make.height.mas_equalTo(355);
    }];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = PFR18Font;
    title.text = self.detail.title;
    title.numberOfLines = 2;
    title.textColor = [[UIColor jk_colorWithHexString:@"#262f42"] colorWithAlphaComponent:0.6];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(60);
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 25.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.detail.title.length)];
    title.attributedText = attributedString;
    
    UIImageView *preIcon = [[UIImageView alloc] init];
    if(self.detail.user_type == 0) {
        preIcon.image = [UIImage imageNamed:@"ic_label_taobao"];
    }else{
        preIcon.image = [UIImage imageNamed:@"ic_label_tmall"];
    }
    [self addSubview:preIcon];
    [preIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(title.mas_top).offset(10);
        make.width.mas_equalTo(18);
        make.height.mas_equalTo(18);
    }];

    
    UILabel *finalPrice = [[UILabel alloc] init];
    finalPrice.font = PFR18Font;
    finalPrice.text = [NSString stringWithFormat:@"券后价 ¥%.2f",[self.detail.zk_final_price floatValue] - [self.detail.coupon_amount floatValue]];
    finalPrice.textColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [self addSubview:finalPrice];
    [finalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(title.mas_bottom).offset(45);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
    NSInteger final_price_length = finalPrice.text.length - 3;
    NSMutableAttributedString *finalString = [[NSMutableAttributedString alloc] initWithString:finalPrice.text];
    [finalString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:23] range:NSMakeRange(finalString.length - final_price_length, final_price_length)];
    finalPrice.attributedText = finalString;
    
    UILabel *price = [[UILabel alloc] init];
    price.font = PFR16Font;
    price.text = [NSString stringWithFormat:@"原价¥%@",self.detail.reserve_price];
    price.textColor = [UIColor lightGrayColor];
    [self addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(finalPrice.mas_bottom).offset(5);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
    
    NSInteger reserve_price_length = self.detail.reserve_price.length;
    NSMutableAttributedString *newPriceString = [[NSMutableAttributedString alloc] initWithString:price.text];
    [newPriceString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(newPriceString.length - reserve_price_length, reserve_price_length)];
    [newPriceString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:NSMakeRange(newPriceString.length - reserve_price_length, reserve_price_length)];
    price.attributedText = newPriceString;
    

    
    
    UIImageView *qrCodeImageView = [[UIImageView alloc] init];
    [self addSubview:qrCodeImageView];
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(title.mas_bottom).offset(20);
        make.right.mas_offset(-15);
        make.height.width.mas_equalTo(120);
    }];
    UIImageView *icon = [[UIImageView alloc] init];
    icon.image = [UIImage imageNamed:@"main_Nav_left"];
    [qrCodeImageView addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(qrCodeImageView);
        make.size.with.height.mas_equalTo(40);
    }];
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    NSString *qrcodeUrl = [NSString stringWithFormat:@"%@?item_id=%@&code=%@",kURLQrcode,self.detail.item_id,userInfo.code];
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //将NSString格式转化成NSData格式
    NSData *data = [qrcodeUrl dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    UIImage *qrImage = [UIImage imageWithCIImage:image];
    qrCodeImageView.image = qrImage;
    
    UILabel *qrTipLabel = [[UILabel alloc] init];
    [self addSubview:qrTipLabel];
    qrTipLabel.text = @"选的美 买的值";
    qrTipLabel.font = [UIFont systemFontOfSize:18];
    qrTipLabel.textColor = [UIColor lightGrayColor];
    qrTipLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:qrTipLabel];
    [qrTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qrCodeImageView.mas_bottom).offset(0);
        make.left.right.equalTo(qrCodeImageView);
        make.height.mas_equalTo(25);
    }];

}


@end
