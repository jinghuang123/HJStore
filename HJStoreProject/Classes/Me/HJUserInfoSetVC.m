//
//  HJUserInfoSetVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2019/1/20.
//  Copyright © 2019年 黄靖. All rights reserved.
//

#import "HJUserInfoSetVC.h"
#import "HJUserInfoView.h"
#import <MJAlertManager/MJAlertManager.h>
#import <TZImagePickerController/TZImagePickerController.h>

@interface HJUserInfoSetVC () <HJUserInfoViewDelegate,TZImagePickerControllerDelegate>
@property (nonatomic, strong) HJUserInfoView *selfView;
@end

@implementation HJUserInfoSetVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    
    HJUserInfoView *selfView = [[HJUserInfoView alloc] init];
    _selfView = selfView;
    selfView.delegate = self;
    [self.view addSubview:selfView];
    [selfView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_offset(0);
    }];
}

- (void)cellDidSelected:(long)msgType args:(NSObject *)args {
    switch (msgType) {
        case USERNameUpdateClick:
            {
                
            }
            break;
        case USERHeadImageClick:
        {
            UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"" message:@"头像设置" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
                imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                    if (photos.count > 0) {
                        self.selfView.headImageView.image = [photos firstObject];
                    }
                };
                [self presentViewController:imagePickerVc animated:YES completion:nil];
            }];
            [actionsheet addAction:action0];
            [actionsheet addAction:action1];
            [actionsheet addAction:action2];
            [self presentViewController:actionsheet animated:YES completion:nil];

        }
            break;
        case USERZFBBindClick:
        {
            
        }
            break;
        case USERWeChatBindClick:
        {
            
        }
            break;
        case USERTaoBaoBindClick:
        {
            
        }
            break;
        case USERMobileUpdateClick:
        {
            
        }
            break;
        case USERPSWUpdateClick:
        {
            
        }
            break;
        case USERCacheClearClick:
        {
            
        }
            break;
        case USERInfoSaveClick:
        {
            
        }
            break;
            
        default:
            break;
    }
}

@end
