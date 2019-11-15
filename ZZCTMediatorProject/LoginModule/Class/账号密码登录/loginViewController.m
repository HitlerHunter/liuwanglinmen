//
//  loginViewController.m
//  zhonxinV2
//
//  Created by 徐迪华 on 2017/12/5.
//  Copyright © 2017年 徐迪华. All rights reserved.
//

#import "loginViewController.h"
#import "forgetPsw1ViewController.h"
#import "UIButton+timeDown.h"
#import "CTMediator+ModuleMainActions.h"
#import "LoginViewModel.h"
#import "RegisterViewController.h"

@interface loginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *pswdTF;

@property (weak, nonatomic) IBOutlet LZLodingButton *loginBtn;


@property (nonatomic,strong) NSMutableAttributedString *pswdPlaceholder;
@property (nonatomic,strong) NSMutableAttributedString *codePlaceholder;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation loginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *title = [NSString stringWithFormat:@"%@",@"六旺临门"];
    
    self.titleLabel.text = title;
    self.widthConstraint.constant = kScreenWidth;
    
    NSString *phonePlc = @"请输入登录账号";
    _pswdPlaceholder = [[NSMutableAttributedString alloc] initWithString:phonePlc];
    [_pswdPlaceholder addAttribute:NSForegroundColorAttributeName
                             value:UIColorHex(0x9C9C9C)
                             range:NSMakeRange(0, phonePlc.length)];
    [_pswdPlaceholder addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:14]
                             range:NSMakeRange(0, phonePlc.length)];
    _phoneTF.attributedPlaceholder = _pswdPlaceholder;
    
    NSString *holderText = @"请输入登录密码";
    _pswdPlaceholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [_pswdPlaceholder addAttribute:NSForegroundColorAttributeName
                        value:UIColorHex(0x9C9C9C)
                        range:NSMakeRange(0, holderText.length)];
    [_pswdPlaceholder addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    _pswdTF.attributedPlaceholder = _pswdPlaceholder;
    
    NSString *holderText2 = @"请输入验证码";
    _codePlaceholder = [[NSMutableAttributedString alloc] initWithString:holderText2];
    [_codePlaceholder addAttribute:NSForegroundColorAttributeName
                             value:UIColorHex(0x9C9C9C)
                             range:NSMakeRange(0, holderText2.length)];
    [_codePlaceholder addAttribute:NSFontAttributeName
                             value:[UIFont systemFontOfSize:14]
                             range:NSMakeRange(0, holderText2.length)];
    
    
        // ------清除Button
    UIButton *clearButton = [_phoneTF valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:@"login_close"] forState:UIControlStateHighlighted];
    
    _loginBtn.lz_setView.lz_cornerRadius(8);
    
    [self.loginBtn setDefaultGradientWithCornerRadius:6];
    
    [self.loginBtn configText:@"登 录" loadingText:@"登 录 中"];
    @weakify(self);
    self.loginBtn.clickReturn = ^(LZLodingButton *sender) {
        @strongify(self);
        [self login];
    };
    
    
    if ([AppCenter checkAppIsDevelopment]) {
        self.phoneTF.text = @"18974908103";
        self.pswdTF.text = @"111111";
        
        self.phoneTF.text = @"18680670412";
        self.pswdTF.text = @"459615";
        
        self.phoneTF.text = @"13779799999";
        self.pswdTF.text = @"123456";
    }
    
    
//    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"注册/登录即同意《六旺商家版用户协议》" textColor:rgb(255,81,0)];
//    [btn addTarget:self action:@selector(toAgrementVC) forControlEvents:UIControlEventTouchUpInside];
//    btn.frame = CGRectMake(kScreenWidth*0.5-100, kScreenHeight-80, 200, 30);
//    [self.phoneTF.superview addSubview:btn];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"注册/登录即同意《六旺商家版用户协议》"];
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(0, attributedString.length)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(33,33,33) range:NSMakeRange(0, attributedString.length)];
    
        // text-style1
    [attributedString addAttribute:NSFontAttributeName value:Font_PingFang_SC_Medium(12) range:NSMakeRange(8, 11)];
    [attributedString addAttribute:NSForegroundColorAttributeName value:rgb(255,81,0) range:NSMakeRange(8, 11)];
    
    UILabel *label_xy = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(255,81,0)];
    [self.phoneTF.superview addSubview:label_xy];
    [label_xy mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    label_xy.attributedText = attributedString;
    
    UIButton *btn1 = [UIButton buttonWithFontSize:14 text:@"" textColor:rgb(53, 53, 53)];
    [self.phoneTF.superview addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(label_xy);
        make.size.mas_equalTo(label_xy);
    }];

    [btn1 addTarget:self action:@selector(toAgrementVC) forControlEvents:UIControlEventTouchUpInside];
}


- (void)login{
    
    [self.loginBtn loading];
    
    if (_phoneTF.text.length == 0) {
        [self showMessage:@"请输入登录账号！"];
        [self.loginBtn stopLoading];
        return;
    }
    
    NSString *phone = _phoneTF.text;
    NSString *pswd = _pswdTF.text;
    
    if (pswd.length>0) {
        //pswd.MD5
        [LoginViewModel loginWithPhone:phone pswd:pswd.MD5 block:^(NSDictionary * _Nonnull data, NSError * _Nonnull error) {
            [self handleWithData:data];
        }];
        return;
    }
    
    [self showMessage:@"请输入登录密码！"];
    [self.loginBtn stopLoading];
    
    
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

- (IBAction)toForgetPswd:(id)sender {
    forgetPsw1ViewController *vc = [forgetPsw1ViewController new];
    PushController(vc);
}

- (IBAction)toRegister{
    RegisterViewController *vc = [RegisterViewController new];
    PushController(vc);
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)toAgrementVC{
    
    H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithUrl:@"http://pay.6wang666.com/userAgreement/userAgreement.html"];
    PushController(h5);
}

@end
