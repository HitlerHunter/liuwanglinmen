//
//  MarketInvestRecordVC.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketInvestRecordVC.h"
#import "MarketInvestRecordCell.h"
#import "MarketMessageInvestViewController.h"
#import "MarketRechargeRecordViewModel.h"
#import "MarketRechargeRecordModel.h"

@interface MarketInvestRecordVC ()
@property (nonatomic, strong) LZNoDataView *noDataView;
@property (nonatomic, strong) MarketRechargeRecordViewModel *viewModel;
@end

@implementation MarketInvestRecordVC

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值记录";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 68)];
    
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = LZWhiteColor;
    [view addSubview:topView];
    
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
    
    [btn addTarget:self action:@selector(toInvest) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = view;
    self.tableView.rowHeight = 65;
    
    [self.tableView registerClass:[MarketInvestRecordCell class] forCellReuseIdentifier:@"MarketInvestRecordCell"];
    
    _viewModel = [MarketRechargeRecordViewModel new];
    _viewModel.tableView = self.tableView;
    
    [self.viewModel refreshData];
}

    //充值
- (void)toInvest{
    MarketMessageInvestViewController *vc = [MarketMessageInvestViewController new];
    PushController(vc);
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarketRechargeRecordModel *model = self.viewModel.dataArray[indexPath.row];
    MarketInvestRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketInvestRecordCell"];
    
    if (indexPath.row == 0) {
        [cell isHiddenTopLine:YES];
    }else if (indexPath.row == self.viewModel.dataArray.count-1){
        [cell isHiddenTopLine:NO];
    }else{
        [cell originalLine];
    }
    
    if ([model.channel isEqualToString:@"wx"]) {
        cell.label_title.text = @"微信充值";
    }
    cell.label_info.text = model.createDate;
    cell.label_money.text = [NSString stringWithFormat:@"￥%@",[NSString formatFloatString:model.orderAmt]];
    
    return cell;
}


#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.image = UIImageName(@"wujilu");
        _noDataView.message = @"暂无记录";
    }
    return _noDataView;
}

@end
