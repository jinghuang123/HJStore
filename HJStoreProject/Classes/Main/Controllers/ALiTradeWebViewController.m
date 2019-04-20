//
//  ALiTradeWantViewController.m
//  ALiSDKAPIDemo
//
//  Created by com.alibaba on 16/6/1.
//  Copyright © 2016年 alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALiTradeWebViewController.h"
//#import "ALiWebViewService.h"
#import <AlibcTradeBiz/AlibcTradeBiz.h>
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import "HJUserInfoModel.h"
#import "HJMainRequest.h"
#import "HJShareVC.h"
#import "AlibcManager.h"
#import "HJShareMainImageView.h"
//#import "ALiCartService.h"

@interface ALiTradeWebViewController()
@property (strong, nonatomic) UIView *bottomView;
@property (strong, nonatomic) UIButton *searchButton;
@property (strong, nonatomic) NSString *productId;
@property (strong, nonatomic) HJRecommendModel *detailModel;
@property (strong, nonatomic) UILabel *earningLabel;
@property (strong, nonatomic) UIButton *couponInfoBtn;
@property (strong, nonatomic) HJShareMainImageView *shareMainImageV;
@end

@implementation ALiTradeWebViewController
- (instancetype)init
{
    self = [super init];
    if (self) {
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _webView.scrollView.scrollEnabled = YES;
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customBackButton];
    UIView *bottomView = [[UIView alloc] init];
    _bottomView = bottomView;
    bottomView.hidden = YES;
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_equalTo(50);
    }];
    [self setupButtons];
    
    UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchButton = searchButton;
    [searchButton setImage:[UIImage imageNamed:@"searchBling"] forState:UIControlStateNormal];
    [searchButton jk_setImagePosition:LXMImagePositionLeft spacing:3];
    [searchButton setTitle:@"搜券查收益" forState:UIControlStateNormal];
    [searchButton setBackgroundColor:[UIColor redColor]];
    searchButton.titleLabel.textColor = [UIColor whiteColor];
    [searchButton jk_addActionHandler:^(NSInteger tag) {
        [self setSearchButtonDismiss];
    }];
    [bottomView addSubview:searchButton];
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_offset(0);
    }];
}

- (void)setSearchButtonDismiss {
    [self getPorductDetail:^(id obj) {
        NSString *tip = [NSString stringWithFormat:@"自购赚 ¥%.2f",self.detailModel.earning];
        [self.couponInfoBtn setTitle:tip forState:UIControlStateNormal];
        self.earningLabel.text = [NSString stringWithFormat:@"赚¥%.2f",self.detailModel.earning];
        [self.searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.top.mas_offset(0);
            make.left.mas_offset(MaxWidth);
            make.right.mas_offset(MaxWidth * 2);
        }];
    }];


}

- (void)setSearchButtonShow {
    [_searchButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_offset(0);
    }];
}


-(void)dealloc
{
    NSLog(@"dealloc  view");
    _webView =  nil;
}

-(UIWebView *)getWebView{
    return  _webView;
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {

    NSString *urlString = request.URL.absoluteString;
    NSLog(@"webLoadUrl = %@",urlString);
    if ([urlString containsString:@"item.htm"]) {
        self.bottomView.hidden = NO;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.view bringSubviewToFront:self.bottomView];
            NSDictionary *dic = [self parameterWithURL:[NSURL URLWithString:urlString]];
            self.productId = [dic objectForKey:@"id"];
            [self setSearchButtonShow];
        });
    }else{
        self.bottomView.hidden = YES;
    }

    return YES;
}


// 自定义返回按钮
- (void)customBackButton{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 60, 40);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    backBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [backBtn setImage:[UIImage imageNamed:@"NavBar_backImg"] forState:UIControlStateNormal];
    [backBtn jk_setImagePosition:LXMImagePositionLeft spacing:5];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
}
// 返回按钮按下
- (void)backBtnClicked:(UIButton *)sender{
    if (_webView.canGoBack) {
        [_webView goBack];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}


- (void)setupButtons {
    UIView *shareView = [[UIView alloc] init];
    shareView.backgroundColor = [UIColor orangeColor];
    UIImageView *earnPreIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earn_pre"]];
    
    
    UILabel *earningLabel =  [[UILabel alloc] init];
    _earningLabel = earningLabel;
    earningLabel.textColor = [UIColor whiteColor];
    earningLabel.font = [UIFont systemFontOfSize:16];
    earningLabel.textAlignment = NSTextAlignmentLeft;
    
    
    
    UIButton *couponInfoBtn = [[UIButton alloc] init];
    _couponInfoBtn = couponInfoBtn;
    couponInfoBtn.backgroundColor = [UIColor redColor];
    [couponInfoBtn setTitle:@"领券 ¥3" forState:UIControlStateNormal];
    [couponInfoBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    couponInfoBtn.titleLabel.font = PFR16Font;
    [couponInfoBtn addTarget:self action:@selector(couponInfo) forControlEvents:UIControlEventTouchUpInside];
    
    [_bottomView addSubview:shareView];
    [shareView addSubview:earnPreIcon];
    [shareView addSubview:earningLabel];
    [_bottomView addSubview:couponInfoBtn];
    
    [shareView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self getPorductDetail:^(id obj) {
            [self shareAction];
        }];
    }];
    
    
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(MaxWidth/3);
    }];
    [earnPreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.width.height.mas_equalTo(18);
        make.top.mas_equalTo(16);
    }];
    [earningLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(earnPreIcon.mas_right).offset(5);
        make.width.mas_equalTo(65);
        make.top.mas_offset(13);
        make.height.mas_equalTo(23);
    }];
    
    
    [couponInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(MaxWidth * 2/3);
    }];
    [couponInfoBtn jk_addActionHandler:^(NSInteger tag) {
        [self getPorductDetail:^(id obj) {
            [self couponInfo];
        }];
    }];
}

- (void)getPorductDetail:(void (^)(id obj))suc {
    [[HJMainRequest shared] getProductDetailCache:YES productId:self.productId success:^(HJRecommendModel *recommendModel) {
        self.detailModel = recommendModel;
        [self setShareMianView];
        suc(nil);
    } fail:^(NSError *error) {
        
    }];
}

- (void)setShareMianView {
    HJShareMainImageView *imageV = [[HJShareMainImageView alloc] initWithFrame:CGRectMake(MaxWidth, 0, 375, 640) andDetailModel:self.detailModel];
    self.shareMainImageV = imageV;
    [self.view addSubview:imageV];
}

- (UIImage *)getShareImage {
    UIGraphicsBeginImageContextWithOptions(self.shareMainImageV.mj_size,NO, 0.0);//设置截屏大小
    [self.shareMainImageV.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)shareAction {
    NSLog(@"shareAction");
    weakify(self)
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if(!userInfo.token || userInfo.token.length == 0){
        [self pushToLoginVC:NO closeBlock:nil];
    }else {
        [self showTaobaoAuthorDailogSuccess:^(id responseObject) {
            [[HJMainRequest shared] getShareDataCache:YES productId:self.productId success:^(HJShareModel *share) {
                HJShareVC *shareVC = [[HJShareVC alloc] init];
                shareVC.mainShareImage = [weak_self getShareImage];
                shareVC.showCoupons = YES;
                shareVC.detailmodel = weak_self.detailModel;
                shareVC.shareModel = share;
                [weak_self.navigationController pushViewController:shareVC animated:YES];
            } fail:^(NSError *error) {
            }];
        }];
    }
    
    
}

- (void)couponInfo {
    weakify(self)
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if(!userInfo.token || userInfo.token.length == 0){
        [self pushToLoginVC:NO closeBlock:nil];
    }else {
        [self showTaobaoAuthorDailogSuccess:^(id responseObject) {
            [[AlibcManager shared] showWithAliSDKByParamsType:0 parentController:weak_self webView:nil url:weak_self.detailModel.coupon_share_url productid:self.detailModel.item_id success:nil fail:nil];
        }];
        
    }
}


-(NSDictionary *)parameterWithURL:(NSURL *) url {
    
    NSMutableDictionary *parm = [[NSMutableDictionary alloc]init];
    
    //传入url创建url组件类
    NSURLComponents *urlComponents = [[NSURLComponents alloc] initWithString:url.absoluteString];
    
    //回调遍历所有参数，添加入字典
    [urlComponents.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [parm setObject:obj.value forKey:obj.name];
    }];
    
    return parm;
}
@end
