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
#import "HJMobileChangeVC.h"
#import "HJResetPswVC.h"
#import "HJSettingRequest.h"
#import "HJAboutUSVC.h"
#import "HJLoginRegistRequest.h"
#import <MJAlertManager/MJAlertManager.h>
#import "HJShareInstance.h"
#import "HJLoginRegistRequest.h"


@interface HJUserInfoSetVC () <HJUserInfoViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) HJUserInfoView *selfView;
@property (nonatomic, assign) NSInteger type;
@end

@implementation HJUserInfoSetVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
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
    [selfView setDataSourceChange];
}

- (void)cellDidSelected:(long)msgType args:(NSObject *)args {
    switch (msgType) {
        case USERNameUpdateClick:
            {
                weakify(self)
                HJUserNameSetVC *nameSetVc = [[HJUserNameSetVC alloc] init];
                HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
                nameSetVc.name = userInfo.nickname;
                nameSetVc.userNameSetBlock = ^(NSString *name) {
                    [weak_self updateUserInfo:nil nickName:name userName:nil];
                };
                [self.navigationController pushViewController:nameSetVc animated:YES];
            }
            break;
        case USERHeadImageClick:
        {
            self.type = 0;
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (photos.count > 0) {
                    [self saveImageUser:[photos firstObject]];
                }
            };
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;
        case USERZFBBindClick:
        {
            HJSettingInfo *info = [HJSettingInfo shared];
            if(!info.zfb){
                HJZFBBindingVC *zfbVC = [[HJZFBBindingVC alloc] init];
                [self.navigationController pushViewController:zfbVC animated:YES];
            }
        }
            break;
        case USERWeChatBindClick:
        {
            HJSettingInfo *info = [HJSettingInfo shared];
            if(!info.weixin){
                [[HJShareInstance shareInstance] getUserInfoForWechatSuccess:^(HJWechatUserModel *userInfo) {
                    [self.view makeToast:@"微信授权成功" duration:2.0 position:CSToastPositionCenter];
                    [[HJLoginRegistRequest shared] bondingWithWechatInfo:userInfo.openid token:userInfo.token success:^(id responseObject) {
                        [self.view makeToast:@"微信绑定成功" duration:2.0 position:CSToastPositionCenter];
                        info.weixin = YES;
                        [self.selfView setDataSourceChange];
                    } fail:^(NSError *error, NSString *errorMsg) {
                        
                    }];
                }];
            }
        }
            break;
        case USERTaoBaoBindClick:
        {
            HJSettingInfo *info = [HJSettingInfo shared];
            [self showTaobaoAuthorDailogSuccess:^(id responseObject) {
                info.taobao = YES;
                [self.selfView setDataSourceChange];
            }];
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
            weakify(self)
            [MJAlertManager showAlertWithTitle:@"提示" message:@"是否要清理图片缓存" cancel:@"取消" confirm:@"确认" completion:^(NSInteger selectIndex) {
                if (selectIndex == 1) {
                    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                        [weak_self.selfView setDataSourceChange];
                    }];
                }
            }];
            
        }
            break;
        case USERAboutUsClick:
        {
            HJAboutUSVC *aboutUs = [[HJAboutUSVC alloc] init];
            [self.navigationController pushViewController:aboutUs animated:YES];
            
        }
            break;
        case USERUploadQrCode:
        {
            self.type = 1;
            TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
            imagePickerVc.didFinishPickingPhotosHandle = ^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
                if (photos.count > 0) {
                    [self saveQrCode:[photos firstObject]];
                }
            };
            [self presentViewController:imagePickerVc animated:YES completion:nil];
        }
            break;
        case USERUploadWechat:
        {
            weakify(self)
            HJSettingInfo *info = [HJSettingInfo shared];
            HJUserNameSetVC *nameSetVc = [[HJUserNameSetVC alloc] init];
            nameSetVc.name = info.kefu_wechat;
            nameSetVc.userNameSetBlock = ^(NSString *name) {
                [weak_self uploadKefuInfo:@"" weChat:name];
            };
            [self.navigationController pushViewController:nameSetVc animated:YES];
        }
            break;
        case USERQuiteClick:
        {
            NSLog(@"退出登录");
            [MJAlertManager showAlertWithTitle:@"提示" message:@"是否要退出" cancel:@"取消" confirm:@"确认" completion:^(NSInteger selectIndex) {
                if (selectIndex == 1) {
                    [[HJLoginRegistRequest shared] logOutActionSuccess:^(id responseObject) {
                        HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
                        userInfo.token = @"";
                        [userInfo saveUserInfo2Phone];
                        self.tabBarController.selectedIndex = 0;
                        [self.navigationController popViewControllerAnimated:YES];
                    } fail:^(NSError *error) {
                        
                    }];
                }
            }];
    

        }
            break;

            
        default:
            break;
    }
}

- (void)viewSendMsg:(long)msgType args:(NSObject *)args {
    
}

- (void)saveImageUser:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [[HJSettingRequest shared] uploadFile:data success:^(NSString *url) {
        [self updateUserInfo:url nickName:nil userName:nil];
    } fail:^(NSError *error) {

    }];
}

- (void)saveQrCode:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.5);
    [[HJSettingRequest shared] uploadFile:data success:^(NSString *url) {
        [self uploadKefuInfo:url weChat:@""];
    } fail:^(NSError *error) {
        
    }];
}

- (void)uploadKefuInfo:(NSString *)url weChat:(NSString *)wechat {
    [[HJSettingRequest shared] getUploadKefuInfoQrCodeUrl:url we_chat:wechat success:^(id responseObject) {
        HJSettingInfo *info = [HJSettingInfo shared];
        info.kefu_wechat = [wechat isEqualToString:@""] ? info.kefu_wechat : wechat;
        info.kefu_qrcode = [url isEqualToString:@""] ? info.kefu_qrcode : url ;
        [self.selfView setDataSourceChange];
    } fail:^(NSError *error) {
        
    }];
}

- (void)updateUserInfo:(NSString *)headImageUrl nickName:(NSString *)nickName userName:(NSString *)userName {
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if (!headImageUrl) {
        headImageUrl = userInfo.avatar;
    }
    if(!nickName) {
        nickName = userInfo.nickname;
    }
    if (!userName) {
        userName = userInfo.username;
    }
    [[HJSettingRequest shared] updeteUserInfoWithAvater:headImageUrl username:userName nickname:nickName Success:^(id responseObject) {
        [self.selfView setDataSourceChange];
    } fail:^(NSError *error) {
    }];
}



- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<UIImagePickerControllerInfoKey, id> *)editingInfo  {
    NSLog(@"editingInfo:%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey, id> *)info {
    NSLog(@"info:%@",info);
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    self.type == 0 ?  [self saveImageUser:image] : [self saveQrCode:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"picker:%@",picker);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
