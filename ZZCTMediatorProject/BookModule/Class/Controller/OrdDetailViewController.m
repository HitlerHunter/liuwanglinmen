//
//  OrdDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "OrdDetailViewController.h"
#import "VipPersonDetailCellView.h"
#import "OrderRefundViewController.h"
#import "BookOrderDetailModel.h"

@interface OrdDetailViewController ()

@property (nonatomic, strong) VipPersonDetailCellView *cellView1;
@property (nonatomic, strong) BookOrderDetailModel *model;

@end

@implementation OrdDetailViewController

- (instancetype)initWithModel:(BookOrderDetailModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    [self.view addSubview:self.scrollView];
    
    if (_model.orderStatus == BookOrderStatusSuccess) {
        [self initCellView1];
        [self addRefundBtn];
    }else if (_model.orderStatus == BookOrderStatusWaitingPay || _model.orderStatus == BookOrderStatusFailure) {
        [self initCellView1];
        [self addBackBtn];
        
    }else if (_model.orderStatus == BookOrderStatusRefundSuccess
              || _model.orderStatus == BookOrderStatusRefundFailure
              || _model.orderStatus == BookOrderStatusWaitingRefund) {
        [self initCellView2];
        [self addBackBtn];
    }
    
}

- (void)initCellView1{
    NSArray *titleArray = @[@"订单编号",@"收款金额",@"手续费",@"可结算金额",@"交易时间",@"收银员",@"支付方式",@"交易状态",@"收款备注",@"付款备注"];
    NSArray *vauleArray = [self creatVauleArray1];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        model.titleTextColor = rgb(152,152,152);
        model.vauleTextColor = rgb(53,53,53);
        
        if (i == titleArray.count-1) {
            model.cellStyle = VipPersonDetailCellStyleVauleBottom;
            model.textAlignment = NSTextAlignmentLeft;
        }
        
        [arr1 addObject:model];
    }
    
    _cellView1 = [VipPersonDetailCellView new];
    _cellView1.dataArray = arr1;
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-100);
    }];
    
    _cellView1.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
}

- (void)initCellView2{
    
    NSArray *titleArray = @[@"订单编号",@"原订单号",@"退款金额",@"退款申请时间",@"退款状态",];
    if (_model.orderStatus == BookOrderStatusRefundSuccess) {
        titleArray = @[@"订单编号",@"原订单号",@"退款金额",@"退款申请时间",@"退款完成时间",@"退款状态",];
    }
    
    NSArray *vauleArray = [self creatVauleArray2];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        model.titleTextColor = rgb(152,152,152);
        model.vauleTextColor = rgb(53,53,53);
        [arr1 addObject:model];
    }
    
    _cellView1 = [VipPersonDetailCellView new];
    _cellView1.dataArray = arr1;
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-100);
    }];
    
    _cellView1.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
}

- (void)addBackBtn{
    UIButton *stopBtn = [UIButton buttonWithFontSize:16 text:@"确定" textColor:LZWhiteColor];
    [self.scrollView addSubview:stopBtn];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(20);
    }];
    
    [stopBtn setDefaultGradientWithCornerRadius:6];
    
    [stopBtn addTarget:self action:@selector(lz_popController) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRefundBtn{
    
    NSString *dateStr = _model.payDate;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];

    [dateFormatter setLocale:[NSLocale currentLocale]];
    
    NSString *dateStr2 = [dateFormatter stringFromDate:[NSDate date]];
    
    NSString *str1 = [dateStr substringToIndex:10];
    NSString *str2 = [dateStr2 substringToIndex:10];
    
    if (![str1 isEqualToString:str2]) {
        
        [self addBackBtn];
        return;
    }
    
    //退款
    UIButton *stopBtn = [UIButton buttonWithFontSize:16 text:@"退款" textColor:LZWhiteColor];
    [self.scrollView addSubview:stopBtn];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(20);
    }];
    
    [stopBtn setDefaultGradientWithCornerRadius:6];
    
    [stopBtn addTarget:self action:@selector(refundOrder) forControlEvents:UIControlEventTouchUpInside];
}

//退款
- (void)refundOrder{
    
    OrderRefundViewController *vc = [[OrderRefundViewController alloc] initWithModel:self.model];
    PushIdController(vc, LinearBackId_Order);
}

- (NSMutableArray *)creatVauleArray1{
 
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addSafeObject:_model.transNo];
    [vauleArray addSafeObject:[NSString formatFloatString:_model.orderAmt]];
    [vauleArray addSafeObject:[NSString formatFloatString:_model.fee]];
    
    //可结算金额 = 收款金额-手续费
    CGFloat kjs = _model.orderAmt.floatValue - _model.fee.floatValue;
    [vauleArray addSafeObject:[NSString formatFloatString:@(kjs).stringValue]];
    
    [vauleArray addSafeObject:_model.showDate];
    [vauleArray addSafeObject:_model.operatorName];
    
    if ([_model.payType isEqualToString:@"10"]) {
        [vauleArray addSafeObject:@"微信"];
    }else{
        [vauleArray addSafeObject:@"支付宝"];
    }
    [vauleArray addSafeObject:_model.statuStr];
    
    [vauleArray addSafeObject:IsNull(_model.merchRemark)?@"":_model.merchRemark];
    [vauleArray addSafeObject:IsNull(_model.remark)?@"":_model.remark];
    
    return vauleArray;
    
}

- (NSMutableArray *)creatVauleArray2{
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addSafeObject:_model.transNo];
    [vauleArray addSafeObject:_model.orgTransNo?_model.orgTransNo:@""];
    [vauleArray addSafeObject:[NSString formatFloatString:_model.orderAmt]];
    [vauleArray addSafeObject:_model.createDate];
    
    if (_model.orderStatus == BookOrderStatusRefundSuccess) {
        [vauleArray addSafeObject:_model.payDate];
    }
    
    [vauleArray addSafeObject:_model.statuStr];
    
    return vauleArray;
    
}
@end
