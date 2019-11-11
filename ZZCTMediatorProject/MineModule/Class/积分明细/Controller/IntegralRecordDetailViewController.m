//
//  IntegralRecordDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "IntegralRecordDetailViewController.h"
#import "IntegralRecordModel.h"
#import "VipPersonDetailCellView.h"

@interface IntegralRecordDetailViewController ()

@property (nonatomic, strong) VipPersonDetailCellView *cellView1;
@property (nonatomic, strong) IntegralRecordModel *model;
@end

@implementation IntegralRecordDetailViewController

- (instancetype)initWithModel:(IntegralRecordModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"积分详情";
    
    [self.view addSubview:self.scrollView];
    
    [self initCellView1];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"订单编号",@"收款金额",@"获取积分",@"交易时间",@"支付方式",@"交易状态"];
    
    NSString *logType = [NSString stringWithFormat:@"%@",_model.logType];
    if ([logType isEqualToString:@"transaction"]) {
       
    }else{
        titleArray = @[@"订单编号",@"收款金额",@"获取积分",@"交易时间"];
    }
    
    NSArray *vauleArray = [self creatVauleArray1];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        model.titleTextColor = rgb(152,152,152);
        model.vauleTextColor = rgb(53,53,53);
        
//        if (i == titleArray.count-1) {
//            model.cellStyle = VipPersonDetailCellStyleVauleBottom;
//            model.textAlignment = NSTextAlignmentLeft;
//        }
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

- (NSMutableArray *)creatVauleArray1{
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addObject:_model.bodyId];
    [vauleArray addObject:[NSString formatFloatString:_model.orderAmt]];
    
    CGFloat jf = _model.operateData.floatValue*1;
    [vauleArray addObject:[NSString stringWithFormat:@"%.2lf",jf]];
    [vauleArray addObject:IsNull(_model.createTime)?@"":_model.createTime];
    
    
    NSString *logType = [NSString stringWithFormat:@"%@",_model.logType];
    if ([logType isEqualToString:@"transaction"]) {
        [vauleArray addObject:getPayWayNameWithCode(_model.payType)];
        [vauleArray addObject:getIntegralOrderStatusTitleWithStatu(_model.orderStatus)];
    }else{
        [vauleArray addObject:@""];
    }
    
    
    return vauleArray;
    
}

@end
