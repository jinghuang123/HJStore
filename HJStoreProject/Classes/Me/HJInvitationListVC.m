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

@end

@implementation HJInvitationListVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
    }
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
