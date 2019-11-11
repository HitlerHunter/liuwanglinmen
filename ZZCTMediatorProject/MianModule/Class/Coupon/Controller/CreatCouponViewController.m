//
//  CreatCouponViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CreatCouponViewController.h"
#import "CouponDateSettingViewController.h"
#import "CreatCouponCheckViewController.h"
#import "CouponSelectTextCell.h"
#import "CouponInputTextCell.h"
#import "CouponInputMoneyCell.h"
#import "CouponChoiceCell.h"
#import "CouponSwitchCell.h"
#import "CouponModel.h"

@interface CreatCouponViewController ()<LDActionSheetDelegate>
@property (nonatomic, strong) CouponSelectTextCell *cell1;
@property (nonatomic, strong) CouponModel *model;
@end

@implementation CreatCouponViewController

- (CouponModel *)model{
    if (!_model) {
        _model = [CouponModel new];
        _model.couponType = @"1";//代金券
//        _model.validDateType = 1;//永久有效
        _model.receiveType = 1;//免费领取
        _model.couponHigherAmount = -1;//最高优惠不限
        _model.couponNum = -1;//最高优惠不限
        _model.shareNum = -1;//最高优惠不限
        _model.validDays = -1;//最高优惠不限
        _model.applyShop = @"1";//全店通用
        _model.couponStatus = @"1";//未上架
        _model.shopUserNo = CurrentUser.usrNo;
    }
    return _model;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"新增优惠券";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.height -= 50;
    
    CouponSelectTextCell *cell1 = [CouponSelectTextCell new];
    cell1.title = @"优惠券类型";
    cell1.text = @"代金券";
    @weakify(self);
    cell1.tapBlock = ^{
        @strongify(self);
        [self showTypeChoice];
    };
    
    [self.scrollView addSubview:cell1];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(kScreenWidth);
    }];
    _cell1 = cell1;
    
    [self initUI_zheKou];
    
    UIButton *submitBtn = [UIButton buttonWithFontSize:16 text:@"确认添加"];
    submitBtn.frame = CGRectMake(0, kScreenHeight-50, kScreenWidth, 50);
    [self.view addSubview:submitBtn];
    [submitBtn setDefaultGradientWithCornerRadius:0];
    
    [submitBtn addTarget:self action:@selector(submitCreat) forControlEvents:UIControlEventTouchUpInside];
}

- (void)initUI_zheKou{
    
    CouponInputTextCell *cell2 = [CouponInputTextCell new];
    cell2.title = @"优惠券名称";
    cell2.textPlaceholder = @"8个字以内";
    cell2.rightText = @"";
    [self.scrollView addSubview:cell2];
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(self.cell1.mas_bottom).offset(10);
    }];
    
    //名称
    @weakify(self);
    [cell2.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.couponName = x;
    }];
    
    CouponInputMoneyCell *cell3 = [CouponInputMoneyCell new];
    cell3.title = @"优惠券金额";
    [self.scrollView addSubview:cell3];
    [cell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cell2.mas_bottom).offset(1);
    }];
    
    //折扣
    [cell3.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.couponLowerAmount = x.floatValue;
    }];
    [cell3.textField2.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.couponDiscount = x.floatValue;
    }];
    
    //最高优惠
    CouponInputTextCell *cell4 = [CouponInputTextCell new];
    cell4.title = @"最高优惠";
    cell4.textPlaceholder = @"不填写表示不限制";
    cell4.rightText = @"元";
    cell4.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.scrollView addSubview:cell4];
    [cell4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cell3.mas_bottom).offset(1);
    }];
    
    [cell4.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.floatValue <= 0) {
            self.model.couponHigherAmount = -1;
        }else{
            self.model.couponHigherAmount = x.floatValue;
        }
    }];
    
    CouponSelectTextCell *cell5 = [CouponSelectTextCell new];
    cell5.title = @"有效期";
    cell5.text = @"未设置";
    cell5.tapBlock = ^{
        @strongify(self);
        [self showDateSetting];
    };
    [self.scrollView addSubview:cell5];
    [cell5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cell4.mas_bottom).offset(1);
    }];
    
    //预发数量
    CouponInputTextCell *cellCouponCount = [CouponInputTextCell new];
    cellCouponCount.title = @"预发数量";
    cellCouponCount.textPlaceholder = @"不填写表示不限数量";
    cellCouponCount.rightText = @"张";
    cellCouponCount.textField.keyboardType = UIKeyboardTypeNumberPad;
    [self.scrollView addSubview:cellCouponCount];
    [cellCouponCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cell5.mas_bottom).offset(10);
    }];
    
    [cellCouponCount.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.integerValue <= 0) {
            self.model.couponNum = -1;
        }else{
            self.model.couponNum = x.integerValue;
        }
    }];
    
    CouponChoiceCell *cell6 = [CouponChoiceCell new];
    cell6.userInteractionEnabled = NO;
    cell6.title = @"领券方式";
    cell6.text = @"免费领取";
    [self.scrollView addSubview:cell6];
    [cell6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cellCouponCount.mas_bottom).offset(1);
    }];
    
    CouponChoiceCell *cell7 = [CouponChoiceCell new];
    cell7.userInteractionEnabled = NO;
    cell7.title = @"适用门店";
    cell7.text = @"全店通用";
    [self.scrollView addSubview:cell7];
    [cell7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cell6.mas_bottom).offset(1);
    }];
    
    CouponSwitchCell *cell8 = [CouponSwitchCell new];
    cell8.title = @"是否开启优惠券领取";
    [self.scrollView addSubview:cell8];
    [cell8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(cell7.mas_bottom).offset(10);
    }];
    
    UILabel *messageLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(12) text:@"开启优惠券领取后，用户可在微信小程序等处领取使用。" textColor:rgb(152,152,152)];
    [self.scrollView addSubview:messageLabel];
    [messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(cell8.mas_bottom);
    }];
    
#pragma mark ------------ 代金券 --------------
    //优惠券金额
    CouponInputTextCell *cell3_1 = [CouponInputTextCell new];
    cell3_1.title = @"优惠券金额";
    cell3_1.textPlaceholder = @"请输入代金券面额";
    cell3_1.rightText = @"元";
    cell3_1.hidden = NO;
    cell3_1.textField.keyboardType = UIKeyboardTypeDecimalPad;
    [self.scrollView addSubview:cell3_1];
    [cell3_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.height.mas_equalTo(cell3);
    }];
    
    [cell3_1.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.couponAmount = x.floatValue;
    }];
    
    //最低消费金额
    CouponInputTextCell *cell4_1 = [CouponInputTextCell new];
    cell4_1.title = @"最低消费金额";
    cell4_1.textPlaceholder = @"满多少元可抵用一张";
    cell4_1.rightText = @"元";
    cell4_1.hidden = NO;
    cell4_1.textField.keyboardType = UIKeyboardTypeDecimalPad;
    
    [self.scrollView addSubview:cell4_1];
    [cell4_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.height.mas_equalTo(cell4);
    }];
    
    [cell4_1.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.couponLowerAmount = x.floatValue;
    }];
    
    [self.dataArray addObjectsFromArray:@[_cell1,cell2,cell3,cell4,cell5,cell6,cell7,cell8,cell3_1,cell4_1]];
}

#pragma mark - method
- (void)showDateSetting{//设置时间
    CouponDateSettingViewController *vc = [CouponDateSettingViewController new];
    @weakify(self);
    vc.didChangeBlock = ^(CouponDate * _Nonnull dateModel) {
        @strongify(self);
        //
        CouponSelectTextCell *dateCell = self.dataArray[4];
        if (dateModel.isCustomDate) {
            self.model.validDateType = 2;//自定义时间
            self.model.startDate = dateModel.startDateStr;
            self.model.endDate = dateModel.endDateStr;
            
            NSString *start = [dateModel.startDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            NSString *end = [dateModel.endDateStr stringByReplacingOccurrencesOfString:@"-" withString:@"."];
            dateCell.text = [NSString stringWithFormat:@"%@ - %@",start,end];
        }else{
            dateCell.text = @"永久有效";
            self.model.validDateType = 1;//永久有效
        }
        
    };
    PushController(vc);
}

- (void)showTypeChoice{//券类型
    LDActionSheet *sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"代金券",@"折扣券", nil];
    [sheet showInView:KeyWindow];
    
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    CouponInputTextCell *cell3_1 = self.dataArray[8];
    CouponInputTextCell *cell4_1 = self.dataArray[9];
    
    CouponInputMoneyCell *cell3 = self.dataArray[2];
    
    if (buttonIndex == 0 && _model.couponType.integerValue != 1) {
        _model.couponType = @"1";
        cell3_1.hidden = NO;
        cell4_1.hidden = NO;
        //代金券 -最低消费
        _model.couponLowerAmount = cell4_1.textField.text.floatValue;
    }else if (buttonIndex == 1 && _model.couponType.integerValue != 2) {
        _model.couponType = @"2";
        cell3_1.hidden = YES;
        cell4_1.hidden = YES;
        //折扣券 - 消费满xx元
        _model.couponLowerAmount = cell3.textField.text.floatValue;
    }
    _cell1.text = getCouponTypeStrWithType(_model.couponType);
}

- (void)submitCreat{
    
    if (self.model.couponName.length == 0) {
        [self showMessage:@"请输入优惠券名称!"];
        return;
    }
    
    if (_model.couponLowerAmount == 0) {
        [self showMessage:@"消费金额不能为空!"];
        return;
    }
    
    if (_model.couponType.integerValue == 2) {//折扣券
        if (_model.couponDiscount == 0) {
            [self showMessage:@"折扣不能为0!"];
            return;
        }
    }else if (_model.couponType.integerValue == 1) {//代金券
        if (_model.couponAmount == 0) {
            [self showMessage:@"优惠券金额不能为空!"];
            return;
        }
    }
    
    if (self.model.validDateType == 0) {
        [self showMessage:@"请选择有效期!"];
        return;
    }
    
    CouponSwitchCell *cell8 = self.dataArray[7];
    self.model.couponStatus = cell8.isSelected?@"2":@"1";
    
    CreatCouponCheckViewController *vc = [[CreatCouponCheckViewController alloc] initWithModel:self.model];
    PushIdController(vc, LinearBackId_Order);

}


@end
