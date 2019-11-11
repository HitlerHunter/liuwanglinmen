//
//  BaseH5ViewController.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/4/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WKWebViewConfiguration.h>
#import <WebKit/WebKit.h>
#import <WebKit/WKUserContentController.h>

@class RecieptChannelModel;
@interface BaseH5ViewController : SDBaseViewController <WKUIDelegate,WKScriptMessageHandler,WKNavigationDelegate>

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL willEncode;
@property (nonatomic, assign) BOOL aotuSetTitle;

/**
 是否缓存url
 */
@property (nonatomic, assign) BOOL URLCache;

- (instancetype)initWithUrl:(NSString *)url;
- (instancetype)initWithNoEncodeUrl:(NSString *)url;
@end
