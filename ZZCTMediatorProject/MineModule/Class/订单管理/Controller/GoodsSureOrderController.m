//
//  GoodsSureOrderController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "GoodsSureOrderController.h"
#import "SureOrderAddressView.h"
#import "SureOrderInfoView.h"
#import "MineAddressViewController.h"
#import "MineAddressModel.h"
#import "OrderPayWayView.h"
#import "SureOrderToolView.h"
#import "GoodsModel.h"
#import "IPAddressHelper.h"
#import "CTMediator+ModuleMineActions.h"
#import "MineAddressViewModel.h"

@interface GoodsSureOrderController ()

@property (nonatomic, strong) SureOrderAddressView *addressView;
@property (nonatomic, strong) SureOrderInfoView *infoView;
@property (nonatomic, strong) OrderPayWayView *payWayView;
@property (nonatomic, strong) SureOrderToolView *toolView;
@property (nonatomic, strong) GoodsModel *model;
@property (nonatomic, strong) MineAddressModel *address;

@property (nonatomic, strong) NSString *orderAmt;
@end

@implementation GoodsSureOrderController

- (instancetype)initWithGoodsModel:(GoodsModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"确认订单";
    [self.view addSubview:self.scrollView];
    
    _addressView = [SureOrderAddressView new];
    [self.scrollView addSubview:_addressView];
    [_addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-16);
        make.width.mas_equalTo(kScreenWidth-32);
        make.height.mas_greaterThanOrEqualTo(50);
    }];
    _addressView.lz_setView.lz_cornerRadius(6);
    
    _infoView = [SureOrderInfoView new];
    [self.scrollView addSubview:_infoView];
    [_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressView.mas_bottom).offset(10);
        make.right.left.mas_equalTo(self.addressView);
        make.height.mas_equalTo(211);
    }];
    _infoView.lz_setView.lz_cornerRadius(6);
    
    UITapGestureRecognizer *addressTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectAddress)];
    [_addressView addGestureRecognizer:addressTap];
    
    _payWayView = [OrderPayWayView new];
    [self.scrollView addSubview:_payWayView];
    [_payWayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.infoView.mas_bottom).offset(10);
        make.right.left.mas_equalTo(self.addressView);
        make.height.mas_greaterThanOrEqualTo(50);
        make.bottom.mas_equalTo(-56);
    }];
    _payWayView.lz_setView.lz_cornerRadius(6);
    
    _toolView = [[SureOrderToolView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    [self.view addSubview:_toolView];
    [_toolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(0);
        make.height.mas_equalTo(56);
    }];
    
    @weakify(self);
    [RACObserve(self.infoView, count) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        CGFloat money = self.model.orderAmt.doubleValue * self.infoView.count;
        self.toolView.money = [NSString formatFloatValue:money];
        self.model.goodsCount = [NSString stringWithFormat:@"%@",x];
        self.orderAmt = [NSString formatFloatValue:money];
        self.toolView.count = self.infoView.count;
    }];
    
    _infoView.model = self.model;
    self.infoView.count = 1;
    
    _toolView.submitBlock = ^{
        @strongify(self);
        [self submitOrder];
    };
    
    [self getDefaultAddress];
    
    //支付回调处理
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WXPayFinishedHotGoodsNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        AppPayStatus status = [x.object integerValue];
        if (status == AppPayStatusSuccess) {
            UIViewController *vc = [[CTMediator sharedInstance] CTMediator_OrderManagerController];
            
            NSMutableArray *vcs = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            NSMutableArray *vcs2 = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            if (vcs.count>2) {
                [vcs removeLastObject];
                [vcs removeLastObject];
            }

            [vcs addObject:vc];
            [vcs2 addObject:vc];
            [self.navigationController setViewControllers:vcs2 animated:YES];
            [self.navigationController setViewControllers:vcs animated:NO];
        }else if (status == AppPayStatusFailue) {
            [self showMessage:@"支付失败"];
        }else if (status == AppPayStatusCancel) {
            [self showMessage:@"支付取消"];
        }
    }];
}

- (void)getDefaultAddress{
    [MineAddressViewModel getDefaultAddressWithBlock:^(id  _Nullable obj) {
        if (obj) {
            self.addressView.model = obj;
            self.address = obj;
        }
    }];
}

- (void)selectAddress{
    MineAddressViewController *addressVc = [[MineAddressViewController alloc] init];
    @weakify(self);
    addressVc.didSelectBlock = ^(MineAddressModel * _Nonnull address) {
        @strongify(self);
        self.addressView.model = address;
        self.address = address;
    };
    PushController(addressVc);
}

- (void)submitOrder{
    if (!_address) {
        [self showMessage:@"请选择收货地址!"];
        return;
    }
    
    NewParams;
    [params setSafeObject:_address.Id forKey:@"addressId"];
    [params setSafeObject:_model.goodsCode forKey:@"goodsCode"];
    [params setSafeObject:_model.goodsCount forKey:@"goodsCount"];
    [params setSafeObject:_model.goodsName forKey:@"goodsName"];
    [params setSafeObject:_model.goodsPrice forKey:@"goodsPrice"];
    [params setSafeObject:_model.goodsSpecs forKey:@"goodsSpecs"];
    [params setSafeObject:_model.goodsType forKey:@"goodsType"];
    [params setSafeObject:self.orderAmt forKey:@"orderAmt"];
    [params setSafeObject:_model.logo forKey:@"picture"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"userNo"];
    [params setSafeObject:[IPAddressHelper getNetworkIPAddress] forKey:@"spbillCreateIp"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/outside-biz/expressInfo/shoppingPay")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            [AppPayManager shareInstance].currentPayType = AppPayTypeBoomGoodsPay;
            [[AppPayManager shareInstance] WXPayWithDic:model_net.data];
        }
    });
}

@end
