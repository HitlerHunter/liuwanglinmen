//
//  MineNoticeSettingViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineNoticeSettingViewController.h"
#import "SettingSwitchView.h"

@interface MineNoticeSettingViewController ()

@property (nonatomic, strong) SettingSwitchView *cell1;
@property (nonatomic, strong) SettingSwitchView *cell2;
@property (nonatomic, strong) SettingSwitchView *cell3;
@property (nonatomic, strong) SettingSwitchView *cell4;
@end

@implementation MineNoticeSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息推送设置";
    
    _cell1 = [SettingSwitchView new];
    _cell1.titleLabel.text = @"接受消息推送通知";
    [self.view addSubview:_cell1];
    [_cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.base_navigationbarHeight+10);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    _cell1.isOn = CurrentUser.isOpenAppNotification;
    
    _cell1.vauleChangedBlock = ^(BOOL isOn) {
        CurrentUser.isOpenAppNotification = isOn;
    };
    
    /*
    _cell2 = [SettingSwitchView new];
    _cell2.titleLabel.text = @"悬赏消息通知";
    [self.view addSubview:_cell2];
    [_cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cell1.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.cell1);
        make.height.mas_equalTo(self.cell1);
    }];
    
    UILabel *messageLabel1 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"开启后，用户领取您的悬赏任务，将给您推送消息提醒。" textColor:rgb(152,152,152)];
    messageLabel1.numberOfLines = 0;
    [self.view addSubview:messageLabel1];
    [messageLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cell2.mas_bottom).offset(8);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    _cell3 = [SettingSwitchView new];
    _cell3.titleLabel.text = @"积分到账通知";
    [self.view addSubview:_cell3];
    [_cell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageLabel1.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.cell1);
        make.height.mas_equalTo(self.cell1);
    }];
    
    UILabel *messageLabel2 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"开启后，积分到账将给您推送消息提醒。" textColor:rgb(152,152,152)];
    messageLabel2.numberOfLines = 0;
    [self.view addSubview:messageLabel2];
    [messageLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cell3.mas_bottom).offset(8);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    _cell4 = [SettingSwitchView new];
    _cell4.titleLabel.text = @"优惠券通知";
    [self.view addSubview:_cell4];
    [_cell4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageLabel2.mas_bottom).offset(10);
        make.left.right.mas_equalTo(self.cell1);
        make.height.mas_equalTo(self.cell1);
    }];
    
    UILabel *messageLabel3 = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"开启后，用户领取优惠券，将给您推送消息提醒。" textColor:rgb(152,152,152)];
    messageLabel3.numberOfLines = 0;
    [self.view addSubview:messageLabel3];
    [messageLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cell4.mas_bottom).offset(8);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    self.cell2.hidden = !CurrentUser.isOpenAppNotification;
    self.cell3.hidden = !CurrentUser.isOpenAppNotification;
    self.cell4.hidden = !CurrentUser.isOpenAppNotification;
    messageLabel1.hidden = !CurrentUser.isOpenAppNotification;
    messageLabel2.hidden = !CurrentUser.isOpenAppNotification;
    messageLabel3.hidden = !CurrentUser.isOpenAppNotification;
    
    @weakify(self);
    [RACObserve(CurrentUser, isOpenAppNotification) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.cell2.hidden = !CurrentUser.isOpenAppNotification;
        self.cell3.hidden = !CurrentUser.isOpenAppNotification;
        self.cell4.hidden = !CurrentUser.isOpenAppNotification;
        messageLabel1.hidden = !CurrentUser.isOpenAppNotification;
        messageLabel2.hidden = !CurrentUser.isOpenAppNotification;
        messageLabel3.hidden = !CurrentUser.isOpenAppNotification;
    }];
    
    [self getMsgConfig];
    
    _cell2.vauleChangedBlock = ^(BOOL isOn) {
        @strongify(self);
        [self configMessage];
    };
    
    _cell3.vauleChangedBlock = ^(BOOL isOn) {
        @strongify(self);
        [self configMessage];
    };
    
    _cell4.vauleChangedBlock = ^(BOOL isOn) {
        @strongify(self);
        [self configMessage];
    };
     
     */
}

- (void)configMessage{
    NewParams;
    [params setSafeObject:_cell2.isOn?@"1":@"0" forKey:@"isPushRewardMsg"];
    [params setSafeObject:_cell3.isOn?@"1":@"0" forKey:@"isPushPointsMsg"];
    [params setSafeObject:_cell4.isOn?@"1":@"0" forKey:@"isPushCouponMsg"];
    [params setSafeObject:CurrentUser.sysUser.userId forKey:@"shopNo"];
    
    ZZNetWorker.POST.zz_url(@"/general/msg/config").zz_param(params)
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (!model_net.success) {
            [self showMessage:model_net.message];
        }
    });

}

- (void)getMsgConfig{
   
    NewParams;
    [params setSafeObject:CurrentUser.sysUser.userId forKey:@"shopNo"];
    
    ZZNetWorker.GET.zz_url(@"/general/msg/queryMsgConfig").zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            if (IsNull(model_net.data)) {
                self.cell2.isOn = YES;
                self.cell3.isOn = YES;
                self.cell4.isOn = YES;
                return ;
            }
            
            BOOL isPushCouponMsg = [model_net.data[@"isPushCouponMsg"] boolValue];
            BOOL isPushPointsMsg = [model_net.data[@"isPushPointsMsg"] boolValue];
            BOOL isPushRewardMsg = [model_net.data[@"isPushRewardMsg"] boolValue];
            
            self.cell2.isOn = isPushRewardMsg;
            self.cell3.isOn = isPushPointsMsg;
            self.cell4.isOn = isPushCouponMsg;
        }
    });
}

@end
