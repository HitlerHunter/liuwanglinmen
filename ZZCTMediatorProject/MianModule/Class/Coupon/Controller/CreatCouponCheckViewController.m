//
//  CreatCouponCheckViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CreatCouponCheckViewController.h"
#import "CouponDetailCellView.h"
#import "CouponModel.h"
#import "CouponViewModel.h"

@interface CreatCouponCheckViewController ()
@property (nonatomic, strong) CouponModel *model;
@property (nonatomic, strong) CouponDetailCellView *cellView1;

@end

@implementation CreatCouponCheckViewController

- (instancetype)initWithModel:(CouponModel *)model{
    self =[super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增优惠券";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.height -= 50;
    
    UILabel *lab = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"确认信息" textColor:rgb(101,101,101)];
    [self.scrollView addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(15);
    }];
    
    [self initCellView1];
    
    UIButton *submitBtn = [UIButton buttonWithFontSize:16 text:@"发布"];
    submitBtn.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 50);
    [self.view addSubview:submitBtn];
    [submitBtn setDefaultGradientWithCornerRadius:0];
    
    [submitBtn addTarget:self action:@selector(submitCreat) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"优惠券类型",@"优惠券名称",@"优惠券金额",@"有效期"
                            ,@"预发数量",@"领券方式",@"适用门店",@"优惠券领取",];
    NSMutableArray *vauleArray = [NSMutableArray array];
    [vauleArray addObject:getCouponTypeStrWithType(self.model.couponType)];
    [vauleArray addObject:self.model.couponName];
    [vauleArray addObject:getCouponMessageStyle2WithCoupon(self.model)];
    
    if (self.model.validDateType == 2) {//自定义时间
       [vauleArray addObject:[NSString stringWithFormat:@"%@\n%@",self.model.startDate,self.model.endDate]];
    }else{
        [vauleArray addObject:@"永久有效"];
    }
    
    [vauleArray addObject:getCouponCountMessageWithCoupon(self.model)];
    
    [vauleArray addObject:@"免费领取"];
    [vauleArray addObject:@"全店通用"];
    
    if (self.model.couponStatus.integerValue == 2) {
        [vauleArray addObject:@"已开启"];
    }else if (self.model.couponStatus.integerValue == 1) {
        [vauleArray addObject:@"未开启"];
    }

    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        CouponDetailCellModel *model = [CouponDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        
        [arr1 addObject:model];
    }
    
    _cellView1 = [CouponDetailCellView new];
    _cellView1.backgroundColor = LZWhiteColor;
    _cellView1.dataArray = arr1;
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(37);
        make.width.mas_equalTo(kScreenWidth-30);
    }];
    
    _cellView1.lz_setView.lz_shadow(0,rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
    UILabel *label_info = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"确认发布成功后，优惠券自动生成。用户可以从微信小程序等处领取使用。" textColor:rgb(152,152,152)];
    label_info.numberOfLines = 0;
    [self.scrollView addSubview:label_info];
    
    [label_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.mas_equalTo(self.cellView1);
        make.bottom.mas_equalTo(-50);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(5);
    }];
}

- (void)submitCreat{

    [CouponViewModel creatCouponWithCouponModel:self.model block:^(id  _Nullable obj, NSString * _Nullable msg, BOOL success) {
        if (success) {
            [SVProgressHUD showSuccessWithStatus:msg];
            [self lineBackWithId:LinearBackId_Order];
            [[NSNotificationCenter defaultCenter] postNotificationName:CouponSendRecordNeedRefreshNotificationName object:nil];
        }else{
            [SVProgressHUD showErrorWithStatus:msg];
        }
    }];
}

@end
