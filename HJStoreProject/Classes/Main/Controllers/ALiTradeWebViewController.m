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

//#import "ALiCartService.h"

@interface ALiTradeWebViewController()
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
    if(![urlString containsString:@"token"]) {
        HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
        if ([urlString containsString:@"?"]) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@&token=%@",urlString,userInfo.token]];
            request = [NSURLRequest requestWithURL:url];
        }else{
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?token=%@",urlString,userInfo.token]];
            request = [NSURLRequest requestWithURL:url];
        }
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


@end
