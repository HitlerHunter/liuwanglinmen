//
//  H5CommonViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/4/28.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "H5CommonViewController.h"

@interface H5CommonViewController ()

@end

@implementation H5CommonViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    if(self.willEncode){
        self.url = [self.url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
        SDLog(@"H5_EncodeURL:\n%@",self.url);
    }
    
    NSURL *url = [NSURL URLWithString:self.url];
    
    //加载请求的时候忽略缓存
    NSMutableURLRequest *request;
    if (self.URLCache) {
        request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10.0];
    }else{
        request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    }
    
    //    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
