//
//  MarketInvestSuccessController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketInvestSuccessController.h"

@interface MarketInvestSuccessController ()

@property (nonatomic, strong) NSString *money;
@end

@implementation MarketInvestSuccessController

- (instancetype)initWithMoney:(NSString *)money{
    self = [super init];
    if (self) {
        _money = money;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值成功";
    
    self.view.backgroundColor = LZWhiteColor;
    
    UIImageView *logo = [UIImageView viewWithImage:UIImageName(@"chongzhi_success")];
    [self.view addSubview:logo];
    
    [logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.base_navigationbarHeight+66*LZScale);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:18 text:@"充值完成" textColor:rgb(53,53,53)];
    [self.view addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logo.mas_bottom).offset(15);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *lab2 = [UILabel labelWithFontSize:13 text:@"您已充值(元)" textColor:rgb(152,152,152)];
    [self.view addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab.mas_bottom).offset(30);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UILabel *label_money = [UILabel labelWithFontSize:30 text:self.money textColor:rgb(255,81,0)];
    [self.view addSubview:label_money];
    [label_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(lab2.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.view);
    }];
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"完成" textColor:LZWhiteColor];
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_money.mas_bottom).offset(30);
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
