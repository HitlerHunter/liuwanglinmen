//
//  MarketMessageInvestViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketMessageInvestViewController.h"
#import "MarketMessageMoneyView.h"
#import "MarketMessageOtherMoneyView.h"
#import "MarketMessagePayWayView.h"
#import "MarketInvestSuccessController.h"
#import "MarketInvestFailureController.h"
#import "MarketMessagePayManager.h"


@interface MarketMessageInvestViewController ()<MarketMessageMoneyViewDelegate,MarketMessagePayWayViewDelegate>

@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) MarketMessageMoneyView *moneyView;
@property (nonatomic, strong) MarketMessageOtherMoneyView *otherMoneyView;
@property (nonatomic, strong) MarketMessagePayWayView *payWayView;
@property (nonatomic, strong) MarketMessagePayManager *payManager;
@end

@implementation MarketMessageInvestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值中心";
    
    _payManager = [MarketMessagePayManager new];
    
    [self.view addSubview:self.scrollView];
    [self addView1];
    
//    [[MarketMessageManager shareInstance] getMessageRechargeRule:^(BOOL isSuccess) {
//        if (isSuccess) {
//            [self configView];
//        }
//    }];
    
    [MarketMessageManager shareInstance].messagePrice = 0.1;
    [self configView];
}

- (void)configView{
    [self addMoneyView];
    [self addOtherMoneyView];
    [self addPayWayView];
    [self initSaveBtn];
    
        //支付回调处理
    @weakify(self);
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WXPayFinishedMarketMessageNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        AppPayStatus status = [x.object integerValue];
        if (status == AppPayStatusSuccess) {
            MarketInvestSuccessController *success = [[MarketInvestSuccessController alloc] initWithMoney:self.payManager.money];
            PushIdController(success, LinearBackId_Order);
        }else if (status == AppPayStatusFailue) {
            MarketInvestFailureController *failure = [MarketInvestFailureController new];
            PushController(failure);
        }else if (status == AppPayStatusCancel) {
            [self showMessage:@"支付取消"];
        }
    }];
}

- (void)addView1{
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = LZWhiteColor;
    [self.scrollView addSubview:topView];
    _topView = topView;
    
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth, 58));
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"剩余短信(条):" textColor:rgb(152,152,152)];
    [topView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(80);
        make.centerY.mas_equalTo(topView);
    }];
    
    UILabel *messageNumberLabel = [UILabel labelWithFont:Font_PingFang_SC_Medium(20) text:[MarketMessageManager shareInstance].messageCountStr textColor:rgb(255,81,0)];
    [topView addSubview:messageNumberLabel];
    
    [messageNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(lab.mas_right).offset(6);
        make.width.mas_equalTo(150);
        make.centerY.mas_equalTo(topView);
    }];
    
    [RACObserve([MarketMessageManager shareInstance], changed) subscribeNext:^(id  _Nullable x) {
        messageNumberLabel.text = [MarketMessageManager shareInstance].messageCountStr;
    }];
    
}


- (void)addMoneyView{
    
    _moneyView = [MarketMessageMoneyView new];
    _moneyView.delegate = self;
    [self.scrollView addSubview:_moneyView];
    
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.topView.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(42);
    }];
    
    NSArray *arr = @[@{@"money":@"50",
                       @"count":@"1000",},
                     @{@"money":@"100",
                       @"count":@"2000",},
                     @{@"money":@"200",
                       @"count":@"4000",}
                     ];
    
    
    
    
    for (int i = 0; i < arr.count; i++) {
        NSDictionary *dic = arr[i];
        
        MarketMessageMoneyModel *model = [MarketMessageMoneyModel new];
        model.money = [NSString stringWithFormat:@"%@",dic[@"money"]];
        model.count = [NSString stringWithFormat:@"%ld",[[MarketMessageManager shareInstance] messageCountWithMoney:dic[@"money"]]];
        
        [self.dataArray addObject:model];
    }
    
    _moneyView.dataArray = self.dataArray;
    
}

- (void)addOtherMoneyView{
    
    _otherMoneyView = [MarketMessageOtherMoneyView new];
    [self.scrollView addSubview:_otherMoneyView];
    
    [_otherMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.moneyView.mas_bottom);
        make.height.mas_equalTo(43);
    }];
    
    @weakify(self);
    [[[_otherMoneyView.textField rac_signalForControlEvents:UIControlEventEditingDidEnd] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        //输入了金额，就取消选中的cell
        [self.moneyView clearSelectedCell];
        //获取输入的值
        NSString *text = self.otherMoneyView.textField.text;
        self.payManager.money = text;
        self.payManager.smsCount = [NSString stringWithFormat:@"%ld",[[MarketMessageManager shareInstance] messageCountWithMoney:text]];
    }];
}


- (void)addPayWayView{
    
    MarketMessagePayWayModel *wechatPay = [MarketMessagePayWayModel new];
    wechatPay.logo = @"wechat_logo";
    wechatPay.title = @"微信支付";
    wechatPay.isSeleceted = YES;
    
    _payWayView = [MarketMessagePayWayView new];
    _payWayView.delegate = self;
    [self.scrollView addSubview:_payWayView];
    
    [_payWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.otherMoneyView.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(43);
    }];
    
    _payWayView.dataArray = @[wechatPay,];
}

- (void)initSaveBtn{
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"立即支付" textColor:LZWhiteColor];
//    btn.frame = CGRectMake(25, 0, kScreenWidth-50, 45);
    [self.scrollView addSubview:btn];
    
    [btn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payWayView.mas_bottom).offset(30);
        make.left.mas_equalTo(25);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(45);
        make.bottom.mas_equalTo(-50);
    }];
    
    [btn setDefaultGradientWithCornerRadius:6];
    
    NSString *infoStr = [NSString stringWithFormat:@"*短信充值规则：1元=%ld条",[[MarketMessageManager shareInstance] messageCountWithMoney:@"1"]];
    
    UILabel *label_tips = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:infoStr textColor:rgb(152,152,152)];
    label_tips.textAlignment = NSTextAlignmentCenter;
    [self.scrollView addSubview:label_tips];
    
    [label_tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(btn.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

- (void)save{
    
    if (_payManager.money.integerValue == 0) {
        [self showMessage:@"请选择或输入充值金额！"];
        return;
    }
    
    
    [_payManager requestOrder];
    
    
}

#pragma mark - MarketMessageMoneyViewDelegate
//金额条数
- (void)lz_view:(MarketMessageMoneyView *)selectView atIndex:(NSInteger)index model:(MarketMessageMoneyModel *)model{
    //选择了金额 就 清除输入的金额。
    _otherMoneyView.textField.text = @"";
    _otherMoneyView.label_info.text = @"";
    
    _payManager.money = model.money;
    _payManager.smsCount = model.count;
}

//不选
- (void)lz_moneyViewClearChoice:(MarketMessageMoneyView *)selectView{
    
    _payManager.money = @"0";
    _payManager.smsCount = @"0";
}

#pragma mark - MarketMessagePayWayViewDelegate
//支付方式
- (void)lz_messagePayWaySelectedAtIndex:(NSInteger)index model:(MarketMessagePayWayModel *)model{
    
}

@end
