//
//  H5NoNavBarViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/5/2.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "H5NoNavBarViewController.h"

@interface H5NoNavBarViewController ()

@end

@implementation H5NoNavBarViewController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.

    NSCharacterSet *encodeUrlSet = [NSCharacterSet URLQueryAllowedCharacterSet];
    
    if(self.willEncode)self.url = [self.url stringByAddingPercentEncodingWithAllowedCharacters:encodeUrlSet];
    
    NSURL *url = [NSURL URLWithString:self.url];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    self.webView.frame = CGRectMake(0, 0, kScreenWidth, self.contentHeight-20);
    
    if (@available(iOS 11.0, *)) {
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 20, 80, 40)];
    @weakify(self);
    [leftBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self lz_popController];
    }];
    [self.view addSubview:leftBtn];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

    //当有一个或多个手指触摸事件在当前视图或window窗体中响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    SDLog(@"touch (x, y) is (%d, %d)", x, y);
}
@end
