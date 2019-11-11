//
//  IntegralRecordViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "IntegralRecordViewController.h"
#import "IntegralRecordViewModel.h"
#import "IntegralRecordCell.h"
#import "IntegralRecordModel.h"
#import "IntegralRecordSectionHeader.h"
#import "HooDatePicker.h"
#import "IntegralRecordDetailViewController.h"

@interface IntegralRecordViewController ()<HooDatePickerDelegate>
@property (nonatomic, strong) IntegralRecordViewModel *viewModel;
@property (nonatomic, strong) LZNoDataView *noDataView;

@property (nonatomic, strong) HooDatePicker *YMDPicker;
@property (nonatomic, strong) NSDate *lastDate;

@end

@implementation IntegralRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    self.title = @"积分明细";
    
    self.tableView.rowHeight = 68;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[IntegralRecordCell class] forCellReuseIdentifier:@"IntegralRecordCell"];
    [self.tableView registerClass:[IntegralRecordSectionHeader class] forHeaderFooterViewReuseIdentifier:@"header"];
    
    self.viewModel.tableView = self.tableView;
    [self.viewModel refreshData];
//    _viewModel.yearMonth = [self configBeginDate];
}

- (NSString *)configBeginDate{
    NSDate *beginDate = [NSDate date];
    NSString *beginStr = [beginDate formatYMDWithSeparate:@"-"];
    beginStr = [beginStr substringToIndex:beginStr.length-3];
    return beginStr;
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.viewModel.dataArray[section] listOrders] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralRecordModel *model = [[self.viewModel.dataArray[indexPath.section] listOrders] objectAtIndex:indexPath.row];
    IntegralRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntegralRecordCell"];
    cell.iconView.image = UIImageName(@"jifen");
    
    CGFloat jf = model.operateData.floatValue*1;
    cell.label_money.text = [NSString stringWithFormat:@"%@",[NSString stringWithFormat:@"%.2lf",jf]];
    
    cell.label_status.text = model.category;
    
    NSString *timeStr = model.createTime;
    if (timeStr.length>=5) {
        timeStr = [timeStr substringFromIndex:5];
    }
    
    cell.label_info.text = timeStr;
    
    NSString *logType = [NSString stringWithFormat:@"%@",model.logType];
    if ([logType isEqualToString:@"transaction"]) {
        cell.label_type.text = @"收入";
    }else{
        cell.label_type.text = @"支出";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IntegralRecordModel *model = [[self.viewModel.dataArray[indexPath.section] listOrders] objectAtIndex:indexPath.row];
    IntegralRecordDetailViewController *detail = [[IntegralRecordDetailViewController alloc] initWithModel:model];
    PushController(detail);
};


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    IntegralRecordSectionModel *model = self.viewModel.dataArray[section];
    
    IntegralRecordSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    header.textLabel.font = kfont(14);
    
    @weakify(self);
    header.selectDateBlock = ^(NSString * _Nonnull lastDate) {
        @strongify(self);
        [self showDateSelect];
    };
    
    NSString *timeStr = model.createTime;
    if (timeStr.length>=5) {
        timeStr = [timeStr substringToIndex:7];
    }
    header.title = timeStr;

    return header;
}

#pragma mark - 选择时间
- (void)showDateSelect{
    
    [self.YMDPicker show];
}

#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    if ([_lastDate isEqualToDate:date]) {
        return;
    }
    
    NSString *dateStr = [date formatYMDWithSeparate:@"-"];
    dateStr = [dateStr substringToIndex:7];
    self.viewModel.yearMonth = dateStr;
    [self.viewModel refreshData];
    
    _lastDate = date;
}

- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initWithSuperView:KeyWindow];
        _YMDPicker.delegate = self;
        _YMDPicker.datePickerMode = HooDatePickerModeYearAndMonth;
        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
        _YMDPicker.maximumDate = [NSDate date];
    }
    return _YMDPicker;
}

/**
 
 NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%ld笔  ",model.orderCount]];
 [attStr addAttributes:@{NSFontAttributeName:kfont(14)} range:NSMakeRange(0, attStr.length)];
 
 NSMutableAttributedString *attStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2lf元",model.totalAmount]];
 [attStr2 addAttributes:@{NSFontAttributeName:kfont(14),NSForegroundColorAttributeName:UIColorHex(0xEF883A)} range:NSMakeRange(0, attStr2.length)];
 
 [attStr appendAttributedString:attStr2];
 
 header.detailTextLabel.attributedText = attStr;
 
 */

- (IntegralRecordViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [IntegralRecordViewModel new];
        _viewModel.tableView = self.tableView;
        _viewModel.type = @"all";
    }
    return _viewModel;
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
