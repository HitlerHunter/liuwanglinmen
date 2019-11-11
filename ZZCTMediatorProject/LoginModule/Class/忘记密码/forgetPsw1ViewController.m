//
//  forgetPsw1ViewController.m
//  zhonxinV2
//
//  Created by 徐迪华 on 2017/12/19.
//  Copyright © 2017年 徐迪华. All rights reserved.
//

#import "forgetPsw1ViewController.h"
#import "UIButton+timeDown.h"

@interface forgetPsw1ViewController ()

@property (nonatomic, strong) UITextField *textField_phone;
@property (nonatomic, strong) UITextField *textField_code;
@property (nonatomic, strong) UITextField *textField_pswd;

@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) NSString *codeData;
@end

@implementation forgetPsw1ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"忘记密码";
    
    self.scrollView.backgroundColor = LZWhiteColor;
    [self.view addSubview:self.scrollView];
    
    //view1
    SDBaseView *view1 = [SDBaseView new];
    [self.scrollView addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(10);
        make.right.mas_equalTo(-30);
        make.width.mas_equalTo(kScreenWidth-60);
        make.height.mas_equalTo(56);
    }];
    
    [view1 addBottomLine];
    
    UITextField *textfield_phone = [UITextField new];
    textfield_phone.keyboardType = UIKeyboardTypeNumberPad;
    textfield_phone.maxLength = 11;
    textfield_phone.placeholder = @"请输入手机号";
    [view1 addSubview:textfield_phone];
    _textField_phone = textfield_phone;
    
    [textfield_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 5, 10, 5));
    }];
    
    
    //view2
    SDBaseView *view2 = [SDBaseView new];
    [self.scrollView addSubview:view2];
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(30);
        make.top.mas_equalTo(view1.mas_bottom);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(56);
    }];
    
    [view2 addBottomLine];
    
    UIButton *btn_code = [UIButton buttonWithFontSize:16 text:@"获取验证码" textColor:rgb(255,81,0)];
    [view2 addSubview:btn_code];
    [btn_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(100);
    }];
    _getCodeBtn = btn_code;
    
    UIView *line = [UIView new];
    line.backgroundColor = rgb(198,198,198);
    [btn_code addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(1);
    }];
    
    UITextField *textfield_code = [UITextField new];
    textfield_code.keyboardType = UIKeyboardTypeNumberPad;
    textfield_code.maxLength = 6;
    textfield_code.placeholder = @"请输入短信验证码";
    [view2 addSubview:textfield_code];
    
    [textfield_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(btn_code.mas_left).offset(-5);
    }];
    
    _textField_code = textfield_code;
    
    //view3
    SDBaseView *view3 = [SDBaseView new];
    [self.scrollView addSubview:view3];
    [view3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view2);
        make.top.mas_equalTo(view2.mas_bottom);
        make.right.mas_equalTo(view2);
        make.height.mas_equalTo(view2);
    }];
    
    [view3 addBottomLine];
    
    UIButton *btn_see = [UIButton buttonWithType:UIButtonTypeCustom];
    [view3 addSubview:btn_see];
    [btn_see mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.width.mas_equalTo(40);
    }];
    
    
    UITextField *textfield_pswd = [UITextField new];
    textfield_pswd.keyboardType = UIKeyboardTypeDefault;
    textfield_pswd.maxLength = 18;
    textfield_pswd.placeholder = @"新密码(6-18位，数字+字母)";
    [view3 addSubview:textfield_pswd];
    
    [textfield_pswd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
        make.right.mas_equalTo(btn_see.mas_left).offset(-5);
    }];
    
    _textField_pswd = textfield_pswd;
    
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"确认" textColor:LZWhiteColor];
    [self.scrollView addSubview:commitBtn];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(25);
        make.top.mas_equalTo(view3.mas_bottom).offset(40);
        make.height.mas_equalTo(50);
        make.right.mas_equalTo(-25);
    }];
    
    _commitBtn = commitBtn;
    
    [_commitBtn setDefaultGradientWithCornerRadius:6];
    
    
    [_getCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
    [btn_see addTarget:self action:@selector(changeCanSee:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)changeCanSee:(UIButton *)btn{
    btn.selected = btn.isSelected;
    
    _textField_pswd.secureTextEntry = btn.isSelected;
}

- (void)getVerCode{
    
    NSString *phone = _textField_phone.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    ZZNetWorker.GET.zz_param(@{@"mobile":phone,@"appId":OEMID,@"tempId":@"forgetPw"})
    .zz_url(API_sendCode)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self.getCodeBtn startWithTime:60 maxTime:60 title:@"获取验证码" countDownTitle:@"s" timeId:@"forgrtPswdCode"];
            self.codeData = model_net.data;
        }else{
            [self showMessage:model_net.message];
        }
    });
}

- (void)checkCode{
    
    [self.view endEditing:YES];
    
    NSString *phone = _textField_phone.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    NSString *code = _textField_code.text;
    if (!code.length) {
        [self showMessage:@"请输入短信验证码!"];
        return;
    }
    
    NSString *pswd = _textField_pswd.text;
    if (pswd.length < 6) {
        [self showMessage:@"密码长度不能小于6位!"];
        return;
    }
    
    NewParams;
    [params setSafeObject:OEMID forKey:@"appId"];
    [params setSafeObject:self.codeData forKey:@"key"];
    [params setSafeObject:phone forKey:@"mobile"];
    [params setSafeObject:code forKey:@"smsCode"];
    [params setSafeObject:pswd.md5String forKey:@"newPwd"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/user-biz/password/forget")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self showMessage:@"修改密码成功"];
            [self lz_popControllerAfterDelay:1];
        }else{
            [self showMessage:model_net.message];
        }
    });
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [_getCodeBtn cancelTimer];
  
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [_getCodeBtn checkTimeWithTimeId:@"forgrtPswdCode" title:@"发送验证码" countDownTitle:@"s"];
    
}

@end
