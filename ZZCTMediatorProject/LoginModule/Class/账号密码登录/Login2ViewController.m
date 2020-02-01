//
//  Login2ViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "Login2ViewController.h"
#import "forgetPsw1ViewController.h"
#import "UIButton+timeDown.h"
#import "CTMediator+ModuleMainActions.h"
#import "LoginViewModel.h"
#import "RegisterViewController.h"
#import "RegisterTextFieldCell.h"

@interface Login2ViewController ()

@property (nonatomic, strong) RegisterTextFieldCell *phoneCell;
@property (nonatomic, strong) RegisterTextFieldCell *codeCell;
@property (nonatomic, strong) RegisterTextFieldCell *pswdCell;

@property (strong, nonatomic) LZLodingButton *loginBtn;
@property (strong, nonatomic) UIButton *codeLoginBtn;
@property (nonatomic, strong) NSString *codeData;

@property (nonatomic,strong) NSMutableAttributedString *pswdPlaceholder;
@property (nonatomic,strong) NSMutableAttributedString *codePlaceholder;

@end

@implementation Login2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLabel = [UILabel labelWithFontSize:24 text:@"副业吧"];
    UILabel *subTitleLabel = [UILabel labelWithFontSize:13 text:@"怕钱不够花，就做副业吧！"];
    
    [self.view addSubview:titleLabel];
    [self.view addSubview:subTitleLabel];
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(self.base_navigationbarHeight+30);
        make.height.mas_equalTo(24);
    }];
    [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(titleLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(14);
    }];
    
    _phoneCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _phoneCell.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_phoneCell];
    [_phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(subTitleLabel.mas_bottom).offset(40);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(-25);
        make.height.mas_equalTo(40);
    }];
    
    _pswdCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleSecureTextEntry];
    _pswdCell.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:_pswdCell];
    [_pswdCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCell.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(self.phoneCell);
    }];
    
    _codeCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleCode];
    [self.view addSubview:_codeCell];
    [_codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCell.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(self.phoneCell);
    }];
    @weakify(self);
    _codeCell.getCodeBlock = ^{
        @strongify(self);
        [self getVerCode];
    };
    
    NSString *phonePlc = @"请输入登录账号";
    _pswdPlaceholder = [[NSMutableAttributedString alloc] initWithString:phonePlc];
    [_pswdPlaceholder addAttribute:NSForegroundColorAttributeName
                             value:UIColorHex(0x9C9C9C)
                             range:NSMakeRange(0, phonePlc.length)];
    [_pswdPlaceholder addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:16]
                             range:NSMakeRange(0, phonePlc.length)];
    _phoneCell.textField.attributedPlaceholder = _pswdPlaceholder;
    _phoneCell.lineColor = rgb(234,234,234);
    
    NSString *holderText = @"请输入登录密码";
    _pswdPlaceholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [_pswdPlaceholder addAttribute:NSForegroundColorAttributeName
                        value:UIColorHex(0x9C9C9C)
                        range:NSMakeRange(0, holderText.length)];
    [_pswdPlaceholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:16]
                        range:NSMakeRange(0, holderText.length)];
    _pswdCell.textField.attributedPlaceholder = _pswdPlaceholder;
    _pswdCell.lineColor = rgb(234,234,234);
    
    NSString *holderText2 = @"请输入验证码";
    _codePlaceholder = [[NSMutableAttributedString alloc] initWithString:holderText2];
    [_codePlaceholder addAttribute:NSForegroundColorAttributeName
                             value:UIColorHex(0x9C9C9C)
                             range:NSMakeRange(0, holderText2.length)];
    [_codePlaceholder addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:16]
                             range:NSMakeRange(0, holderText2.length)];
    _codeCell.textField.attributedPlaceholder = _codePlaceholder;
    _codeCell.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _codeCell.lineColor = rgb(234,234,234);
    
    _loginBtn = [LZLodingButton new];
    [self.view addSubview:_loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.pswdCell.mas_bottom).offset(40);
        make.left.mas_equalTo(titleLabel);
        make.right.mas_equalTo(self.pswdCell);
        make.height.mas_equalTo(50);
    }];
    [self.loginBtn configText:@"登 录" loadingText:@"登 录 中"];
    [_loginBtn setDefaultGradientWithCornerRadius:6];
    self.loginBtn.clickReturn = ^(LZLodingButton *sender) {
        @strongify(self);
        [self login];
    };
    
    
    UIButton *codeLoginBtn = [UIButton buttonWithFontSize:12 text:@"短信验证码登录" textColor:rgb(101,101,101)];
    [codeLoginBtn setTitle:@"账号密码登录" forState:UIControlStateSelected];
    [self.view addSubview:codeLoginBtn];
    [codeLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.loginBtn.mas_bottom).offset(5);
        make.left.mas_equalTo(titleLabel);
        make.height.mas_equalTo(30);
    }];
    
    [codeLoginBtn addTouchAction:^(UIButton *sender) {
        sender.selected = !sender.isSelected;
    }];
    _codeLoginBtn = codeLoginBtn;
    
    UIButton *registerBtn = [UIButton buttonWithFontSize:12 text:@"注册" textColor:rgb(101,101,101)];
    [self.view addSubview:registerBtn];
    [registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeLoginBtn);
        make.right.mas_equalTo(self.phoneCell);
        make.height.mas_equalTo(codeLoginBtn);
    }];
    [registerBtn addTarget:self action:@selector(toRegister) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgetBtn = [UIButton buttonWithFontSize:12 text:@"忘记密码" textColor:rgb(101,101,101)];
    [self.view addSubview:forgetBtn];
    [forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(codeLoginBtn);
        make.right.mas_equalTo(registerBtn.mas_left).offset(-5);
        make.height.mas_equalTo(codeLoginBtn);
        make.width.mas_equalTo(60);
    }];
    [forgetBtn addTarget:self action:@selector(toForgetPswd) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(234,234,234);
    [forgetBtn addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(forgetBtn);
        make.height.mas_equalTo(13);
        make.width.mas_equalTo(0.5);
    }];
    
    [RACObserve(codeLoginBtn, selected) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.codeCell.hidden = ![x boolValue];
        forgetBtn.hidden = [x boolValue];
    }];
    
    if ([AppCenter checkAppIsDevelopment]) {
        
        self.phoneCell.textField.text = @"13779799999";
        self.pswdCell.textField.text = @"123456";
        
        self.phoneCell.textField.text = @"18680670412";
        self.pswdCell.textField.text = @"459615";
    }
    
    [self addAgreement];
    
    codeLoginBtn.selected = YES;
}

- (void)addAgreement{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"注册/登录即同意《用户协议》"];
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(33,33,33) range:NSMakeRange(0, attributedString.length)];
    
        // text-style1
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(8, 6)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(255,81,0) range:NSMakeRange(8, 6)];
    
    UILabel *label_xy = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(255,81,0)];
    [self.view addSubview:label_xy];
    [label_xy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(0);
        make.bottom.mas_equalTo(-self.base_tabbarHeight+15);
        make.height.mas_equalTo(20);
    }];
    label_xy.attributedText = attributedString;
    
    UIButton *btn1 = [UIButton buttonWithFontSize:14 text:@"" textColor:rgb(53, 53, 53)];
    [self.view addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(label_xy);
        make.size.mas_equalTo(label_xy);
    }];

    [btn1 addTarget:self action:@selector(toAgrementVC) forControlEvents:UIControlEventTouchUpInside];
}

- (void)login{
    
    [self.loginBtn loading];
    
    NSString *phone = self.phoneCell.textField.text;
    NSString *pswd = self.pswdCell.textField.text;
    NSString *code = self.codeCell.textField.text;
    
    if (phone.length == 0) {
        [self showMessage:@"请输入登录账号！"];
        [self.loginBtn stopLoading];
        return;
    }
    
    if (_codeLoginBtn.isSelected) {
        if (code.length == 0) {
            [self showMessage:@"请输入验证码！"];
            [self.loginBtn stopLoading];
            return;
        }
        [LoginViewModel loginWithPhone:phone code:code codeKey:self.codeData block:^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
            [self handleWithData:data];
        }];
    }else{
        if (pswd.length == 0) {
            [self showMessage:@"请输入密码！"];
            [self.loginBtn stopLoading];
            return;
        }
        
        //pswd.MD5
        [LoginViewModel loginWithPhone:phone pswd:pswd.MD5 block:^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
            [self handleWithData:data];
        }];
    }
    
    
    
    
}

-(void)handleWithData:(NSDictionary *)data{
    
    [self.loginBtn stopLoading];
    
    if ([data[@"code"] integerValue] == 0) {
        data = data[@"data"];
        CurrentUser.access_token = data[@"accessToken"];
        CurrentUser.refresh_token = data[@"refreshToken"];
        CurrentUser.authType = data[@"authType"];
        
        [[UserManager shareInstance] getUserInfo:^(BOOL isSuccess) {
            if (isSuccess) {
                [AppCenter toTabBarController];
            }
        }];
        
    }else{
        [self showMessage:data[@"msg"]];
    }
}

- (void)getVerCode{
    
    NSString *phone = _phoneCell.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    ZZNetWorker.GET.zz_param(@{@"mobile":phone,@"appId":OEMID,@"tempId":@"login"})
    .zz_url(API_sendCode).zz_authorization(@"")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self.codeCell.getCodeBtn startWithTime:60 maxTime:60 title:@"获取验证码" countDownTitle:@"s" timeId:@"loginCode"];
            self.codeData = model_net.data;
        }else{
            [self showMessage:model_net.message];
        }
    });
}

- (void)toForgetPswd {
    forgetPsw1ViewController *vc = [forgetPsw1ViewController new];
    PushController(vc);
}

- (void)toRegister{
    RegisterViewController *vc = [RegisterViewController new];
    PushController(vc);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.codeCell.getCodeBtn cancelTimer];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.codeCell.getCodeBtn checkTimeWithTimeId:@"loginCode" title:@"发送验证码" countDownTitle:@"s"];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)toAgrementVC{
    
    H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithUrl:UserDelegateURL];
    PushController(h5);
}

@end
