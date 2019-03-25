//
//  HJInvitationListVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/3/10.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJInvitationListVC.h"
#import "HJLoginRegistRequest.h"

@interface HJInvitationListVC () <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scroView;
@property (nonatomic, strong) UIImage *qrCodeImage;
@property (nonatomic, strong) NSMutableArray *subContents;
@property (nonatomic, strong) UIImage *shareImage;
@end

@implementation HJInvitationListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请";
    // Do any additional setup after loading the view.
    [[HJLoginRegistRequest shared] getInvitationInfoSuccess:^(id responseObject) {
        NSString *url = [responseObject objectForKey:@"download_url"];
        [self createQrCodeWithUrl:url];
        NSArray *images = [responseObject objectForKey:@"invitation_images"];
        [self addscroContent:images];
    } fail:^(NSError *error) {
        
    }];
    
    self.scroView = [[UIScrollView alloc] init];
    self.scroView.contentSize = CGSizeMake(0, 0);
    self.scroView.delegate = self;
    self.scroView.pagingEnabled = YES;
    self.scroView.scrollEnabled = YES;
    self.scroView.bounces = NO;
    self.scroView.showsVerticalScrollIndicator = NO;
    self.scroView.showsHorizontalScrollIndicator = NO;
    self.scroView.alwaysBounceHorizontal = YES;
    self.scroView.alwaysBounceVertical = YES;
    [self.view addSubview:self.scroView];
    [self.scroView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.bottom.mas_offset(-40);
    }];
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(44);
    }];
    
    UIImageView *copyPreicon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Invitation_copy"]];
    UIImageView *sharPreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Invitation_share"]];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setTitle:@"复制邀请码" forState:UIControlStateNormal];
    copyButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [copyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    copyButton.titleLabel.font = [UIFont systemFontOfSize:13];
    copyButton.backgroundColor = [UIColor redColor];
    [bottomView addSubview:copyButton];
    [copyButton addSubview:copyPreicon];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(20);
        make.right.mas_offset(-MaxWidth/2 - 20);
        make.top.mas_offset(8);
        make.bottom.mas_offset(-8);
    }];
    [copyPreicon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(13);
        make.top.mas_offset(6);
        make.width.height.mas_equalTo(16);
    }];
    [copyButton addTarget:self action:@selector(copyToPasteboard) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setTitle:@"分享专属海报" forState:UIControlStateNormal];
    shareButton.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
    [shareButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    shareButton.titleLabel.font = [UIFont systemFontOfSize:13];
    shareButton.backgroundColor = [UIColor redColor];
    [bottomView addSubview:shareButton];
    [shareButton addSubview:sharPreIcon];
    [shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-20);
        make.left.mas_offset(MaxWidth/2 + 20);
        make.top.mas_offset(8);
        make.bottom.mas_offset(-8);
    }];
    [sharPreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(13);
        make.top.mas_offset(6);
        make.width.height.mas_equalTo(16);
    }];
    [shareButton addTarget:self action:@selector(sharedAction) forControlEvents:UIControlEventTouchUpInside];

}

- (NSMutableArray *)subContents {
    if (!_subContents) {
        _subContents = [[NSMutableArray alloc] init];
    }
    return _subContents;
}
- (void)createQrCodeWithUrl:(NSString *)url {
    //创建过滤器
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    //过滤器恢复默认
    [filter setDefaults];
    //将NSString格式转化成NSData格式
    NSData *data = [url dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    [filter setValue:data forKeyPath:@"inputMessage"];
    //获取二维码过滤器生成的二维码
    CIImage *image = [filter outputImage];
    
    self.qrCodeImage = [UIImage imageWithCIImage:image];
}

- (void)addscroContent:(NSArray *)images {
    self.scroView.contentSize = CGSizeMake(images.count * MaxWidth, 0);
    for (NSInteger i = 0; i < images.count; i++) {
        NSString *url = [images objectAtIndex:i];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(MaxWidth * i + 48,  32, MaxWidth - 96, MaxHeight - 210)];
        imageView.layer.cornerRadius = 5;
        imageView.clipsToBounds = YES;
        [imageView sd_setImageWithURLString:url placeholderImage:PLACEHOLDER_160X240];
        [self.scroView addSubview:imageView];
        
        UIImageView *qrImageView = [[UIImageView alloc] init];
        qrImageView.image = self.qrCodeImage;
        qrImageView.layer.borderColor = [UIColor whiteColor].CGColor;
        qrImageView.layer.borderWidth = 10;
        [imageView addSubview:qrImageView];
        [qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(imageView);
            make.bottom.mas_offset(-60);
            make.width.height.mas_equalTo(80);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = [NSString stringWithFormat:@"邀请码\n%@",self.invitationCode];
        label.numberOfLines = 2;
        label.backgroundColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:11];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 5;
        label.clipsToBounds = YES;
        [imageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(0);
            make.height.mas_equalTo(30);
            make.width.mas_equalTo(55);
            make.centerX.mas_equalTo(imageView);
        }];
        
        [_subContents addObject:imageView];
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.shareImage = [self getShareImage:0];
    });
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offset = scrollView.contentOffset.x;
    NSInteger index = offset/MaxWidth;
    self.shareImage = self.subContents.count > index ? [self getShareImage:index] : nil;
}

- (void)copyToPasteboard {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.invitationCode;
}

- (void)sharedAction {
    NSArray * items =  @[self.shareImage];    //分享图片 数组
    
    UIActivityViewController * activityCtl = [[UIActivityViewController alloc]initWithActivityItems:items applicationActivities:nil];
    
    //去除一些不需要的图标选项
    activityCtl.excludedActivityTypes = @[UIActivityTypePostToFacebook,
                                          UIActivityTypeAirDrop,
                                          UIActivityTypePostToTwitter,
                                          UIActivityTypeMessage,
                                          UIActivityTypeMail,
                                          UIActivityTypePrint,
                                          UIActivityTypeCopyToPasteboard,
                                          UIActivityTypeAssignToContact,
                                          UIActivityTypeSaveToCameraRoll,
                                          UIActivityTypeAddToReadingList ,
                                          UIActivityTypePostToFlickr ,
                                          UIActivityTypePostToVimeo,
                                          UIActivityTypePostToTencentWeibo,
                                          UIActivityTypeAirDrop ,
                                          UIActivityTypeOpenInIBooks];
    
    [self presentViewController:activityCtl animated:YES completion:nil];
    
}

- (UIImage *)getShareImage:(NSInteger)index {
    UIImageView *imageView = [_subContents objectAtIndex:index];
    UIGraphicsBeginImageContextWithOptions(imageView.mj_size,NO, 0.0);//设置截屏大小
    [imageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
