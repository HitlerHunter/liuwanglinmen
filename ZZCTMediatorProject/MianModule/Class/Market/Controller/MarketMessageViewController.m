//
//  MarketMessageViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessageViewController.h"
#import "MarketPortCell.h"
#import "MarketInvestRecordVC.h"
#import "MarketBoardManagerViewController.h"
#import "WakeUpAddBirthdayController.h"
#import "MarkSendMessageViewController.h"
#import "MessageSendRecordViewController.h"
#import "MessageSendQuestionViewController.h"
#import "MarketMessageInvestViewController.h"

@interface MarketMessageViewController ()<LDActionSheetDelegate>
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UIButton *btn;
@end

@implementation MarketMessageViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        //获取剩余短信
    [[MarketMessageManager shareInstance] updateMessageInfo];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"短信营销";
    
    [self.view addSubview:self.scrollView];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = LZWhiteColor;
    [self.scrollView addSubview:topView];
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 58));
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"剩余短信(条):" textColor:rgb(152,152,152)];
    [topView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15*LZScale);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(topView);
    }];
    
    UILabel *messageNumberLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(20) text:[MarketMessageManager shareInstance].messageCountStr textColor:rgb(53,53,53)];
    [topView addSubview:messageNumberLabel];
    
    [messageNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(6);
        make.width.mas_equalTo(150);
        make.centerY.mas_equalTo(topView);
    }];
    
    //短信
    [RACObserve([MarketMessageManager shareInstance], changed) subscribeNext:^(id  _Nullable x) {
        messageNumberLabel.text = [MarketMessageManager shareInstance].messageCountStr;
    }];
    
    
    UIButton *btn = [UIButton buttonWithFontSize:13 text:@"立即充值" textColor:LZWhiteColor];
    [topView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15*LZScale);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(28);
        make.centerY.mas_equalTo(topView);
    }];
    
    [topView layoutIfNeeded];
    [btn setDefaultGradientWithCornerRadius:6];
    
    _numberLabel = messageNumberLabel;
    _btn = btn;
    
    [btn addTarget:self action:@selector(toInvest) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray *array = @[@{@"title":@"生日祝福",
                         @"info":@"会员生日，专属关怀",
                         @"icon":@"birthday_gift",
                         },
                       @{@"title":@"会员唤醒",
                         @"info":@"唤醒会员，精准营销",
                         @"icon":@"huiyuanhuanxing",
                         },
                       @{@"title":@"短信群发",
                         @"info":@"自定义短信内容、发送对象",
                         @"icon":@"duanxinqunfa",
                         },];
    
    
    UIView *lastView = topView;
    for (NSInteger i = 0; i < array.count; i++) {
        NSDictionary *dic = array[i];
        NSString *title = dic[@"title"];
        NSString *info = dic[@"info"];
        NSString *icon = dic[@"icon"];
        
        MarketPortCell *cell = [MarketPortCell new];
        cell.label_title.text = title;
        cell.label_info.text = info;
        cell.imageView.image = UIImageName(icon);
        [self.scrollView addSubview:cell];
        
        [cell mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15*LZScale);
            make.right.mas_equalTo(-15*LZScale);
            make.top.mas_equalTo(lastView.mas_bottom).offset(10);
            make.height.mas_equalTo(92);
        }];
        
        @weakify(self);
        cell.clickBlock = ^(NSString * _Nonnull title) {
            @strongify(self);
            [self cellClickWithTitle:title];
        };
        
        lastView = cell;
    }
    
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.scrollView).offset(20);
    }];
    
    @weakify(self);
    [self addRightItemWithImage:@"more_market_message" title:nil font:nil color:nil block:^{
        @strongify(self);
        [self showAlertView];
    }];
    
    
    //获取模板
    [[MarketBoardManager shareInstance] refreshData];
}

- (void)cellClickWithTitle:(NSString *)title{
    
    if ([title isEqualToString:@"生日祝福"]) {
        WakeUpAddBirthdayController *wakeUp = [[WakeUpAddBirthdayController alloc] initWithMarketPlanType:MarketPlanTypeBirthday];
        PushController(wakeUp);
    }else if ([title isEqualToString:@"会员唤醒"]) {
        WakeUpAddBirthdayController *wakeUp = [[WakeUpAddBirthdayController alloc] initWithMarketPlanType:MarketPlanTypeWakeUp];
        PushController(wakeUp);
    }else if ([title isEqualToString:@"短信群发"]) {
        MarkSendMessageViewController *vc = [MarkSendMessageViewController new];
        PushController(vc);
    }
    
    
}

//充值
- (void)toInvest{
    MarketMessageInvestViewController *vc = [MarketMessageInvestViewController new];
    PushController(vc);
}

- (void)showAlertView{
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"查看充值记录",@"模板管理",@"发送记录", nil];
    [sheet showInView:KeyWindow];
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        MarketInvestRecordVC *vc = [MarketInvestRecordVC new];
        PushController(vc);
    }else if (buttonIndex == 1){
        MarketBoardManagerViewController *vc = [MarketBoardManagerViewController new];
        PushController(vc);
    }else if (buttonIndex == 2){
        MessageSendRecordViewController *vc = [MessageSendRecordViewController new];
        PushController(vc);
    }else if (buttonIndex == 3){
        //,@"常见问题"
        MessageSendQuestionViewController *vc = [MessageSendQuestionViewController new];
        PushController(vc);
    }
    
    
}

@end
