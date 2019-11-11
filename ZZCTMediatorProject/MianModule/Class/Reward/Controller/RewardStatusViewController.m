//
//  RewardStatusViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardStatusViewController.h"
#import "RewardViewModel.h"
#import "RewardRecordModel.h"
#import "ChangeSalesPromotionVC.h"

@interface RewardStatusViewController ()
@property (nonatomic, strong) RewardRecordModel *model;
@property (nonatomic, strong) UILabel *label_statu;
@end

@implementation RewardStatusViewController

- (instancetype)initWithModel:(RewardRecordModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    _model.status_lz = ChangeSalesStatusSuccess;
    
    self.title = @"悬赏";
    self.view.backgroundColor = LZWhiteColor;
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"悬赏记录" font:nil color:nil block:^{
        @strongify(self);
        [RewardViewModel pushToRewardRecordViewControllerWithNav:self.nav];
    }];
    
    
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

    if (_model.status_lz == ChangeSalesStatusSuccess) {
        imageView.image = UIImageName(@"messageReview_Success_bg");
        label_statu.text = [NSString stringWithFormat:@"悬赏审核成功\n当前悬赏费率为：%ld%%",_model.shareComp13.integerValue/100];
        
        UIButton *btn = [UIButton buttonWithFontSize:13 text:@"重新发起悬赏" textColor:rgb(152,152,152)];
        [btn setImage:UIImageName(@"reward_bianji") forState:UIControlStateNormal];
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
        [self.view addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.mas_equalTo(label_statu.mas_bottom).offset(70);
            make.height.mas_greaterThanOrEqualTo(20);
        }];
        [btn addTarget:self action:@selector(toRewardVC) forControlEvents:UIControlEventTouchUpInside];
    }else if (_model.status_lz == ChangeSalesStatusReviewing) {
        imageView.image = UIImageName(@"messageReview_reviewing_bg");
        label_statu.text = @"悬赏申请正在审核中\n请耐心等待...";
        label_statu.textColor = rgb(67,179,90);
    }else if (_model.status_lz == ChangeSalesStatusRefund) {
        imageView.image = UIImageName(@"messageReview_NoPass_bg");
        label_statu.text = @"悬赏审核不通过";
        label_statu.textColor = rgb(252,97,104);
        
        [self creatRefundView];
    }

}

- (void)toRewardVC{

    ChangeSalesPromotionVC *vc = [[ChangeSalesPromotionVC alloc] initWithNotHiddenNavgationBar:YES];
    [self.nav pushViewController:vc animated:YES];
    
}

- (void)creatRefundView{
    
    UILabel *label_message = [UILabel labelWithFontSize:13 textColor:rgb(152,152,152)];
    label_message.numberOfLines = 0;
    [self.view addSubview:label_message];
    
    [label_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.label_statu.mas_bottom).offset(44);
        make.height.mas_greaterThanOrEqualTo(16);
    }];
    
    label_message.text = IsNull(_model.checkRemark)?@"":_model.checkRemark;
    
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
    
    
    UIButton *btn_right = [UIButton buttonWithFontSize:13 text:@"重新发起悬赏" textColor:LZWhiteColor];
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
