//
//  DataCollectionViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataCollectionViewController.h"
#import "DataCollectionNavBar.h"
#import "DataTypeChoiceButton.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "DataCollectionAllView.h"
#import "DataCollectionOrderDetailView.h"
#import "DataCollectionLineChatView.h"
#import "ListChoiceView.h"
#import "OperatorManModel.h"
#import "CTMediator+ModuleMineActions.h"
#import "DataManagerViewModel.h"
#import "DataManagerModel.h"

typedef NS_ENUM(NSUInteger, ChoiceType) {
    ChoiceTypeMan = 0,
    ChoiceTypeDate = 1,
    ChoiceTypeDeal = 2,
};

@interface DataCollectionViewController ()<ListChoiceViewDelegate>

@property (nonatomic, strong) DataCollectionNavBar *navBar;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) DataCollectionAllView *dataAllView;
@property (nonatomic, strong) DataCollectionOrderDetailView *dataDetailView;
@property (nonatomic, strong) DataCollectionLineChatView *chartView;
@property (nonatomic, strong) ListChoiceView *choiceView;
@property (nonatomic, strong) NSArray *manArray;
@property (nonatomic, assign) ChoiceType choiceType;

@property (nonatomic, strong) DataTypeChoiceButton *btn_Date;
@property (nonatomic, strong) DataTypeChoiceButton *btn_Deal;

@property (nonatomic, strong) DataManagerViewModel *viewModel;
@end

@implementation DataCollectionViewController

- (DataManagerViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [DataManagerViewModel new];
        _viewModel.day = @"6";
        _viewModel.dataType = DataTypeDealMoney;
    }
    return _viewModel;
}

- (BOOL)hiddenNavgationBar{
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [_dataDetailView refreshChatAnimation];
    [_chartView refreshDataWithDataArray:self.dataArray];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _navBar = [DataCollectionNavBar new];
    [self.view addSubview:_navBar];
    
    [_navBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.top.mas_equalTo(self.view);
        make.height.mas_equalTo(LZApp.shareInstance.app_navigationBarHeight);
    }];
    
    [_navBar setDefaultGradient];
    
    if (![AppCenter powerCheck]) {//收银员不显示
        @weakify(self);
        _navBar.rightBtnBlock = ^(UIButton * _Nonnull btn) {
            @strongify(self);
            [self showPersonChoice];
        };

    }else{
        _navBar.rightBtn.hidden = YES;
        self.viewModel.merchantNo = CurrentUser.usrNo;
    }
    
    
    [self addTopBtnView];
    
    self.scrollView.backgroundColor = LZWhiteColor;
    [self.view addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topView.mas_bottom);
        make.height
        .mas_equalTo(kScreenHeight-LZApp.shareInstance.app_navigationBarHeight-44);
    }];
    
    [self initChartView];
    [self initDataAllView];
    [self initDataDetailView];
    
    _dataAllView.canEndMoney = @"0.00";
    
    [self requestData];
}

- (void)requestData{
    
    @weakify(self);
    [self.viewModel getLineDataAddAllDataWithBlock:^(NSArray<DataManagerModel *> * _Nonnull dataArray) {
        @strongify(self);
        
        [self refreshLineData];
        
        self.dataAllView.label_date.text = [NSString stringWithFormat:@"%@ --  %@",dataArray.firstObject.monthDay,dataArray.lastObject.monthDay];
        
        NSString *sumSuccessCount = self.viewModel.sumDictionary[@"sumSuccessCount"];
        NSString *sumSuccessAmt = self.viewModel.sumDictionary[@"sumSuccessAmt"];
        
        NSString *sumDropCount = self.viewModel.sumDictionary[@"sumDropCount"];
        NSString *sumDropAmt = self.viewModel.sumDictionary[@"sumDropAmt"];
        
        NSString *sumAllFee = self.viewModel.sumDictionary[@"sumAllFee"];//fee
        
        self.dataAllView.label_orderCount.text = [NSString stringWithFormat:@"%@ 笔",sumSuccessCount];
        self.dataAllView.label_orderMoney.text = [NSString stringWithFormat:@"%@ 元",[NSString formatFloatString:sumSuccessAmt]];
        
        self.dataAllView.label_refundCount.text = [NSString stringWithFormat:@"%@ 笔",sumDropCount];
        self.dataAllView.label_refundMoney.text = [NSString stringWithFormat:@"%@ 元",[NSString formatFloatString:sumDropAmt]];
        
        self.dataAllView.label_axtMoney.text = [NSString stringWithFormat:@"%@ 元",[NSString formatFloatString:sumAllFee]];
        
        self.dataAllView.canEndMoney = [NSString formatFloatString:@(sumSuccessAmt.floatValue+sumAllFee.floatValue+sumDropAmt.floatValue).stringValue];
        
        NSString *alipay_count = self.viewModel.payWay_alipayDictionary[@"allCount"];
        NSString *alipay_amt = self.viewModel.payWay_alipayDictionary[@"allSumAmt"];
        
        NSString *wechat_count = self.viewModel.payWay_wechatDictionary[@"allCount"];
        NSString *wechat_amt = self.viewModel.payWay_wechatDictionary[@"allSumAmt"];
        
        if(IsNull(alipay_count)) alipay_count = @"0";
        if(IsNull(wechat_count)) wechat_count = @"0";
        
        self.dataDetailView.label_alipay.text = [NSString stringWithFormat:@"金额：%@ 元   笔数：%@ 笔",[NSString formatFloatString:alipay_amt],alipay_count];
        self.dataDetailView.label_wechat.text = [NSString stringWithFormat:@"金额：%@ 元   笔数：%@ 笔",[NSString formatFloatString:wechat_amt],wechat_count];
        
        CGFloat alipayProgress = alipay_amt.floatValue/(alipay_amt.floatValue+wechat_amt.floatValue);
        
        if (alipay_amt.floatValue == 0 && wechat_amt.floatValue == 0) {
            alipayProgress = 0.5;
        }
        
        [self.dataDetailView refreshAlipayProgress:alipayProgress];
    }];
    
   
}


- (void)refreshLineData{
    
    [self.dataArray removeAllObjects];
    for (int i = 0; i < self.viewModel.dataArray.count; i++) {
        DataManagerModel *model = self.viewModel.dataArray[i];
        DataLineCellModel *lineModel = [DataLineCellModel new];
        
        lineModel.title = model.monthDay;
        lineModel.dateYMD = model.yearMonthDay;
        lineModel.dateMD = model.monthDay;
        lineModel.dateDay = model.day;
        
        if (self.viewModel.dataType == DataTypeDealMoney) {
            lineModel.dataType = LineChatDataTypeMoney;
            lineModel.vaule = model.successAmt;//净收金额
        }else {
            lineModel.dataType = LineChatDataTypeCount;
            lineModel.vaule = model.successCount;//交易笔数
        }
        
        [self.dataArray addObject:lineModel];
    }
    
    [self.chartView refreshDataWithDataArray:self.dataArray];
}

- (void)addTopBtnView{
    
    SDBaseView *view_btn = [SDBaseView new];
    _topView = view_btn;
    view_btn.backgroundColor = LZWhiteColor;
    [self.view addSubview:view_btn];
    
    [view_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.navBar);
        make.top.mas_equalTo(self.navBar.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    [view_btn addBottomLine];
    
    DataTypeChoiceButton *btn_left = (DataTypeChoiceButton *)[DataTypeChoiceButton buttonWithFontSize:16 text:@"净收金额" textColor:rgb(101,101,101)];
    _btn_Deal = btn_left;
    
    DataTypeChoiceButton *btn_right = (DataTypeChoiceButton *)[DataTypeChoiceButton buttonWithFontSize:16 text:@"近七日" textColor:rgb(101,101,101)];
    _btn_Date = btn_right;
    
    [btn_left setImage:UIImageName(@"xiala") forState:UIControlStateNormal];
    [btn_right setImage:UIImageName(@"xiala") forState:UIControlStateNormal];
    
    [view_btn addSubview:btn_left];
    [view_btn addSubview:btn_right];
    
    [btn_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(view_btn);
    }];
    
    [btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(view_btn);
        make.left.mas_equalTo(btn_left.mas_right);
        make.width.mas_equalTo(btn_left);
    }];
    
    [btn_left addTarget:self action:@selector(topBtn_leftClick) forControlEvents:UIControlEventTouchUpInside];
    [btn_right addTarget:self action:@selector(topBtn_rightClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)showPersonChoice{
    self.choiceView.frame = CGRectMake(0, _navBar.bottom, kScreenWidth, kScreenHeight-_navBar.bottom);
    
    if (_manArray.count) {
        [self showPersonChoiceView];
    }else{
        [[CTMediator sharedInstance] CTMediator_getOperatorMansWithBlock:^(NSArray *datas) {
            self.manArray = datas;
            [self showPersonChoiceView];
        }];
    }
}

- (void)showPersonChoiceView{
    
    _choiceType = ChoiceTypeMan;
    NSMutableArray *arr = [NSMutableArray array];
    for (OperatorManModel *model in _manArray) {
        [arr addObject:model.name];
    }
    [arr insertObject:@"全部收银员" atIndex:0];
    [self.choiceView refreshDataWithArray:arr];
    [self.choiceView showWithSuperView:self.view];
}

- (void)topBtn_leftClick{
    
    _choiceType = ChoiceTypeDeal;
    self.choiceView.frame = CGRectMake(0, _topView.bottom, kScreenWidth, kScreenHeight-_topView.bottom);
    
    [self.choiceView refreshDataWithArray:@[@"净收金额",@"交易笔数"]];
    [self.choiceView showWithSuperView:self.view];
    
}

- (void)topBtn_rightClick{
    
    _choiceType = ChoiceTypeDate;
    self.choiceView.frame = CGRectMake(0, _topView.bottom, kScreenWidth, kScreenHeight-_topView.bottom);
    
    [self.choiceView refreshDataWithArray:@[@"近七日",@"近三十日",]];
    [self.choiceView showWithSuperView:self.view];
}

- (void)initChartView{
    _chartView = [DataCollectionLineChatView new];
    [self.scrollView addSubview:_chartView];
    [_chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.scrollView);
        make.height.mas_equalTo(218);
    }];
}

- (void)initDataAllView{
    _dataAllView = [DataCollectionAllView new];
    [self.scrollView addSubview:_dataAllView];
    [_dataAllView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.chartView.mas_bottom).offset(48);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(185);
        make.width.mas_equalTo(kScreenWidth-40);
    }];
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"tj_shujuhuizong")];
    [self.scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.dataAllView.mas_top).offset(-5);
        make.left.mas_equalTo(self.dataAllView);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    UILabel *label_date = [UILabel labelWithFontSize:16 text:@"数据汇总" textColor:rgb(53,53,53)];
    [self.scrollView addSubview:label_date];
    [label_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(imageView);
    }];
    
}

- (void)initDataDetailView{
    _dataDetailView = [DataCollectionOrderDetailView new];
    [self.scrollView addSubview:_dataDetailView];
    [_dataDetailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.dataAllView.mas_bottom).offset(48);
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(150);
        make.bottom.mas_equalTo(-50);
    }];
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"tj_dingdanmingxi")];
    [self.scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.dataDetailView.mas_top).offset(-5);
        make.left.mas_equalTo(self.dataDetailView);
        make.size.mas_equalTo(CGSizeMake(16, 16));
    }];
    
    UILabel *label_date = [UILabel labelWithFontSize:16 text:@"订单明细" textColor:rgb(53,53,53)];
    [self.scrollView addSubview:label_date];
    [label_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.centerY.mas_equalTo(imageView);
    }];
    
}

#pragma mark - ListChoiceViewDelegate
- (void)lz_listClickAtIndex:(NSInteger)index title:(NSString *)title{
    
    if (_choiceType == ChoiceTypeMan) {
        self.navBar.rightTitle = title;
        
        if (index == 0) {
            self.viewModel.merchantNo = nil;
            [self requestData];
            return;
        }
        
        OperatorManModel *model = _manArray[index-1];
        self.viewModel.merchantNo = model.userId;
        [self requestData];
        
    }else if (_choiceType == ChoiceTypeDeal) {
        [_btn_Deal setTitle:title forState:UIControlStateNormal];
        if (index == 0) {
            if ([self.viewModel.dataType isEqualToString:DataTypeDealCount]) {
                self.viewModel.dataType = DataTypeDealMoney;
                [self refreshLineData];
            }
        }else if (index == 1) {
            if ([self.viewModel.dataType isEqualToString:DataTypeDealMoney]) {
                self.viewModel.dataType = DataTypeDealCount;
                [self refreshLineData];
            }
        }
    }else if (_choiceType == ChoiceTypeDate) {
        [_btn_Date setTitle:title forState:UIControlStateNormal];
        if (index == 0) {
            if ([self.viewModel.day isEqualToString:@"6"]) {
                return;
            }
            
            self.viewModel.day = @"6";

        }else if (index == 1) {
            if ([self.viewModel.day isEqualToString:@"29"]) {
                return;
            }
            
            self.viewModel.day = @"29";
        }
        
        [self requestData];
    }
}

- (ListChoiceView *)choiceView{
    if (!_choiceView) {
        _choiceView = [[ListChoiceView alloc] init];
        _choiceView.delegate = self;
    }
    return _choiceView;
}
@end
