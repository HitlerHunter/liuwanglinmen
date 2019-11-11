//
//  MarketInvestFailureController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketInvestFailureController.h"

@interface MarketInvestFailureController ()

@end

@implementation MarketInvestFailureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值失败";
    
    self.view.backgroundColor = LZWhiteColor;
    
    UIImageView *logo = [UIImageView viewWithImage:UIImageName(@"chongzhi_shibai")];
    [self.view addSubview:logo];
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.base_navigationbarHeight+58*LZScale);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:18 text:@"支付失败" textColor:rgb(53,53,53)];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logo.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.view);
    }];
    
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"重新支付" textColor:LZWhiteColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab.mas_bottom).offset(60);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(44);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [btn setDefaultGradientWithCornerRadius:22];
}

- (void)save{
    [self lz_popController];
}

@end
