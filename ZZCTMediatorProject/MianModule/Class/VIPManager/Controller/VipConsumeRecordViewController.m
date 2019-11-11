//
//  VipConsumeRecordViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipConsumeRecordViewController.h"
#import "VipConsumeRecordTopView.h"
#import "MarketInvestRecordCell.h"
#import "VipPersonModel.h"
#import "VipConsumeRecordViewModel.h"
#import "VipConsumeRecordModel.h"

@interface VipConsumeRecordViewController ()

@property (nonatomic, strong) VipConsumeRecordTopView *topView;

@property (nonatomic, strong) VipPersonModel *model;
@property (nonatomic, strong) VipConsumeRecordViewModel *viewModel;
@end

@implementation VipConsumeRecordViewController

- (NSString *)backIconName{
    return @"back_white";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (instancetype)initWithModel:(VipPersonModel *)model{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消费记录";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 210-64+self.base_navigationbarHeight)];
    header.backgroundColor = LZWhiteColor;
    
    UIView *headerTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 177-64+self.base_navigationbarHeight)];
    [header addSubview:headerTop];
    [headerTop setDefaultGradient];
    
    self.topView = [VipConsumeRecordTopView new];
    [header addSubview:self.topView];
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(141);
        make.bottom.mas_equalTo(-5);
    }];
    
    self.tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = LZWhiteColor;
    self.tableView.tableHeaderView = header;
    self.tableView.rowHeight = 65;
    
    [self.tableView registerClass:[MarketInvestRecordCell class] forCellReuseIdentifier:@"MarketInvestRecordCell"];
    
    
    _topView.headImage.image = [AppCenter defaultAppAvatar];
    _topView.label_name.text = _model.nickName;
    _topView.label_phone.text = [NSString stringWithFormat:@"会员ID:%@",_model.userId];
    
    self.topView.label_money1.text = [NSString formatFloatString:_model.totalPay];
    self.topView.label_money2.text = _model.payTimes;
    
    _viewModel = [VipConsumeRecordViewModel new];
    _viewModel.userId = _model.userId;
    _viewModel.tableView = self.tableView;

    [self.viewModel refreshData];
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
    VipConsumeRecordModel *model = self.viewModel.dataArray[indexPath.row];
    
    MarketInvestRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketInvestRecordCell"];
    cell.backgroundColor = LZWhiteColor;
    
    cell.label_title.text = getPayWayNameWithCode(model.payTypeName);
    cell.label_info.text = model.createTime;
    cell.label_money.text = [NSString stringWithFormat:@"￥%@",[NSString formatFloatString:model.orderAmount]];
    
    if (indexPath.row == 0) {
        [cell isHiddenTopLine:YES];
    }else if (indexPath.row == self.dataArray.count-1){
        [cell isHiddenTopLine:NO];
    }else{
        [cell originalLine];
    }
    
    return cell;
}

#pragma mark - 导航栏透明
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
        //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
        //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];

    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor blackColor]};
}


@end
