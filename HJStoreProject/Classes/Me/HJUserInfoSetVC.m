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
#import "HJUserNameSetVC.h"
#import "HJZFBBindingVC.h"
#import "HJZFBBindingVC.h"
#import "HJWeChatBindingVC.h"
#import "HJTaoBaoBindingVC.h"
#import "HJMobileChangeVC.h"
#import "HJResetPswVC.h"
#import "HJSettingRequest.h"


@interface HJUserInfoSetVC () <HJUserInfoViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) HJUserInfoView *selfView;
@end

@implementation HJUserInfoSetVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
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
                HJUserNameSetVC *nameSetVc = [[HJUserNameSetVC alloc] init];
                [self.navigationController pushViewController:nameSetVc animated:YES];
            }
            break;
        case USERHeadImageClick:
        {
            UIAlertController *actionsheet = [UIAlertController alertControllerWithTitle:@"" message:@"头像设置" preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"相机拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
                imagePick.delegate = self;
                imagePick.allowsEditing = YES; //可编辑
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
                    imagePick.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [self presentViewController:imagePick animated:YES completion:nil];
                }
                
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
            HJZFBBindingVC *zfbVC = [[HJZFBBindingVC alloc] init];
            [self.navigationController pushViewController:zfbVC animated:YES];
        }
            break;
        case USERWeChatBindClick:
        {
            HJWeChatBindingVC *wechatVC = [[HJWeChatBindingVC alloc] init];
            [self.navigationController pushViewController:wechatVC animated:YES];
        }
            break;
        case USERTaoBaoBindClick:
        {
            HJTaoBaoBindingVC *taobaoVC = [[HJTaoBaoBindingVC alloc] init];
            [self.navigationController pushViewController:taobaoVC animated:YES];
        }
            break;
        case USERMobileUpdateClick:
        {
            HJMobileChangeVC *mobileVC = [[HJMobileChangeVC alloc] init];
            [self.navigationController pushViewController:mobileVC animated:YES];
        }
            break;
        case USERPSWUpdateClick:
        {
            HJResetPswVC *pswVC = [[HJResetPswVC alloc] init];
            [self.navigationController pushViewController:pswVC animated:YES];
        }
            break;
        case USERCacheClearClick:
        {
            
        }
            break;
        case USERInfoSaveClick:
        {
            NSData *data = UIImageJPEGRepresentation(self.selfView.headImageView.image, 0.5);
            [[HJSettingRequest shared] uploadFile:data success:^(id responseObject) {
                NSLog(@"responseObject:%@",responseObject);
            } fail:^(NSError *error) {
                
            }];
        }
            break;
            
        default:
            break;
    }
}

- (void)viewSendMsg:(long)msgType args:(NSObject *)args {
    
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<UIImagePickerControllerInfoKey, id> *)editingInfo  {
    NSLog(@"editingInfo:%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    NSLog(@"info:%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.selfView.headImageView.image = image;
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"picker:%@",picker);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
