//
//  MineOrderDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/25.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineOrderDetailViewController.h"
#import "MineOrderModel.h"
#import "MineOrderViewModel.h"
#import "MineOrderDetailAddressView.h"
#import "MineOrderDetailStatusView.h"
#import "MineOrderDetailInfoView.h"
#import "MineOrderDetailOrderView.h"
#import "MineAddressModel.h"

@interface MineOrderDetailViewController ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) MineOrderModel *model;
@property (nonatomic, strong) NSString *orderId;

@property (nonatomic, strong) MineOrderDetailStatusView *statusView;
@property (nonatomic, strong) MineOrderDetailAddressView *addressView;
@property (nonatomic, strong) MineOrderDetailInfoView *infoView;
@property (nonatomic, strong) MineOrderDetailOrderView *orderView;

@end

@implementation MineOrderDetailViewController

- (instancetype)initWithOrderId:(NSString *)OrderId{
    self = [super init];
    if (self) {
        _orderId = OrderId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    self.title = @"订单详情";
    
    [self.view addSubview:self.scrollView];
    
    MineOrderDetailStatusView *statuView = [MineOrderDetailStatusView new];
    [self.scrollView addSubview:statuView];
    [statuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(92);
    }];
    [statuView setDefaultGradient];
    
    MineOrderDetailAddressView *addressView = [MineOrderDetailAddressView new];
    [self.scrollView addSubview:addressView];
    [addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statuView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(85);
    }];
    
    MineOrderDetailInfoView *infoView = [MineOrderDetailInfoView new];
    [self.scrollView addSubview:infoView];
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(addressView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(192);
    }];
    
    MineOrderDetailOrderView *orderView = [MineOrderDetailOrderView new];
    [self.scrollView addSubview:orderView];
    [orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(infoView.mas_bottom).offset(10);
        make.left.right.mas_equalTo(0);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    
    [MineOrderViewModel getOrderDetailWithOrderId:self.orderId block:^(id  _Nullable obj) {
        self.model = obj;
        statuView.model = self.model;
        
        infoView.model = self.model;
        orderView.model = self.model;
    
        MineAddressModel *address = [MineAddressModel new];
        address.provName = self.model.provName;
        address.cityName = self.model.cityName;
        address.areaName = self.model.areaName;
        address.streetName = self.model.streetName;
        address.address = self.model.address;
        address.mobile = self.model.mobile;
        address.userName = self.model.userName;
        
        addressView.model = address;
    }];
}


@end
