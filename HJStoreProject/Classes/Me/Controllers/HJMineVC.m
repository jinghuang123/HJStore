//
//  HJMineVC.m
//  HJStoreProject
//
//  Created by 黄靖 on 2018/11/29.
//  Copyright © 2018年 黄靖. All rights reserved.
//

#import "HJMineVC.h"
#import "HJSettingRequest.h"
#import "HJMainRequest.h"
#import "HJMeView.h"
#import "HJUserInfoSetVC.h"
#import "HJFencePageVC.h"
#import "HJOrderListVC.h"
#import "HJInvitationListVC.h"
#import "HJEarningVC.h"
#import "HJUserInfoModel.h"
#import "HJLoginVC.h"
#import "HJNavigationVC.h"
#import "HJOrderPageVC.h"
#import "HJMeizhiCustomServiceVC.h"
#import "HJAboutUSVC.h"
#import "HJUserInfoSetVC.h"
#import "HJMainVC.h"
#import "ALiTradeWebViewController.h"
#import "HJProductDetailVC.h"
#import "AlibcManager.h"
#import "HJMyCollectionVC.h"
#import "HJMessageListVC.h"
#import "YFPolicyWebVC.h"
#import "HJGropPopVC.h"
#import "HJZFBBindingVC.h"
#import "HJTakeCashVC.h"

@interface HJMineVC ()
@property (nonatomic,strong) HJGeneralInfo *info;
@property (nonatomic,strong) HJEarningModel *earning;
@property (nonatomic,strong) HJMeView *meView;
@property (nonatomic,strong) HJUserInfoModel *userInfo;
@end

@implementation HJMineVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    _userInfo = userInfo;
    if (!userInfo.token || [userInfo.token isEqualToString:@""]) {
        [self pushToLoginVC:NO closeBlock:^(id obj) {
            self.tabBarController.selectedIndex = 0;
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else {
        weakify(self)
        if (!self.meView) {
            [self setSelfView];
        }
        
        
        [[HJSettingRequest shared] getGeneralInfoSuccess:^(HJGeneralInfo *info) {
            weak_self.info = info;
            [weak_self.meView setInfoWithGenerInfo:info];
        } fail:^(NSError *error) {
            
        }];
        HJSettingInfo *info = [HJSettingInfo shared];
        if (!info.zfb) {
            [[HJSettingRequest shared] getSettingInfoSuccess:^(id responseObject) {
            } fail:^(NSError *error) {
            }];
        }
        
  
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setSelfView];
}

- (void)setSelfView {
    weakify(self)
    [[HJSettingRequest shared] getBannersWithType:4 Success:^(NSArray *banners) {
        HJMeView *meView = [[HJMeView alloc] initWithBanners:banners];
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (HJBannerModel *banner in banners) {
            NSString *realUrl = [banner.banner_image hasPrefix:@"http"] ? banner.banner_image : [NSString stringWithFormat:@"%@%@",kHHWebServerBaseURL,banner.banner_image];
            [images addObject:realUrl];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            weak_self.meView.adSliderCellView.imageGroupArray = images;
        });
        
        weak_self.meView = meView;
        [self.view addSubview:meView];
        [meView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_offset(0);
        }];
        meView.settingClick = ^(id obj,HJClickItemType type) {
            [weak_self responsToItemClickWithType:type params:obj];
        };
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)responsToItemClickWithType:(HJClickItemType)type params:(id)obj{
    switch (type) {
        case HJClickItemTypeSetting:
        case HJClickItemTypeHead:
        {
            HJUserInfoSetVC *setVC = [[HJUserInfoSetVC alloc] init];
            setVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:setVC animated:YES];
        }
            break;
        case HJClickItemTypeWithDrawal:
        {
            HJSettingInfo *setInfo = [HJSettingInfo shared];
            if (!setInfo.zfb) {
                HJZFBBindingVC *zfbVC = [[HJZFBBindingVC alloc] init];
                zfbVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:zfbVC animated:YES];
            }else{
      
                [[HJSettingRequest shared] getCachInfoSuccess:^(HJCashInfoModel *cashInfo) {
                    HJTakeCashVC *cashVC = [[HJTakeCashVC alloc] init];
                    cashVC.hidesBottomBarWhenPushed = YES;
                    cashVC.cashInfo = cashInfo;
                    [self.navigationController pushViewController:cashVC animated:YES];
                } fail:^(NSError *error) {
                    
                }];
            }
        }
            break;
        case HJClickItemTypeEarn:
        {
            HJEarningVC *earningVC = [[HJEarningVC alloc] init];
            earningVC.info = self.info;
            earningVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:earningVC animated:YES];
        }
            break;
        case HJClickItemTypeOrder:
        {
            HJOrderPageVC *orderVC = [[HJOrderPageVC alloc] init];
            orderVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case HJClickItemTypeFence:
        {
            HJFencePageVC *fenceVC = [[HJFencePageVC alloc] init];
            fenceVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:fenceVC animated:YES];
        }
            
            break;
        case HJClickItemTypeInvitation:
        {
            HJInvitationListVC *invitationVC = [[HJInvitationListVC alloc] init];
            HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
            invitationVC.invitationCode = userInfo.code;
            invitationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invitationVC animated:YES];
        }
            
            break;
        case HJClickItemTypeService:
        {
            [[HJSettingRequest shared] getServiceInfoSuccess:^(HJServiceInfoModel *service) {
                HJMeizhiCustomServiceVC *serviceVC = [[HJMeizhiCustomServiceVC alloc] init];
                serviceVC.serviceInfo = service;
                serviceVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:serviceVC animated:YES];
            } fail:^(NSError *error) {
                
            }];
   
        }
            break;
        case HJClickItemTypeGuide:
        {
            [self pushToWebUrl:kUrlNewGuide];
        }
            break;
        case HJClickItemTypeProblem:
        {
            [self pushToWebUrl:kUrlQuestion];
        }
            break;
        case HJClickItemTypeCollected:
        {
            HJMyCollectionVC *collectedVc = [[HJMyCollectionVC alloc] init];
            collectedVc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:collectedVc animated:YES];
        }
            break;
        case HJClickItemTypeFeedBack:
        {
            [self pushToWebUrl:kUrlFeedBack];
        }
            break;
        case HJClickItemTypeSign:
        {
            [self pushToWebUrl:kUrlSign];
        }
            break;

        case HJClickItemTypeAboutUS:
        {
            HJAboutUSVC *aboutUs = [[HJAboutUSVC alloc] init];
            aboutUs.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:aboutUs animated:YES];
        }
            break;
        case HJClickItemTypeADS:
        {
            HJBannerModel *banner = (HJBannerModel *)obj;
            if (banner.typedata == HJNavPushTypeUrl) {
                [self pushToWebWithUrl:banner.content_url];
            }else if (banner.typedata == HJNavPushTypeDetail) {
                [self pushToProductDetailWithId:banner.item_id];
            }else if (banner.typedata == HJNavPushTypeList) {
                [self pushToProductListWithId:0 activityId:banner.taobao_activity_id];
            }
            
        }
            break;
        case HJClickItemTypeMessage:
        {
            HJMessageListVC *messageVC = [[HJMessageListVC alloc] init];
            messageVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:messageVC animated:YES];
        }
            break;
            
        case HJClickItemTypeUpdateGroup:
        {
            if (self.userInfo.group_id == 1) {
                [[HJSettingRequest shared] getUpdateGroupSuccess:^(id obj) {
                    if ([obj isKindOfClass:[HJUpdateGroupModel class]]) {
                        HJUpdateGroupModel *group = (HJUpdateGroupModel *)obj;
                        [self popUpdateGroupWithModel:group];
                    }else{
                        [self.view makeToast:obj duration:2.0 position:CSToastPositionCenter];
                    }
                } fail:^(NSError *error) {
                    
                }];
            }else {
                [self pushToWebUrl:kUrlUpdateUser];
            }
            
        }
            break;
            
        default:
            break;
    }
}

- (void)popUpdateGroupWithModel:(HJUpdateGroupModel *)model {
    HJGropPopVC *pop = [[HJGropPopVC alloc] initWithShowFrame:CGRectMake(0, 0 ,MaxWidth, MaxHeight)
                                                                    ShowStyle:MYPresentedViewShowStyleSuddenStyle
                                                                     callback:^(id obj) {
                                                                     }];
    pop.clearBack = YES;
    pop.groupModel = model;
    [self presentViewController:pop animated:YES completion:nil];
}

- (void)pushToProductListWithId:(NSString *)categoryId activityId:(NSInteger)activityId{
    HJMainVC *productListVC = [[HJMainVC alloc] init];
    productListVC.hidesBottomBarWhenPushed = YES;
    productListVC.catteryId = categoryId;
    productListVC.activityId = activityId;
    productListVC.headType  = HJMainVCProductListHeadTypeList;
    productListVC.listType = HJMainVCProductListTypeList;
    [self.navigationController pushViewController:productListVC animated:YES];
    
}

- (void)pushToProductDetailWithId:(NSString *)productId {
    if ([productId isEqualToString:@""]) {
        return;
    }
    HJProductDetailVC *productDetailVC = [[HJProductDetailVC alloc] init];
    productDetailVC.productId = productId;
    productDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

- (void)pushToWebWithUrl:(NSString *)url {
    if ([url isEqualToString:@""]) {
        return;
    }
    if (![url containsString:@"http"]) {
        url = [NSString stringWithFormat:@"http://%@",url];
    }
    ALiTradeWebViewController *webVC = [[ALiTradeWebViewController alloc] init];
    [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:self webView:webVC.webView url:url productid:@"" success:nil fail:nil];
}

- (void)pushToWebUrl:(NSString *)url {
    if ([url isEqualToString:@""]) {
        return;
    }
    if (![url containsString:@"https://"]) {
        url = [NSString stringWithFormat:@"https://%@",url];
    }
    YFPolicyWebVC *web = [[YFPolicyWebVC alloc] init];
    web.policyUrl = url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}

@end
