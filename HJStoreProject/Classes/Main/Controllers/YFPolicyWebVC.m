//
//  YFPolicyWebVC.m
//  Smartpaw
//
//  Created by 张忠旭 on 2017/12/29.
//  Copyright © 2017年 hihisoft. All rights reserved.
//

#import "YFPolicyWebVC.h"
#import <Masonry.h>
#import "WebViewJavascriptBridge.h"
#import "HJUserInfoModel.h"
#import "HJMainRequest.h"

@interface YFPolicyWebVC ()<WKNavigationDelegate,WKScriptMessageHandler>
@property (retain, nonatomic) UIProgressView *progressView;
@property (nonatomic ,strong) NSString *currentUrl;
@property (nonatomic ,strong) WebViewJavascriptBridge *bridge;
@end

@implementation YFPolicyWebVC
- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [_webView removeObserver:self forKeyPath:@"title"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}


- (void)setPolicyUrl:(NSString *)policyUrl {
    HJUserInfoModel *userInfo = [HJUserInfoModel getSavedUserInfo];
    if (![policyUrl containsString:@"token"] && ![policyUrl containsString:@"oauth.m.taobao.com/authorize"]) {
        policyUrl = [NSString stringWithFormat:@"%@?token=%@",policyUrl,userInfo.token];
    }
    NSLog(@"policyUrl = %@",policyUrl);
    _policyUrl = policyUrl;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self customBackButton];
    // Do any additional setup after loading the view.
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge setWebViewDelegate:self];
    [self.bridge registerHandler:@"close" handler:^(id data, WVJBResponseCallback responseCallback) {

    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadURL:self.policyUrl];

}

- (void)loadURL:(NSString *)url{
    url = [url stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    url = [url stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    if (![url containsString:@"token"]) {
        url = [NSString stringWithFormat:@"%@?token=%@",url,[HJUserInfoModel getSavedUserInfo].token];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[[NSURL alloc]initWithString:url]];
    request.timeoutInterval = 10;
    if (![url hasPrefix:@"http"]) {
        return;
    }
    _currentUrl = url;
    [_webView loadRequest:request];
}


- (void)setUpUI{
    
    // 禁止选择CSS
    NSString *css = @"body{-webkit-user-select:none;-webkit-user-drag:none;}";
    
    // CSS选中样式取消
    NSMutableString *javascript = [NSMutableString string];
    [javascript appendString:@"var style = document.createElement('style');"];
    [javascript appendString:@"style.type = 'text/css';"];
    [javascript appendFormat:@"var cssContent = document.createTextNode('%@');", css];
    [javascript appendString:@"style.appendChild(cssContent);"];
    [javascript appendString:@"document.body.appendChild(style);"];
    
    // javascript注入
    WKUserScript *noneSelectScript = [[WKUserScript alloc] initWithSource:javascript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
    [userContentController addUserScript:noneSelectScript];
    
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.allowsInlineMediaPlayback = YES;
    config.userContentController = userContentController;
    _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
    _webView.navigationDelegate = self;
    
    [config.userContentController addScriptMessageHandler:self name:@"close"];
    
    [self addProgressObServer];

    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
    }];
    
    self.progressView = [[UIProgressView alloc] init];
    _progressView.progressTintColor = [UIColor jk_colorWithHexString:@"#e8c92f"];
     [self.view addSubview:self.progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@1.5);
    }];
    //设置进度条的高度，下面这句代码表示进度条的宽度变为原来的1倍，高度变为原来的1.5倍.
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 2.0f);

}



#pragma marke - observer
- (void)addProgressObServer{
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressView.progress = _webView.estimatedProgress;
        if (self.progressView.progress == 1) {
            /*
             *添加一个简单的动画，将progressView的Height变为1.4倍，在开始加载网页的代理中会恢复为1.5倍
             *动画时长0.25s，延时0.3s后开始动画
             *动画结束后将progressView隐藏
             */
            __weak typeof (self)weakSelf = self;
            [UIView animateWithDuration:0.25f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                weakSelf.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.4f);
            } completion:^(BOOL finished) {
                weakSelf.progressView.hidden = YES;
            }];
        }
    }else if([keyPath isEqualToString:@"title"]){
        self.title = _webView.title;
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark- delegate



- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    if (!navigationAction.targetFrame.isMainFrame) {
        [webView evaluateJavaScript:@"var a = document.getElementsByTagName('a');for(var i=0;i<a.length;i++){a[i].setAttribute('target','');}" completionHandler:nil];
    }

    NSString *urlStr = [navigationAction.request.URL absoluteString];
    NSLog(@"urlStr = %@,_currentUrl = %@",urlStr,_currentUrl);
    if ([_currentUrl isEqualToString:urlStr]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    _currentUrl = urlStr;
    
    if ([_currentUrl containsString:@"token"]) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }else{
        [self loadURL:urlStr];
        decisionHandler(WKNavigationActionPolicyCancel);
        return;
    }
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    NSLog(@"开始加载网页");
    
    NSString *urlStr = [webView.URL absoluteString];
    _currentUrl = urlStr;

    //开始加载网页时展示出progressView
    self.progressView.hidden = NO;
    //开始加载网页的时候将progressView的Height恢复为1.5倍
    self.progressView.transform = CGAffineTransformMakeScale(1.0f, 1.5f);
    //防止progressView被网页挡住
    [self.view bringSubviewToFront:self.progressView];
}

//加载完成
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"加载完成");

}

//加载失败
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    NSLog(@"加载失败 %@",error);
}


- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    CFDataRef exceptions = SecTrustCopyExceptions (serverTrust);
    SecTrustSetExceptions (serverTrust, exceptions);
    CFRelease (exceptions);
    completionHandler (NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
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

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    if ([message.name isEqualToString:@"close"]) {
        NSLog(@">>>>>>>>>>>>>>>>>>>>调用了close方法");
        if([message.body integerValue] == 1) {
            [[HJMainRequest shared] getEarningConfigerSuccess:^(id responseObject) {
            } fail:^(NSError *error) {
            }];
            if (self.taobaoAuthorSuccess) {
                self.taobaoAuthorSuccess(nil);
            }
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [self.view makeToast:@"授权失败" duration:2.0 position:CSToastPositionCenter];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
