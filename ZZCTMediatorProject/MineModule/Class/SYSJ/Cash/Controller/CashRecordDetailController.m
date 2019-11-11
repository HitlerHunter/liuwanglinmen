//
//  CashRecordDetailController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "CashRecordDetailController.h"
#import "CashRecordModel.h"
#import "CashTitleInfoCell.h"

@interface CashRecordDetailController ()

@property (nonatomic, strong) CashRecordModel *model;
@end

@implementation CashRecordDetailController

- (instancetype)initWithModel:(CashRecordModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"账单详情";
    
    NSString *moneyStr = [NSString stringWithFormat:@"¥%@",[NSString formatMoneyCentToYuanString:_model.applyAmt]];
    
    double ssf = _model.applyAmt.doubleValue - _model.arrivalAmt.doubleValue;
    NSString *ssfStr = [NSString formatMoneyCentToYuanString:@(ssf).stringValue];
    ssfStr = [NSString stringWithFormat:@"¥%@",ssfStr];
    
    self.scrollView.backgroundColor = LZWhiteColor;
    [self.view addSubview:self.scrollView];
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"jinbi")];
    [self.scrollView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(46, 46));
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
    }];
    
    NSString *bankStr = [NSString stringWithFormat:@"提现-到%@(%@)",_model.bankName,[_model.bankNo substringFromIndex:_model.bankNo.length-4]];
    //bank
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:bankStr textColor:rgb(53,53,53)];
    [self.scrollView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(imageView.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
    }];
    
    //money
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(21) text:moneyStr textColor:rgb(18,18,18)];
    [self.scrollView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label1.mas_bottom).offset(15);
        make.centerX.mas_equalTo(0);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = rgb(236,236,236);
    [self.view addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label2.mas_bottom).offset(40);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(kScreenWidth-30);
    }];
    
    /**
     * 交易状态  1提交成功  3失败 9成功
     */
    NSInteger stauts = _model.state;
    NSString *stautsName = @"";
    if (stauts == 0) {
        stautsName = @"提现中";
    }else if (stauts == 2) {
        stautsName = @"提现成功";
    }else if (stauts == 1) {
        stautsName = @"提现失败";
    }else{
        stautsName = @"";
    }
    
    CashTitleInfoCell *cell1 = [CashTitleInfoCell cellWithTitle:@"当前状态" vaule:stautsName];
    CashTitleInfoCell *cell2 = [CashTitleInfoCell cellWithTitle:@"提现金额" vaule:moneyStr];
    CashTitleInfoCell *cell3 = [CashTitleInfoCell cellWithTitle:@"手续费" vaule:ssfStr];
    CashTitleInfoCell *cell4 = [CashTitleInfoCell cellWithTitle:@"申请时间" vaule:_model.showTime];
    CashTitleInfoCell *cell5 = [CashTitleInfoCell cellWithTitle:@"失败原因" vaule:_model.explains];
    CashTitleInfoCell *cell7 = [CashTitleInfoCell cellWithTitle:@"提现单号" vaule:_model.tranId];
    
    NSArray *cellArray = @[cell1,cell2,cell3,cell4,cell7];
    
    if (stauts == 1) {
        cellArray = @[cell1,cell2,cell3,cell4,cell5,cell7];
    }else if (stauts == 0) {
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
        NSDate *date = [formatter dateFromString:_model.showTime];
        date = [date dateByAddingDays:3];
        NSString *timeStr = [formatter stringFromDate:date];
        
        CashTitleInfoCell *cell8 = [CashTitleInfoCell cellWithTitle:@"到账时间" vaule:timeStr];
        
        cellArray = @[cell1,cell2,cell3,cell4,cell8,cell7];
    }
    
    
    UIView *lastView = nil;
    for (UIView *cell in cellArray) {
        [self.scrollView addSubview:cell];
        
        if (!lastView) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(line2.mas_bottom).offset(5);
            }];
        }else {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(30);
                make.top.mas_equalTo(lastView.mas_bottom);
            }];
        }
        lastView = cell;
    }

    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
}



@end
