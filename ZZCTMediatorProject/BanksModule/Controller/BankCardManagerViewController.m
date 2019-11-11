//
//  BankCardManagerViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/19.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BankCardManagerViewController.h"
#import "BankCardListViewController.h"
#import "CreditCardListViewController.h"

@interface BankCardManagerViewController ()

@property (nonatomic, strong) UIButton *creditCardBtn;
@property (nonatomic, strong) UIButton *bankCardBtn;
@end

@implementation BankCardManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"银行卡管理";
    self.scrollView.pagingEnabled = YES;
    
    [self.view addSubview:self.creditCardBtn];
    [self.view addSubview:self.bankCardBtn];
    [self.view addSubview:self.scrollView];
    
    [self.creditCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.top.mas_equalTo(LZApp.shareInstance.app_navigationBarHeight);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(kScreenWidth*0.5);
    }];
    
    [self.bankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(LZApp.shareInstance.app_navigationBarHeight);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(kScreenWidth*0.5);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.bankCardBtn.mas_bottom);
    }];
    
    CreditCardListViewController *vc1 = [[CreditCardListViewController alloc] initWithIsSelectVC:NO];
    [self addChildViewController:vc1];
    
    BankCardListViewController *vc2 = [[BankCardListViewController alloc] initWithIsSelectVC:NO];
    [self addChildViewController:vc2];
    
    [self.scrollView addSubview:vc1.view];
    [self.scrollView addSubview:vc2.view];
    
    [vc1.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.scrollView);
    }];
    
    [vc2.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.left.mas_equalTo(vc1.view.mas_right);
    }];
    
    [self.creditCardBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.bankCardBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn{
    
    if (btn.isSelected == YES) {
        return;
    }
    
    btn.selected = YES;
    if (btn == self.creditCardBtn) {
        self.bankCardBtn.selected = NO;
        [self.scrollView scrollToLeftWithAnimation:YES];
    }else{
        self.creditCardBtn.selected = NO;
        [self.scrollView scrollToRightWithAnimation:YES];
    }
}



- (UIButton *)creditCardBtn{
    if (!_creditCardBtn) {
        _creditCardBtn = [UIButton buttonWithFontSize:16 text:@"信用卡" textColor:UIColorHex(0x222222)];
        [_creditCardBtn setTitleColor:UIColorHex(0x890B0B) forState:UIControlStateSelected];
        [_creditCardBtn setBackgroundColor:UIColorHex(0xE1D6C4) forState:UIControlStateNormal];
        [_creditCardBtn setBackgroundColor:UIColorHex(0xD1C0A5) forState:UIControlStateSelected];
        _creditCardBtn.selected = YES;
    }
    
    return _creditCardBtn;
}

- (UIButton *)bankCardBtn{
    if (!_bankCardBtn) {
        _bankCardBtn = [UIButton buttonWithFontSize:16 text:@"储蓄卡" textColor:UIColorHex(0x222222)];
        [_bankCardBtn setTitleColor:UIColorHex(0x890B0B) forState:UIControlStateSelected];
        [_bankCardBtn setBackgroundColor:UIColorHex(0xE1D6C4) forState:UIControlStateNormal];
        [_bankCardBtn setBackgroundColor:UIColorHex(0xD1C0A5) forState:UIControlStateSelected];
    }
    
    return _bankCardBtn;
}
@end
