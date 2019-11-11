//
//  CashRecordViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/26.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "CashRecordViewController.h"
#import "CashRecordCell.h"
#import "CashRecordModel.h"
#import "CashRecordViewModel.h"
#import "MineDelegateTypeView.h"
#import "CashRecordDetailController.h"

@interface CashRecordViewController ()
@property (nonatomic, strong) LZNoDataView *noDataView;
@property (nonatomic, strong) CashRecordViewModel *viewModel;
@property (nonatomic, strong) MineDelegateTypeView *typeView;
@end

@implementation CashRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.title = @"提现记录";
    
//    @weakify(self);
//    [self addRightItemWithImage:nil title:@"筛选" font:nil color:nil block:^{
//        @strongify(self);
//        [self.typeView setTitleArray:@[@"全部",@"提现中",@"提现成功",@"提现失败",]];
//        [self.typeView showAnimationWithSuperView:self.view];
//    }];
    
    
    self.tableView.rowHeight = 70;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CashRecordCell" bundle:nil] forCellReuseIdentifier:@"CashRecordCell"];
    
    self.viewModel.tableView = self.tableView;
    [self.viewModel refreshData];
}


#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CashRecordModel *model = self.viewModel.dataArray[indexPath.section];
    CashRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashRecordCell"];
    
    cell.moneyLabel.text = [NSString stringWithFormat:@"提现到%@(%@)",IsNull(model.bankName)?@"":model.bankName,[model.bankNo substringFromIndex:model.bankNo.length-4]];
    cell.dateLabel.text = model.showTime;
    
    NSInteger stauts = model.state;
    if (stauts == 1) {
        cell.statusLabel.textColor = rgb(53,53,53);
    }else if (stauts == 2) {
        cell.statusLabel.textColor = rgb(53,53,53);
    }else if (stauts == 0) {
        cell.statusLabel.textColor = rgb(255,81,0);
    }
    cell.statusLabel.text = [NSString formatMoneyCentToYuanString:model.applyAmt];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CashRecordModel *model = self.viewModel.dataArray[indexPath.section];
    CashRecordDetailController *detailVC = [[CashRecordDetailController alloc] initWithModel:model];
    
    PushController(detailVC);
};

- (CashRecordViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [CashRecordViewModel new];
    }
    return _viewModel;
}

- (MineDelegateTypeView *)typeView{
    if (!_typeView) {
        _typeView = [[MineDelegateTypeView alloc] initWithFrame:CGRectMake(0, self.tableView.top, kScreenWidth, self.contentHeight)];
        @weakify(self);
        _typeView.clickBlock = ^(NSInteger index) {
            @strongify(self);
                //点击
            if (index == 0) {
                self.viewModel.category = nil;
            }else if (index == 1) {
                self.viewModel.category = @"0";
            }else if (index == 2) {
                self.viewModel.category = @"2";
            }else if (index == 3) {
                self.viewModel.category = @"1";
            }
            [self.viewModel refreshData];
        };
    }
    return _typeView;
}

#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.image = UIImageName(@"vip_empty");
        _noDataView.message = @"暂无提现数据";
    }
    return _noDataView;
}
@end
