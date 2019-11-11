//
//  FaceToFaceViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "FaceToFaceViewController.h"
#import "UIButton+timeDown.h"

#import "RegisterTextFieldCell.h"
#import "LZAddressCenter.h"

@interface FaceToFaceViewController ()

@property (nonatomic, strong) UITextField *textField_phone;
@property (nonatomic, strong) UITextField *textField_code;

@property (nonatomic, strong) RegisterTextFieldCell *cell_area;
@property (nonatomic, strong) LZAddressCenter *addressCenter;

@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) UIButton *getCodeBtn;
@property (nonatomic, strong) NSString *codeData;
@end

@implementation FaceToFaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"面对面开通";
    [self.view addSubview:self.scrollView];
    
    UILabel *lab = [UILabel labelWithFontSize:14 textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    lab.backgroundColor = rgba(255,81,0,0.18);
    lab.text = @"替好友开通后，系统默认关联在您的名下";
    [self.scrollView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(44);
    }];
    
    UITextField *phoneTF = [UITextField new];
    phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    phoneTF.font = Font_PingFang_SC_Regular(16);
    phoneTF.textColor = rgb(53,53,53);
    phoneTF.placeholder = @"请输入对方的手机号码";
    [self.scrollView addSubview:phoneTF];
    [phoneTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.top.mas_equalTo(lab.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line1 = [UIView new];
    line1.backgroundColor = rgb(219,219,219);
    [self.scrollView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.top.mas_equalTo(phoneTF.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *btn_code = [UIButton buttonWithFontSize:14 text:@"获取验证码" textColor:LZWhiteColor];
    [self.scrollView addSubview:btn_code];
    [btn_code mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(line1);
        make.top.mas_equalTo(line1.mas_bottom).offset(24);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo(120);
    }];
    [btn_code setDefaultGradientWithCornerRadius:17];
    
    UITextField *codeTF = [UITextField new];
    codeTF.keyboardType = UIKeyboardTypeNumberPad;
    codeTF.font = Font_PingFang_SC_Regular(16);
    codeTF.textColor = rgb(53,53,53);
    codeTF.placeholder = @"请输入手机验证码";
    [self.scrollView addSubview:codeTF];
    [codeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.top.mas_equalTo(line1.mas_bottom).offset(30);
        make.height.mas_equalTo(30);
    }];
    
    UIView *line2 = [UIView new];
    line2.backgroundColor = rgb(219,219,219);
    [self.scrollView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.top.mas_equalTo(codeTF.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
    }];
    
    RegisterTextFieldCell *cell_area = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    cell_area.textField.placeholder = @"请选择地区";
    cell_area.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:cell_area];
    [cell_area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line2.mas_bottom).offset(5);
        make.left.right.mas_equalTo(line2);
        make.height.mas_equalTo(40);
    }];
    cell_area.textField.enabled = NO;
    _cell_area = cell_area;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
    [cell_area addGestureRecognizer:tap];
    
    
    UIView *line3 = [UIView new];
    line3.backgroundColor = rgb(219,219,219);
    [self.scrollView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38);
        make.right.mas_equalTo(-38);
        make.top.mas_equalTo(cell_area.mas_bottom).offset(8);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:14 text:@"注册" textColor:LZWhiteColor];
    [self.scrollView addSubview:commitBtn];
    
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(38);
        make.top.mas_equalTo(cell_area.mas_bottom).offset(50);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(-38);
        make.bottom.mas_equalTo(-38);
    }];
    
    _textField_phone = phoneTF;
    _textField_code = codeTF;
    _getCodeBtn = btn_code;
    _commitBtn = commitBtn;
    
    [_commitBtn setDefaultGradientWithCornerRadius:22];
    
    [_getCodeBtn addTarget:self action:@selector(getVerCode) forControlEvents:UIControlEventTouchUpInside];
    [_commitBtn addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)addressTap{
    [LZAddressCenter gotoSelectAddressWithController:self];
}

- (void)Center:(LZAddressCenter *)center
      Province:(NSString *)province
          city:(NSString *)city
      district:(NSString *)district{
    
    _cell_area.textField.text = [NSString stringWithFormat:@"%@%@%@",province,city,district];
    self.addressCenter = center;
}

- (void)getVerCode{
    
    NSString *phone = _textField_phone.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    
    ZZNetWorker.GET.zz_param(@{@"mobile":phone,@"appId":OEMID,@"tempId":@"register"})
    .zz_url(API_sendCode)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self.getCodeBtn startWithTime:60 maxTime:60 title:@"获取验证码" countDownTitle:@"s" timeId:@"faceTofaceCode"];
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
    
    if (self.addressCenter.province.length == 0) {
        [self showMessage:@"请选择地区！"];
        return;
    }
    
    NewParams;
    [params setSafeObject:OEMID forKey:@"appId"];
    [params setSafeObject:phone forKey:@"mobile"];
    [params setSafeObject:self.codeData forKey:@"key"];
    [params setSafeObject:code forKey:@"smsCode"];
    [params setSafeObject:CurrentUser.mobile forKey:@"refMobile"];
    
    [params setSafeObject:self.addressCenter.province forKey:@"provName"];
    [params setSafeObject:self.addressCenter.provinceCode forKey:@"provCode"];
    [params setSafeObject:self.addressCenter.city forKey:@"cityName"];
    [params setSafeObject:self.addressCenter.cityCode forKey:@"cityCode"];
    [params setSafeObject:self.addressCenter.district forKey:@"areaCity"];
    [params setSafeObject:self.addressCenter.districtCode forKey:@"areaCode"];
    
    ZZNetWorker.POST.zz_param(params)
    .zz_url(@"/user-biz/sysUser/register")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"恭喜您注册成功，初始密码为手机号后六位！" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                [self lz_popController];
            }];
            
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
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
    
    [_getCodeBtn checkTimeWithTimeId:@"faceTofaceCode" title:@"发送验证码" countDownTitle:@"s"];
    
}

@end
