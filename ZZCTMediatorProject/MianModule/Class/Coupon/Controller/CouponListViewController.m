//
//  CouponListViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponListViewController.h"
#import "CreatCouponViewController.h"
#import "CouponListChoiceController.h"
#import "CouponDetailViewController.h"
#import "CouponCell.h"
#import "CouponListViewModel.h"
#import "CouponModel.h"

@interface CouponListViewController ()
@property (nonatomic, strong) LZNoDataView *noDataView;
@property (nonatomic, strong) CouponListViewModel *viewModel;
@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    
    self.tableView.height -= 120;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = LZBackgroundColor;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"CouponCell"];
    
    self.tableView.rowHeight = 120;
    
    _viewModel = [CouponListViewModel new];
    _viewModel.tableView = self.tableView;
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(120);
    }];
    
    UIButton *addBtn = [UIButton buttonWithFontSize:16 text:@"添加优惠券"];
    [bottomView addSubview:addBtn];
    [addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    [addBtn setDefaultGradientWithCornerRadius:6];
    
    UIButton *pfBtn = [UIButton buttonWithFontSize:16 text:@"会员派发" textColor:rgb(255,81,0)];
    [bottomView addSubview:pfBtn];
    [pfBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addBtn.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(44);
    }];
    //暂时隐藏 会员派发
    pfBtn.hidden = YES;
    pfBtn.lz_setView.lz_cornerRadius(6).lz_border(0.5, rgb(255,81,0));
    
    [addBtn addTarget:self action:@selector(toCreatCoupon) forControlEvents:UIControlEventTouchUpInside];
    [pfBtn addTarget:self action:@selector(toPF) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self);
    //删除券 刷新数据
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:CouponSendRecordNeedRefreshNotificationName object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.viewModel refreshData];
    }];
    
    [self.viewModel refreshData];
}

- (void)toCreatCoupon{
    CreatCouponViewController *vc = [CreatCouponViewController new];
    PushIdController(vc, LinearBackId_Order);
}

- (void)toPF{
    CouponListChoiceController *vc = [CouponListChoiceController new];
    PushIdController(vc, LinearBackId_AuthenLine);
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
    CouponModel *model = self.viewModel.dataArray[indexPath.row];
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCell"];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CouponModel *model = self.viewModel.dataArray[indexPath.row];
    CouponDetailViewController *detail = [[CouponDetailViewController alloc] initWithModel:model];
    PushController(detail);
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}


#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.offsetY = 50;
        _noDataView.image = UIImageName(@"coupon_couponEmpyt");
        _noDataView.message = @"暂无优惠券，赶紧去添加吧~";
    }
    return _noDataView;
}
@end
