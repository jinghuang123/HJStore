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

@interface HJMineVC ()
@property (nonatomic,strong) HJEarningModel *earning;
@end

@implementation HJMineVC


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if (!userInfo.token) {
        HJLoginVC *login = [[HJLoginVC alloc] init];
        login.closeButton.hidden = YES;
        HJNavigationVC *nav = [[HJNavigationVC alloc] initWithRootViewController:login];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[HJSettingRequest shared] getApplyCashListSuccess:^(id responseObject) {
        
    } fail:^(NSError *error) {
        
    }];
    
    HJMeView *meView = [[HJMeView alloc] init];
    [self.view addSubview:meView];
    [meView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_offset(0);
    }];
    
    weakify(self)
    meView.settingClick = ^(id obj,HJClickItemType type) {
        [weak_self responsToItemClickWithType:type params:obj];
    };
    
    [[HJSettingRequest shared] getBannersWithType:4 Success:^(NSArray *banners) {
        meView.adSliderCellView.bannerItems = banners;
        NSMutableArray *images = [[NSMutableArray alloc] init];
        for (HJBannerModel *banner in banners) {
            NSString *realUrl = [banner.banner_image hasPrefix:@"http"] ? banner.banner_image : [NSString stringWithFormat:@"%@%@",kHHWebServerBaseURL,banner.banner_image];
            [images addObject:realUrl];
        }
        meView.adSliderCellView.imageGroupArray = images;
    } fail:^(NSError *error) {
        
    }];
    
    [[HJMainRequest shared] getEarningConfigerSuccess:^(HJEarningModel *earning) {
        self.earning = earning;
        meView.code = earning.member_invitecode;
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
    
            
        }
            break;
        case HJClickItemTypeEarn:
        {
            HJEarningVC *earningVC = [[HJEarningVC alloc] init];
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
            invitationVC.invitationCode = self.earning.member_invitecode;
            invitationVC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:invitationVC animated:YES];
        }
            
            break;
        case HJClickItemTypeService:
        {
            HJMeizhiCustomServiceVC *service = [[HJMeizhiCustomServiceVC alloc] init];
            service.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:service animated:YES];
        }
            break;
        case HJClickItemTypeGuide:
        {
        }
            break;
        case HJClickItemTypeProblem:
        {
        }
            break;
        case HJClickItemTypeCollected:
        {
        }
            break;
        case HJClickItemTypeFeedBack:
        {
        }
            break;
        case HJClickItemTypeSign:
        {
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
        }
            break;
            
 
            
        default:
            break;
    }
    
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
    HJProductDetailVC *productDetailVC = [[HJProductDetailVC alloc] init];
    productDetailVC.productId = productId;
    productDetailVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:productDetailVC animated:YES];
}

- (void)pushToWebWithUrl:(NSString *)url {
    if (![url containsString:@"https://"]) {
        url = [NSString stringWithFormat:@"https://%@",url];
    }
    ALiTradeWebViewController *webVC = [[ALiTradeWebViewController alloc] init];
    [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:self webView:webVC.webView url:url success:nil fail:nil];
    
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
