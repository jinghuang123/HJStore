//
//  HJShareMainImageView.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/6.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJShareMainImageView.h"
@interface HJShareMainImageView ()
@property (nonatomic,strong) HJProductDetailModel *detail;
@end



@implementation HJShareMainImageView

- (instancetype)initWithFrame:(CGRect)frame andDetailModel:(HJProductDetailModel *)detail {
    if (self = [super initWithFrame:frame]) {
        self.detail = detail;
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UILabel *title = [[UILabel alloc] init];
    title.font = PFR18Font;
    title.text = self.detail.title;
    title.numberOfLines = 2;
    title.textColor = [UIColor jk_colorWithHexString:@"#262f42"];
    [self addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(70);
    }];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.firstLineHeadIndent = 25.f; // 首行缩进
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.detail.title.length)];
    title.attributedText = attributedString;
    
    UILabel *finalPrice = [[UILabel alloc] init];
    finalPrice.font = PFR18Font;
    finalPrice.text = [NSString stringWithFormat:@"券后价¥%@",self.detail.zk_final_price];
    finalPrice.textColor = [[UIColor redColor] colorWithAlphaComponent:0.8];
    [self addSubview:finalPrice];
    [finalPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(title.mas_bottom).offset(15);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(30);
    }];
    NSInteger final_price_length = self.detail.zk_final_price.length;
    NSMutableAttributedString *finalString = [[NSMutableAttributedString alloc] initWithString:finalPrice.text];
    [finalString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:23] range:NSMakeRange(finalString.length - final_price_length, final_price_length)];
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
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.layer.borderWidth = 5;
    imageView.clipsToBounds = YES;
    imageView.layer.borderColor = [UIColor redColor].CGColor;
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.detail.pict_url_image]];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(price.mas_bottom).offset(25);
        make.right.mas_offset(-10);
        make.height.mas_equalTo(355);
    }];
    
    
    UIImageView *qrCodeImageView = [[UIImageView alloc] init];
    [self addSubview:qrCodeImageView];
    [qrCodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-20);
        make.right.mas_offset(-10);
        make.height.width.mas_equalTo(90);
    }];
    
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //将NSString格式转化成NSData格式
    NSData *data = [self.detail.item_url dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    
    qrCodeImageView.image = [UIImage imageWithCIImage:image];

}


@end
