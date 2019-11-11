//
//  CouponSendRecordController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponSendRecordController.h"
#import "MessageSendRecordCell.h"
#import "CouponSendRecordViewModel.h"
#import "CouponSendRecordModel.h"
#import "CouponModel.h"

@interface CouponSendRecordController ()
@property (nonatomic, strong) LZNoDataView *noDataView;
@property (nonatomic, strong) CouponModel *model;
@property (nonatomic, strong) CouponSendRecordViewModel *viewModel;
@end

@implementation CouponSendRecordController

- (instancetype)initWithModel:(CouponModel *)model{
    self =[super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发券记录";
    
    [self.view addSubview:self.tableView];
    
    self.tableView.rowHeight = 122;
    [self.tableView registerClass:[MessageSendRecordCell class] forCellReuseIdentifier:@"MessageSendRecordCell"];
    
    _viewModel = [CouponSendRecordViewModel new];
    _viewModel.couponId = self.model.Id;
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
    CouponSendRecordModel *model = self.viewModel.dataArray[indexPath.row];
    
    MessageSendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageSendRecordCell"];
    
    cell.couponSendRecordModel = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

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
        _noDataView.message = @"暂无数据";
    }
    return _noDataView;
}
@end
