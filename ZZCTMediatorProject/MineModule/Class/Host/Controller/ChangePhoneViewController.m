//
//  ChangePhoneViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "RegisterTextFieldCell.h"
#import "UIButton+timeDown.h"

@interface ChangePhoneViewController ()

@property (nonatomic, strong) RegisterTextFieldCell *phoneCell;
@property (nonatomic, strong) RegisterTextFieldCell *codeCell;
@property (nonatomic, strong) NSString *codeData;
@property (nonatomic, strong) UIButton *commitBtn;
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"换绑手机";
    
    [self.view addSubview:self.scrollView];
    
    _phoneCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _phoneCell.textField.placeholder = @"请输入手机号";
    [self.scrollView addSubview:_phoneCell];
    [_phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth);
    }];
    [_phoneCell addBottomLine];
    [_phoneCell setBottomLineX:15];
    
    _codeCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleCode];
    _codeCell.textField.placeholder = @"请输入验证码";
    [self.scrollView addSubview:_codeCell];
    [_codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCell.mas_bottom);
        make.left.right.height.mas_equalTo(self.phoneCell);
    }];
    @weakify(self);
    _codeCell.getCodeBlock = ^{
        @strongify(self);
        [self getVerCode];
    };
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"完成" textColor:LZWhiteColor];
    [self.scrollView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.top.mas_equalTo(self.codeCell.mas_bottom).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    _commitBtn = commitBtn;
    [_commitBtn setDefaultGradientWithCornerRadius:6];
    [_commitBtn addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *lab1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"新手机号" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    lab1.frame = CGRectMake(0, 0, 100, 20);
    _phoneCell.textField.leftView = lab1;
    _phoneCell.textField.leftViewMode = UITextFieldViewModeAlways;
    
    UILabel *lab2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"验证码" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    lab2.frame = CGRectMake(0, 0, 100, 20);
    _codeCell.textField.leftView = lab2;
    _codeCell.textField.leftViewMode = UITextFieldViewModeAlways;
}

- (void)getVerCode{
    
    NSString *phone = _phoneCell.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    ZZNetWorker.GET.zz_param(@{@"mobile":phone,@"appId":OEMID,@"tempId":@"reBind"})
    .zz_url(API_sendCode)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self.codeCell.getCodeBtn startWithTime:60 maxTime:60 title:@"获取验证码" countDownTitle:@"s" timeId:@"reBindCode"];
            self.codeData = model_net.data;
        }else{
            [self showMessage:model_net.message];
        }
    });
}

- (void)checkCode{
    
    [self.view endEditing:YES];
    
    NSString *phone = _phoneCell.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    NSString *code = _codeCell.text;
    if (!code.length) {
        [self showMessage:@"请输入短信验证码!"];
        return;
    }
    
    NewParams;
    [params setSafeObject:phone forKey:@"mobile"];
    [params setSafeObject:self.codeData forKey:@"key"];
    [params setSafeObject:code forKey:@"smsCode"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/user-biz/mobile/reset")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            CurrentUser.mobile = phone;
            [self showMessage:@"修改成功！"];
            [self lz_popControllerAfterDelay:1];
        }else{
            [self showMessage:model_net.message];
        }
    });
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.codeCell.getCodeBtn cancelTimer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.codeCell.getCodeBtn checkTimeWithTimeId:@"reBindCode" title:@"发送验证码" countDownTitle:@"s"];
}

@end
