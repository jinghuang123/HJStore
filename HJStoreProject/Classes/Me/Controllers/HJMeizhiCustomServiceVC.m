//
//  HJMeizhiCustomServiceVC.m
//  HJStoreProject
//
//  Created by kinghuang on 2019/3/24.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJMeizhiCustomServiceVC.h"

@interface HJMeizhiCustomServiceVC ()
@property (nonatomic, strong) UIImageView *qrimageView;
@property (nonatomic, strong) NSString *wechatCode;
@end

@implementation HJMeizhiCustomServiceVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
 
    self.wechatCode = @"MeiZhi888888";
    UIImageView *qrimageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"meizhi_wechat_code"]];
    _qrimageView = qrimageView;
 
    [self.view addSubview:qrimageView];
    [qrimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(56 + 64);
        make.width.height.mas_equalTo(205);
        make.centerX.mas_equalTo(self.view);
    }];
    [qrimageView sd_setImageWithURLString:self.serviceInfo.kefu_qrcode placeholderImage:PLACEHOLDER_Category];
    
    UILabel *wechatLabel = [[UILabel alloc] init];
    [self.view addSubview:wechatLabel];
    wechatLabel.text = [NSString stringWithFormat:@"专属客服微信号:%@",self.serviceInfo.kefu_wechat];
    wechatLabel.font = [UIFont systemFontOfSize:12];
    wechatLabel.textColor = [UIColor blackColor];
    wechatLabel.backgroundColor = [UIColor whiteColor];
    wechatLabel.textAlignment = NSTextAlignmentCenter;
    wechatLabel.layer.cornerRadius = 10;
    wechatLabel.clipsToBounds = YES;
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(qrimageView.mas_bottom).offset(40);
        make.width.mas_equalTo(205);
        make.height.mas_equalTo(20);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setBackgroundImage:[UIImage imageNamed:@"service_btn_bg_1"] forState:UIControlStateNormal];
    [copyButton setTitle:@"复制去添加微信好友" forState:UIControlStateNormal];
    [copyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    copyButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:copyButton];
    [copyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(24);
        make.right.mas_offset(-24);
        make.top.mas_equalTo(wechatLabel.mas_bottom).offset(40);
        make.height.mas_equalTo(32);
    }];
    [copyButton addTarget:self action:@selector(copyToPasteboard) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [saveButton setBackgroundImage:[UIImage imageNamed:@"service_btn_bg_2"] forState:UIControlStateNormal];
    [saveButton setTitle:@"保存二维码到手机" forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:saveButton];
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(24);
        make.right.mas_offset(-24);
        make.top.mas_equalTo(copyButton.mas_bottom).offset(20);
        make.height.mas_equalTo(32);
    }];
    [saveButton addTarget:self action:@selector(saveImageToAlbum) forControlEvents:UIControlEventTouchUpInside];
    
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
    
    self.qrimageView.image = [UIImage imageWithCIImage:image];
}

- (void)copyToPasteboard {
    [self.view makeToast:@"复制微信号成功" duration:1.0 position:CSToastPositionCenter];
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.serviceInfo.kefu_wechat;
}

- (void)saveImageToAlbum {
    UIImageWriteToSavedPhotosAlbum(self.qrimageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
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
