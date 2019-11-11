//
//  CouponListChoiceController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponListChoiceController.h"
#import "CouponVipChoiceController.h"
#import "CouponCell.h"
#import "CouponListViewModel.h"
#import "CouponModel.h"

@interface CouponListChoiceController ()
@property (nonatomic, strong) LZNoDataView *noDataView;
@property (nonatomic, strong) CouponListViewModel *viewModel;
@property (nonatomic, strong) CouponModel *selectedModel;
@end

@implementation CouponListChoiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = LZBackgroundColor;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"CouponCell"];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"下一步" font:nil color:nil block:^{
        @strongify(self);
        if (self.selectedModel == nil) {
            [self showMessage:@"请选择优惠券！"];
            return ;
        }
        
        CouponVipChoiceController *vip = [[CouponVipChoiceController alloc] initWithModel:self.selectedModel];
        PushIdController(vip, LinearBackId_AuthenLine);
    }];
    
    self.tableView.rowHeight = 120;
    
    _viewModel = [CouponListViewModel new];
    _viewModel.couponStatus = @"2";
    _viewModel.tableView = self.tableView;
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
    cell.canSelected = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponModel *model = self.viewModel.dataArray[indexPath.row];
    self.selectedModel = model;
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
        _noDataView.offsetY = 30;
        _noDataView.image = UIImageName(@"coupon_couponEmpyt");
        _noDataView.message = @"暂无优惠券，赶紧去添加吧~";
    }
    return _noDataView;
}
@end
