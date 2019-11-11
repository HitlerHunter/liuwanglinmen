//
//  MarketHomeViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketHomeViewController.h"
#import "HomeToolsView.h"
#import "MarketMessageViewController.h"
#import "CouponListViewController.h"

@interface MarketHomeViewController ()<HomeToolsViewDelegate>
@property (nonatomic, strong) HomeToolsView *toolsView2;
@end

@implementation MarketHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"营销";
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(15, self.base_navigationbarHeight+15.5, 14, 4)];
    [line setDefaultGradient];
    [self.view addSubview:line];
    line.transform = CGAffineTransformMakeRotation(M_PI_2);
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"消费前营销" textColor:rgb(53,53,53)];
    label_title.frame = CGRectMake(24.5, line.top, 100, 16);
    [self.view addSubview:label_title];
    
    [self addUIToolView2];
}

 
- (void)addUIToolView2{
    [self.view addSubview:self.toolsView2];
    
    [self.toolsView2 setToolsArray:@[@"短信营销",@"优惠券",
                                     ]];
}


#pragma mark - HomeToolsView delegate
- (void)HomeToolsView:(nonnull HomeToolsView *)toolsView clickTitle:(nonnull NSString *)title {
    if ([title isEqualToString:@"短信营销"]) {
        MarketMessageViewController *vc = [MarketMessageViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"优惠券"]) {
        CouponListViewController *vc = [CouponListViewController new];
        PushController(vc);
    }
    
    
}

- (HomeToolsView *)toolsView2{
    if (!_toolsView2) {
        _toolsView2 = [[HomeToolsView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight+30, kScreenWidth, 150)];
        _toolsView2.delegate = self;
    }
    return _toolsView2;
}
@end
