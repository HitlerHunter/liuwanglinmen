//
//  LevelViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelViewController.h"
#import "LevelTopView.h"
#import "LevelInfoView.h"
#import "LevelUpAreaServerController.h"
#import "LevelUpServerController.h"
#import "LevelUpViewModel.h"
#import "LevelUpSuccessViewController.h"

@interface LevelViewController ()

@property (nonatomic, strong) LevelTopView *topView;
@property (nonatomic, strong) LevelInfoView *infoView;
@property (nonatomic, strong) LevelUpViewModel *viewModel;

@property (nonatomic, assign) LevelInfoType upToLevel;
@property (nonatomic, assign) BOOL isShowNotificationSelected;
@end

@implementation LevelViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    if (!_isShowNotificationSelected) {
        if (CurrentUser.userLvl == 0) {
            [_topView toSelectInde:1];
        }else if (CurrentUser.userLvl == 1) {
            [_topView toSelectInde:2];
        }else if (CurrentUser.userLvl == 3
                  || CurrentUser.userLvl == 2
                  || CurrentUser.userLvl == 4) {
            [_topView toSelectInde:2];
        }
    }else{
        _isShowNotificationSelected = NO;
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我要升级";
    
    [self.view addSubview:self.scrollView];
    _topView = [[LevelTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 246)];
    [self.scrollView addSubview:_topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(246);
    }];
    
    _viewModel = [LevelUpViewModel new];
    @weakify(self);
    _topView.levelClickBlock = ^(NSInteger index) {
        @strongify(self);
        [self.viewModel getLevelInfoConfigListWithLevel:index block:^(NSDictionary * _Nullable obj) {
            LevelInfoModel *model;
            NSString *money = obj[@"upgradeAmount"];
            if (index == 1) {
                model = [LevelInfoModel modelWithType:LevelInfoTypeVIP dic:obj];
                model.delegateUrl = DelegateFuYeURL;
                model.text_xy = @"同意《副业服务协议》及其服务条款";
                model.submitBlock = ^{
                    self.upToLevel = LevelInfoTypeVIP;
                    [LevelUpViewModel upLevelWithMoney:money level:@"1" block:nil];
                };
            }else if (index == 2) {
                model = [LevelInfoModel modelWithType:LevelInfoTypeServer dic:obj];
                model.delegateUrl = DelegateChuangYeURL;
                model.text_xy = @"同意《创业服务协议》及其服务条款";
                model.submitBlock = ^{
                    self.upToLevel = LevelInfoTypeServer;
                    [LevelUpViewModel upLevelWithMoney:money level:@"2" block:nil];
                };
            }else if (index == 3) {
                model = [LevelInfoModel modelWithType:LevelInfoTypeAreaServer dic:obj];
                model.submitBlock = ^{
                    self.upToLevel = LevelInfoTypeAreaServer;
                  LevelUpAreaServerController *vc = [LevelUpAreaServerController showAreaServerWithController:self];
                    vc.money = money;
                };
            }
            self.infoView.model = model;
        }];
    };
    
    _infoView = [LevelInfoView new];
    [self.scrollView addSubview:_infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(167);
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-15);
    }];
    

#pragma mark - 升级支付回调处理
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WXPayFinishedUplevelNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        AppPayStatus status = [x.object integerValue];
        LevelUpSuccessType type = LevelUpSuccessTypeVIP;
        if (status == AppPayStatusSuccess) {
            if (self.upToLevel == LevelInfoTypeVIP) {
                type = LevelUpSuccessTypeVIP;
                CurrentUser.userLvl = 1;
            }else if (self.upToLevel == LevelInfoTypeServer) {
                type = LevelUpSuccessTypeServer;
                CurrentUser.userLvl = 2;
            }else if (self.upToLevel == LevelInfoTypeAreaServer) {
                type = LevelUpSuccessTypeAreaServer;
                CurrentUser.userLvl = 3;
            }
            [LevelUpSuccessViewController showSuccessWithController:self type:type];
            
        }else if (status == AppPayStatusFailue) {
            [self showMessage:@"支付失败"];
        }else if (status == AppPayStatusCancel) {
            [self showMessage:@"支付取消"];
        }
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:LevelUpNeedSelectedNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        self.isShowNotificationSelected = YES;
        NSInteger index = [x.object integerValue];
        [self.topView toSelectInde:index];
    }];
}



@end
