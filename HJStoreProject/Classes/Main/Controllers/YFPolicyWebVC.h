//
//  YFPolicyWebVC.h
//  Smartpaw
//
//  Created by 张忠旭 on 2017/12/29.
//  Copyright © 2017年 hihisoft. All rights reserved.
//

#import "HJSuperViewController.h"
#import <WebKit/WebKit.h>
@interface YFPolicyWebVC : HJSuperViewController 

@property(nonatomic,strong) NSString *labTitle;
@property(nonatomic,strong) NSString *policyUrl;
@property (nonatomic ,strong) WKWebView *webView;
@property(nonatomic,copy) void (^onBackClick)(id obj);
@property(nonatomic,copy) void (^taobaoAuthorSuccess)(id obj);
- (void)loadURL:(NSString *)url;
@end
