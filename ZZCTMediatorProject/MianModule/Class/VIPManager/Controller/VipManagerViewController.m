//
//  VipManagerViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "VipManagerViewController.h"
#import "VipManagerMenuView.h"
#import "VipPersonCell.h"
#import "VipPersonModel.h"
#import "VipPersonViewModel.h"
#import "VipPersonDetailViewController.h"

@interface VipManagerViewController ()<VipManagerMenuDelegate>

@property (nonatomic, strong) VipManagerMenuView *menuView;
@property (nonatomic, strong) VipPersonViewModel *viewModel;
@end

@implementation VipManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"会员管理";
    
    _menuView = [[VipManagerMenuView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, 35)];
    _menuView.delegate = self;
    
//    VipManagerMenuModel *menu1 = [VipManagerMenuModel initWithTitle:@"注册时间" status:VipManagerMenuStatusNoSelected];
    VipManagerMenuModel *menu2 = [VipManagerMenuModel initWithTitle:@"支付金额" status:VipManagerMenuStatusNoSelected];
    VipManagerMenuModel *menu3 = [VipManagerMenuModel initWithTitle:@"消费次数" status:VipManagerMenuStatusNoSelected];
    VipManagerMenuModel *menu4 = [VipManagerMenuModel initWithTitle:@"消费时间" status:VipManagerMenuStatusNoSelected];
    [_menuView initUIWithMenuModelArray:@[menu2,menu3,menu4]];
    
    [self.view addSubview:_menuView];
    
    [self.view addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, _menuView.bottom, kScreenWidth, self.contentHeight-35);
    self.tableView.rowHeight = 90;
    [self.tableView registerClass:[VipPersonCell class] forCellReuseIdentifier:@"VipPersonCell"];
    
    _viewModel = [VipPersonViewModel new];
    _viewModel.tableView = self.tableView;
    
    [_menuView setSelectedAtIndex:0];
}


#pragma mark - VipManagerMenuDelegate
- (void)VipManagerMenuDidSelectedWithTitle:(NSString *)title status:(VipManagerMenuStatus)status{
    
    NSString *str = @"";
    if ([title isEqualToString:@"支付金额"]) {
        str = @"consumer_amt";
    }else if ([title isEqualToString:@"消费次数"]) {
        str = @"consumer_times";
    }else if ([title isEqualToString:@"消费时间"]) {
        str = @"last_txn_time";
    }
    
    
    if (status == VipManagerMenuStatusUp) {
        _viewModel.isAsc = str;
        _viewModel.isDesc = nil;
    }else if (status == VipManagerMenuStatusDown) {
        _viewModel.isDesc = str;
        _viewModel.isAsc = nil;
    }else if (status == VipManagerMenuStatusNoSelected) {
        
    }
    
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
    VipPersonModel *model = self.viewModel.dataArray[indexPath.row];
    VipPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"VipPersonCell"];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VipPersonModel *model = self.viewModel.dataArray[indexPath.row];
    VipPersonDetailViewController *detail = [[VipPersonDetailViewController alloc] initWithUserId:model.txnUsrNo];
    PushController(detail);
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}
@end
