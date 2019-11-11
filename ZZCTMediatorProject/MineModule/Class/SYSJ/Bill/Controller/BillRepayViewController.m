//
//  BillRepayViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "BillRepayViewController.h"
#import "BillRepayModel.h"
#import "BillRepayCell.h"
#import "NinaPagerSonDelegate.h"

@interface BillRepayViewController ()<NinaPagerSonDelegate>
@property (nonatomic, strong) NSString *monthDate;
@property (nonatomic, strong) NSString *yearDate;
@end

@implementation BillRepayViewController

- (BOOL)hiddenNavgationBar {
    return YES;
}

- (BOOL)hasHiddenTabBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.tableView];
  
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 164;
    
    self.tableView.height -= 40;
    self.tableView.separatorColor = UIColorHex(0xE9E9E9);
    [self.tableView registerNib:[UINib nibWithNibName:@"BillRepayCell" bundle:nil] forCellReuseIdentifier:@"BillRepayCell"];
    
    NSDate *date = [NSDate date];
    
    _monthDate = [NSString stringWithFormat:@"%lu",(unsigned long)date.month];
    _yearDate = [NSString stringWithFormat:@"%lu",(unsigned long)date.year];
    
    [self requestWithYear:_yearDate month:_monthDate];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)requestWithYear:(NSString *)year month:(NSString *)month{
    
    _monthDate = month;
    _yearDate = year;
    
    [self requestData];
}

- (void)requestData{
    NewParams;
    [params setSafeObject:_monthDate forKey:@"month"];
    [params setSafeObject:_yearDate forKey:@"year"];
//    [RequestTools getWithUrlString:URL_ZZF(@"getTxnJnlVos") parameters:params success:^(NSDictionary *responseDic) {
//        RequestInfoResolve3
//        if (isSuccess) {
//            self.dataArray = [BillRepayModel mj_objectArrayWithKeyValuesArray:responseDic[@"data"]];
//            [self.tableView reloadData];
//        }else{
//            [SVProgressHUD showImage:nil status:resMsg];
//        }
//        
//    } failure:^(NSError *error) {
//        
//    }];
}

#pragma mark - tableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BillRepayModel *model = self.dataArray[indexPath.row];
    
    BillRepayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BillRepayCell"];
    
    cell.money.text = [NSString formatFloatString:model.txnAmt];
    cell.sxf.text = [NSString formatFloatString:model.feeAmt];
    cell.channel.text = model.channelName;
    cell.ordId.text = model.tranId;
    cell.cardNumber.text = model.txnCardNo;
    cell.jsCardNumber.text = model.clrCardNo;
    cell.time.text = model.showTime;
    
    if ([model.tranSts isEqualToString:@"2"]) {
        cell.errorText.text = @"";
        cell.status.backgroundColor = [UIColor colorWithRed:99/255.0 green:197/255.0 blue:72/255.0 alpha:1];
        cell.status.text = @"成功";
    }else if ([model.tranSts isEqualToString:@"1"]) {
        if (model.isToday) {
            cell.errorText.text = @"";
            cell.status.backgroundColor = [UIColor grayColor];
            cell.status.text = @"执行中";
        }else{
            cell.errorText.text = @"订单超时";
            cell.status.backgroundColor = [UIColor colorWithRed:226/255.0 green:68/255.0 blue:46/255.0 alpha:1];
            
            cell.status.text = @"失败";
        }
    }else if ([model.tranSts isEqualToString:@"3"]) {
        cell.errorText.text = model.retMsg;
        cell.status.backgroundColor = [UIColor colorWithRed:226/255.0 green:68/255.0 blue:46/255.0 alpha:1];
        cell.status.text = @"失败";
    }else{//4、5、6
        cell.errorText.text = @"";
        cell.status.backgroundColor = [UIColor grayColor];
        cell.status.text = @"执行中";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
};
@end
