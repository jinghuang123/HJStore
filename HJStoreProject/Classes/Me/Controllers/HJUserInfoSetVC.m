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
}

- (void)cellDidSelected:(long)msgType args:(NSObject *)args {
    switch (msgType) {
        case USERNameUpdateClick:
            {
                weakify(self)
                HJUserNameSetVC *nameSetVc = [[HJUserNameSetVC alloc] init];
                nameSetVc.userNameSetBlock = ^(NSString *name) {
                    [weak_self updateUserInfo:nil nickName:name userName:nil];
                };
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
                        [self saveImageUser:[photos firstObject]];
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
    [self saveImageUser:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSLog(@"picker:%@",picker);
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
