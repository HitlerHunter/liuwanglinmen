//
//  MerchantManagerViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MerchantManagerViewController.h"
#import "MerchantManagerTopView.h"
#import "MerchantManagerCell.h"
#import "MerchantManagerViewModel.h"
#import "MerchantManagerModel.h"
#import "AuthenMerchantInfoViewController.h"

@interface MerchantManagerViewController ()

@property (nonatomic, strong) MerchantManagerTopView *topView;
@property (nonatomic, strong) MerchantManagerViewModel *viewModel;
@end

@implementation MerchantManagerViewController

- (NSString *)backIconName{
    return @"back_white";
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户管理";
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    
    _topView = [[MerchantManagerTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.base_navigationbarHeight+162)];
    self.tableView.height = kScreenHeight-_topView.height;
    
    [self.view addSubview:_topView];
    [self.view addSubview:self.tableView];
    self.tableView.top = _topView.bottom;
    self.tableView.rowHeight = 70;
    [self.tableView registerClass:[MerchantManagerCell class] forCellReuseIdentifier:@"MerchantManagerCell"];
    
    _viewModel = [MerchantManagerViewModel new];
    _viewModel.tableView = self.tableView;
    
    [_viewModel refreshData];
    
    @weakify(self);
    [RACObserve(self.viewModel, addMerchantNum) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.topView.cardView.lab_today.text = x;
    }];
    [RACObserve(self.viewModel, merchantNum) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.topView.cardView.lab_all.text = x;
    }];
    
    [RACObserve(self.viewModel, acStatus) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.topView.cardView.lab_center.text = x;
    }];
    [RACObserve(self.viewModel, reStatus) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.topView.cardView.lab_left.text = x;
    }];
    [RACObserve(self.viewModel, unStatus) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.topView.cardView.lab_right.text = x;
    }];
    
    [_viewModel getTodayNewdataInfo];
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
    MerchantManagerModel *model = self.viewModel.dataArray[indexPath.row];
    MerchantManagerCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MerchantManagerCell"];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MerchantManagerModel *merchant = self.viewModel.dataArray[indexPath.row];
    //成功状态 查看info
    AuthenMerchantInfoViewController *info = [[AuthenMerchantInfoViewController alloc] initWithMerchant:merchant];
    [self.navigationController pushViewController:info animated:YES linearBackId:LinearBackId_AuthenLine];
};

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
