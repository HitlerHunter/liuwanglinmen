//
//  OrderRefundViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "OrderRefundViewController.h"
#import "VipPersonDetailCellView.h"
#import "BookOrderDetailModel.h"

@interface OrderRefundViewController ()

@property (nonatomic, strong) VipPersonDetailCellView *cellView1;
@property (nonatomic, strong) BookOrderDetailModel *model;
@end

@implementation OrderRefundViewController

- (instancetype)initWithModel:(BookOrderDetailModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"退款";
    
    [self.view addSubview:self.scrollView];
    
    [self initCellView1];
    [self addRefundBtn];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"订单编号",@"订单金额",@"退款金额",];
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

- (void)addRefundBtn{
    UIButton *stopBtn = [UIButton buttonWithFontSize:16 text:@"确认退款" textColor:LZWhiteColor];
    [self.scrollView addSubview:stopBtn];
    
    [stopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(20);
    }];
    
    [stopBtn setDefaultGradientWithCornerRadius:6];
    
    [stopBtn addTarget:self action:@selector(showRefundOrder) forControlEvents:UIControlEventTouchUpInside];
}

- (NSMutableArray *)creatVauleArray1{
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addObject:_model.transNo];
    [vauleArray addObject:[NSString formatFloatString:_model.orderAmt]];
    [vauleArray addObject:[NSString formatFloatString:_model.orderAmt]];
    
    return vauleArray;
    
}
- (void)showRefundOrder{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"申请退款" message:@"是否申请退款！" preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"退款" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self refundOrder];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

- (void)refundOrder{
    
    NewParams;
    
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    [params setSafeObject:self.model.transNo forKey:@"transNo"];
    
    [params setSafeObject:@"hftx" forKey:@"channel"];
    [params setSafeObject:@"" forKey:@"refundReason"];
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/payment-biz/refund/orderRefund")
    .zz_isPostByURLSession(YES)
    .zz_setParamType(ZZNetWorkerParamTypeFormData)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
        
            [self lineBackWithId:LinearBackId_Order];
            [self showMessage:@"申请退款成功"];
        }else{
            [self showMessage:model_net.message];
        }
        
       
    });
    
}

@end
