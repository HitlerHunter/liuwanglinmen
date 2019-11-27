//
//  Mine1ViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/21.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "Mine1ViewController.h"
#import "MineUserInfoHeader.h"
#import "HomeToolsView.h"

#import "MineKefuViewController.h"
#import "MineSettingViewController.h"
#import "IntegralRecordViewController.h"

#import "CTMediator+ModuleMineActions.h"

#import "AdvertManager.h"
#import "MineInterfaceCell.h"
#import "SYViewController.h"
#import "AuthenMerchantViewController.h"
#import "MineTeamViewController.h"
#import "BankCardListViewController.h"
#import "MineAddressViewController.h"
#import "MerchantManagerViewController.h"

@interface Mine1ViewController ()<HomeToolsViewDelegate>
@property (nonatomic, strong) MineUserInfoHeader *header;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconArray;
@property (nonatomic, strong) HomeToolsView *toolsView2;
@property (nonatomic, strong) HomeToolsView *toolsView3;

@property (nonatomic, strong) NSArray <AdvertModel *>*advertArray;
@end

@implementation Mine1ViewController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITabBarController *tabbar = (UITabBarController *)KeyWindow.rootViewController;
    if ([tabbar isKindOfClass:[UITabBarController class]]) {
        if (tabbar.selectedViewController != self.navigationController) {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    
    /**刷新用户等级信息*/
    [[UserManager shareInstance] refreshUserLevelAndTypeInfo];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    
    [self.view addSubview:self.scrollView];

    _header = [[MineUserInfoHeader alloc] init];
    [self.scrollView addSubview:_header];
    [_header mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(self.base_navigationbarHeight+100);
    }];

    [self.scrollView addSubview:self.toolsView2];
    [self.toolsView2 setToolsArray:@[@"收益明细",
                                     @"我的团队",@"我的订单",
                                     ]];
    [_toolsView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.header.mas_bottom).offset(5);
        make.height.mas_equalTo(90);
    }];
    
    //view3
    UIView *view3 = [UIView new];
    view3.backgroundColor = LZWhiteColor;
    [self.scrollView addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.toolsView2.mas_bottom).offset(5);
        make.height.mas_equalTo(111);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(15) text:@"我的商户" textColor:rgb(53,53,53)];
    [view3 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(15);
    }];
    
    _toolsView3 = [[HomeToolsView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-30, 60)];
    _toolsView3.topSpacing = 5;
    if (CurrentUserMerchant.pmsMerchantInfo.status_lz == AuthenMerchantStatusSuccess) {
        [_toolsView3 setToolsArray:@[@"商户信息",
         @"线上开店",@"商户管理",
        ]];
    }else{
        [_toolsView3 setToolsArray:@[@"商户入驻",
         @"线上开店",@"商户管理",
        ]];
    }
    
    _toolsView3.delegate = self;
    [view3 addSubview:_toolsView3];
    [_toolsView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(60);
    }];
    
    //view4
    UIView *view4 = [UIView new];
    view4.backgroundColor = LZWhiteColor;
    [self.scrollView addSubview:view4];
    [view4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(view3.mas_bottom).offset(15);
        make.height.mas_greaterThanOrEqualTo(47);
        make.bottom.mas_equalTo(0);
    }];
    
    @weakify(self);
    MineInterfaceCell *cell_card = [MineInterfaceCell cellWithImage:@"mine_card" title:@"银行卡管理" block:^{
        BankCardListViewController *vc2 = [[BankCardListViewController alloc] initWithIsSelectVC:NO];
        PushController(vc2);
    }];
    
    MineInterfaceCell *cell_address = [MineInterfaceCell cellWithImage:@"mine_address" title:@"收货地址" block:^{
        [AppCenter setEmptyControllerTitle:@"收货地址"];
        MineAddressViewController *vc = [MineAddressViewController new];
        PushController(vc);
    }];
    
    MineInterfaceCell *cell_kefu = [MineInterfaceCell cellWithImage:@"mine_kefu" title:@"联系客服" block:^{
        @strongify(self);
        MineKefuViewController *kefu = [MineKefuViewController new];
        PushController(kefu);
    }];
    
    MineInterfaceCell *cell_setting = [MineInterfaceCell cellWithImage:@"mine_setting" title:@"设置" block:^{
        @strongify(self);
        MineSettingViewController *vc = [MineSettingViewController new];
        PushController(vc);
    }];
    
    NSArray *cellArray = @[cell_card,cell_address,cell_kefu,cell_setting];
    
    UIView *lastView = nil;
    for (MineInterfaceCell *cell in cellArray) {
        [view4 addSubview:cell];
        
        if (!lastView) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.mas_equalTo(0);
                make.height.mas_equalTo(47);
            }];
        }else {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(47);
                make.top.mas_equalTo(lastView.mas_bottom);
            }];
        }
        lastView = cell;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    view3.lz_setView.lz_shadow(8, rgba(3, 0, 0, 0.12), CGSizeMake(0, 1), 1, 9);
    view4.lz_setView.lz_shadow(8, rgba(3, 0, 0, 0.12), CGSizeMake(0, 1), 1, 9);
    
}


#pragma mark - HomeToolsView delegate
- (void)HomeToolsView:(HomeToolsView *)toolsView clickTitle:(NSString *)title {
    if ([title isEqualToString:@"收益明细"]) {
        if([AppCenter isDevelopmentNumber]){
            [AppCenter setEmptyControllerTitle:@"收益明细"];
            [AppCenter toEmptyController];
            return;
        }
        SYViewController *vc = [SYViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"商户入驻"] || [title isEqualToString:@"商户信息"]) {
        
        [AuthenMerchantViewController showAuthenMerchantWithViewController:self];
    }else if ([title isEqualToString:@"我的团队"]) {
        MineTeamViewController *vc = [MineTeamViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"线上开店"]) {
        APPCenterPowerCheckMerchant
        [[CTMediator sharedInstance] CTMediator_EditShopInfoViewControllerWithNav:self.navigationController];
    }else if ([title isEqualToString:@"商户管理"]) {
        if ([AppCenter checkLevel:1]) {
            MerchantManagerViewController *vc = [MerchantManagerViewController new];
            PushController(vc);
        };
    }else if ([title isEqualToString:@"我的订单"]) {
        
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_OrderManagerController];
        PushController(vc);
    }
    
    
}

/**
 if ([title isEqualToString:@"积分明细"]) {
       
     IntegralRecordViewController *vc = [IntegralRecordViewController new];
     PushController(vc);
 }else
 */

- (HomeToolsView *)toolsView2{
    if (!_toolsView2) {
        _toolsView2 = [[HomeToolsView alloc] initWithFrame:CGRectMake(0, self.header.bottom+8, kScreenWidth, 90)];
        _toolsView2.delegate = self;
    }
    return _toolsView2;
}
@end
