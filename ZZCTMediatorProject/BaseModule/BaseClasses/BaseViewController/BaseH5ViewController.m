//
//  BaseH5ViewController.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BaseH5ViewController.h"
#import "LZWKScriptMessageHandler.h"
#import "PaySuccessViewController.h"

@interface BaseH5ViewController ()<LZWKScriptMessageHandlerDelegate>
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation BaseH5ViewController


- (instancetype)initWithUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
        _willEncode = YES;
        _aotuSetTitle = YES;
    }
    return self;
}

- (instancetype)initWithNoEncodeUrl:(NSString *)url{
    self = [super init];
    if (self) {
        _url = url;
        _willEncode = NO;
        _aotuSetTitle = YES;
    }
    return self;
}

- (void)lz_popController{
    
    if([self.webView canGoBack]){
        [self.webView goBack];
    }else {
        
        [super lz_popController];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    @weakify(self);
    [self addRightItemWithImage:@"" title:@"关闭" font:nil color:nil block:^{
        [super lz_popController];
    }];
    

    [[RACObserve(self.webView, title) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.aotuSetTitle) {
            self.title = self.webView.title;
        }
    }];
    
    [[RACObserve(self.webView, estimatedProgress) takeUntil:self.webView.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        
        self.progressView.alpha = 1.0f;
        BOOL animated = self.webView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:[x floatValue] animated:animated];
        
        if (self.webView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.progressView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }];
    
    [self.view addSubview:self.progressView];
    
    SDLog(@"H5_url:\n%@",self.url);
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.view bringSubviewToFront:self.progressView];
  
}

    //js 交互-> 选择卡
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{};

    //js 交互-> 选择卡
- (void)lz_userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"h5_back"]) {//创建还款计划完成
            
        [self.navigationController popToRootViewControllerAnimated:YES];

    }
    
    if ([message.name isEqualToString:@"h5_needToLevelUp"]) {
        self.tabBarController.selectedIndex = 2;
        [super lz_popController];
    }
    
    if ([message.name isEqualToString:@"h5_backToSuccess"]) {
                
        NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        NSMutableArray *vcs2 = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
        if (vcs.count>1) {
            [vcs removeLastObject];
        }
        PaySuccessViewController *vc = [PaySuccessViewController new];

        [vcs addObject:vc];
        [vcs2 addObject:vc];
        [self.navigationController setViewControllers:vcs2 animated:YES];
        [self.navigationController setViewControllers:vcs animated:NO];
        
    }
    
    if ([message.name isEqualToString:@"placeOrderH5"]) {
        [AppPayManager shareInstance].currentPayType = AppPayTypeBoomGoodsPay;
        if ([message.body isKindOfClass:[NSDictionary class]]) {
            NSDictionary *payDic = message.body[@"params"][@"data"];
            [[AppPayManager shareInstance] WXPayWithDic:payDic];
        }
    
    }
    
};

/**
 NSString *title = [tempDic objectForKey:@"title"];
     NSString *content = [tempDic objectForKey:@"content"];
     NSString *url = [tempDic objectForKey:@"url"];
     // 在这里执行分享的操作

     // 将分享结果返回给js
     NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
     [self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
         NSLog(@"%@----%@",result, error);
     }];
 
 */

#pragma mark - WKUIDelegate
    // 创建一个新的WebView
- (WKWebView *)webView:(WKWebView *)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration
   forNavigationAction:(WKNavigationAction *)navigationAction
        windowFeatures:(WKWindowFeatures *)windowFeatures{
    
    return [[WKWebView alloc]initWithFrame:self.webView.frame configuration:configuration];
}
    // 输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler{
    SDLog(@"输入框:%@",prompt);
    completionHandler(@"http");
}
    // 确认框
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
    // 警告框
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *credential))completionHandler {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        
        if ([challenge previousFailureCount] == 0) {
            
            NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
            
            completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
            
        } else {
            
            completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
            
        }
        
    } else {
        
        completionHandler(NSURLSessionAuthChallengeCancelAuthenticationChallenge, nil);
        
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{}


- (WKWebView *)webView{
    if (!_webView) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        WKUserContentController *userContentController = [[WKUserContentController alloc]init];
        config.userContentController = userContentController;
        
        
        [userContentController addScriptMessageHandler:[LZWKScriptMessageHandler handlerWithDelegate:self] name:@"h5_back"];
        [userContentController addScriptMessageHandler:[LZWKScriptMessageHandler handlerWithDelegate:self] name:@"h5_needToLevelUp"];
        [userContentController addScriptMessageHandler:[LZWKScriptMessageHandler handlerWithDelegate:self] name:@"h5_backToSuccess"];
        [userContentController addScriptMessageHandler:[LZWKScriptMessageHandler handlerWithDelegate:self] name:@"placeOrderH5"];
        
            // 根据需要去设置对应的属性
        WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectMake(0, LZApp.shareInstance.app_navigationBarHeight, kScreenWidth, self.contentHeight) configuration:config];
        webView.navigationDelegate = self;
        webView.UIDelegate = self;
        
        if (@available(iOS 11.0, *)) {
            webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        _webView = webView;
    }
    return _webView;
}

- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.frame = CGRectMake(0, LZApp.shareInstance.app_navigationBarHeight, kScreenWidth, 8);
        [_progressView setTrackTintColor:LZWhiteColor];
        _progressView.progressTintColor = LZGreenColor;
    }
    return _progressView;
}
@end
