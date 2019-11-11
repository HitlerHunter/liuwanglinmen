//
//  AuthenMerchantStatusController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantStatusController.h"
#import "AuthenMerchantOneViewController.h"
#import "AuthenMerchantInfoViewController.h"

@interface AuthenMerchantStatusController ()

@property (nonatomic, strong) LZUserMerchant *merchant;
@property (nonatomic, strong) UILabel *label_statu;
@end

@implementation AuthenMerchantStatusController

- (instancetype)initWithMerchant:(LZUserMerchant *)merchant{
    self = [super init];
    if (self) {
        self.merchant = merchant;
    }
    return self;
}

- (void)lz_popController{
    [self lineBackWithId:LinearBackId_AuthenLine];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _model.status_lz = ChangeSalesStatusSuccess;
    
    self.title = @"商户录入";
    self.view.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView new];
    [self.view addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.base_navigationbarHeight+70);
    }];
    
    UILabel *label_statu = [UILabel labelWithFontSize:16];
    label_statu.numberOfLines = 0;
    label_statu.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label_statu];
    _label_statu = label_statu;
    [label_statu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(imageView.mas_bottom).offset(30);
        make.height.mas_greaterThanOrEqualTo(16);
    }];

    AuthenMerchantStatus status = _merchant.pmsMerchantInfo.status_lz;
    if (status == AuthenMerchantStatusSuccess) {
        imageView.image = UIImageName(@"messageReview_Success_bg");
        label_statu.text = @"审核成功";
        
        UIButton *btn = [UIButton buttonWithFontSize:16 text:@"查看基本信息" textColor:LZWhiteColor];
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
            make.top.mas_equalTo(label_statu.mas_bottom).offset(70);
            make.height.mas_equalTo(44);
        }];
        [btn addTarget:self action:@selector(toInfoVC) forControlEvents:UIControlEventTouchUpInside];
        [btn setDefaultGradientWithCornerRadius:4];
    }else if (status == AuthenMerchantStatusNoSubmit || status == AuthenMerchantStatusReviewing) {//提交成功了
        imageView.image = UIImageName(@"icon");
        label_statu.text = @"认证资料提交成功！\n我们将于1-3个工作日内审核您的资料。";
        label_statu.textColor = rgb(152,152,152);
        label_statu.textAlignment = NSTextAlignmentCenter;
        
        UIButton *btn = [UIButton buttonWithFontSize:16 text:@"确定" textColor:LZWhiteColor];
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
            make.top.mas_equalTo(label_statu.mas_bottom).offset(70);
            make.height.mas_equalTo(44);
        }];
        if (self.merchant.pmsMerchantInfo.status_lz == AuthenMerchantStatusNoSubmit) {
           [btn addTarget:self action:@selector(lz_OK) forControlEvents:UIControlEventTouchUpInside];
        }else{
            [btn addTarget:self action:@selector(lz_popController) forControlEvents:UIControlEventTouchUpInside];
        }
        
        [btn setDefaultGradientWithCornerRadius:4];
        
    }else if (status == AuthenMerchantStatusRefund) {
        imageView.image = UIImageName(@"messageReview_NoPass_bg");
        label_statu.text = @"审核不通过";
        label_statu.textColor = rgb(252,97,104);
        
        [self creatRefundView];
    }

}

- (void)lz_OK{
    [[UserManager shareInstance] getUserInfo:^(BOOL isSuccess) {
        [AppCenter toTabBarController];
    }];
}

- (void)toRewardVC{
    //修改
    AuthenMerchantOneViewController *one = [[AuthenMerchantOneViewController alloc] initWithMerchant:self.merchant];
    PushIdController(one, LinearBackId_AuthenLine);
}

- (void)toInfoVC{
    //修改
    AuthenMerchantInfoViewController *one = [[AuthenMerchantInfoViewController alloc] initWithMerchant:self.merchant];
    PushIdController(one, LinearBackId_AuthenLine);
}

- (void)creatRefundView{
    
    UILabel *label_message = [UILabel labelWithFontSize:13 textColor:rgb(152,152,152)];
    label_message.numberOfLines = 0;
    [self.view addSubview:label_message];
    label_message.textAlignment = NSTextAlignmentCenter;
    
    [label_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.label_statu.mas_bottom).offset(44);
        make.height.mas_greaterThanOrEqualTo(16);
    }];
    
    label_message.text = IsNull(_merchant.pmsMerchantInfo.checkRemark)?@"":_merchant.pmsMerchantInfo.checkRemark;
    
    UIButton *btn_left = [UIButton buttonWithFontSize:13 text:@"返回" textColor:rgb(152,152,152)];
    [self.view addSubview:btn_left];
    
    [btn_left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(label_message.mas_centerX).offset(-5);
        make.top.mas_equalTo(label_message.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(135, 35));
    }];
    
    [btn_left addTarget:self action:@selector(lz_popController) forControlEvents:UIControlEventTouchUpInside];
    btn_left.lz_setView.lz_shadow(4, rgba(17, 47, 95, 0.36), CGSizeMake(0, 2), 1, 4);
    btn_left.backgroundColor = rgb(238,238,238);
    
    
    UIButton *btn_right = [UIButton buttonWithFontSize:13 text:@"重新编辑" textColor:LZWhiteColor];
    [self.view addSubview:btn_right];
    
    [btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_message.mas_centerX).offset(5);
        make.centerY.mas_equalTo(btn_left);
        make.size.mas_equalTo(CGSizeMake(135, 35));
    }];
    [btn_right addTarget:self action:@selector(toRewardVC) forControlEvents:UIControlEventTouchUpInside];
    btn_right.lz_setView.lz_shadow(4, rgba(17, 47, 95, 0.36), CGSizeMake(0, 2), 1, 4);
    btn_right.backgroundColor = rgb(80,140,238);
}


@end
