//
//  RegisterViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterTextFieldCell.h"
#import "UIButton+timeDown.h"
#import "LZAddressCenter.h"

@interface RegisterViewController ()<AddressSelectDelegate>

@property (nonatomic, strong) RegisterTextFieldCell *phoneCell;
@property (nonatomic, strong) RegisterTextFieldCell *codeCell;
@property (nonatomic, strong) RegisterTextFieldCell *inviteCell;

@property (nonatomic, strong) RegisterTextFieldCell *cell_area;
@property (nonatomic, strong) LZAddressCenter *addressCenter;

@property (nonatomic, strong) UIButton *commitBtn;
@property (nonatomic, strong) NSString *codeData;
@property (nonatomic, strong) UIButton *agreementBtn;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"注册";
    
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = LZWhiteColor;
    
    _phoneCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _phoneCell.textField.placeholder = @"请输入手机号";
    [self.scrollView addSubview:_phoneCell];
    [_phoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(kScreenWidth-60);
    }];
    
    _codeCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleCode];
    [self.scrollView addSubview:_codeCell];
    [_codeCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.phoneCell.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(self.phoneCell);
    }];
    @weakify(self);
    _codeCell.getCodeBlock = ^{
        @strongify(self);
        [self getVerCode];
    };
    
    _inviteCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _inviteCell.maxLength = 11;
    _inviteCell.textField.keyboardType = UIKeyboardTypeNumberPad;
    _inviteCell.textField.placeholder = @"请输入邀请人手机号";
    [self.scrollView addSubview:_inviteCell];
    [_inviteCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.codeCell.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(self.phoneCell);
    }];
    
    RegisterTextFieldCell *cell_area = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    cell_area.textField.placeholder = @"请选择地区";
    [self.scrollView addSubview:cell_area];
    [cell_area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.inviteCell.mas_bottom).offset(5);
        make.left.right.height.mas_equalTo(self.phoneCell);
    }];
    cell_area.textField.enabled = NO;
    _cell_area = cell_area;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addressTap)];
    [cell_area addGestureRecognizer:tap];
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"确认" textColor:LZWhiteColor];
    [self.scrollView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.inviteCell);
        make.top.mas_equalTo(cell_area.mas_bottom).offset(60);
        make.height.mas_equalTo(50);
    }];
    
    _commitBtn = commitBtn;
    [_commitBtn setDefaultGradientWithCornerRadius:6];
    [_commitBtn addTarget:self action:@selector(checkCode) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectBtn setImage:UIImageName(@"register_unselected") forState:UIControlStateNormal];
    [selectBtn setImage:UIImageName(@"register_selected") forState:UIControlStateSelected];
    [selectBtn setTitle:@"同意" forState:UIControlStateNormal];
    [selectBtn setTitleColor:rgb(53,53,53) forState:UIControlStateNormal];
    selectBtn.titleLabel.font = Font_PingFang_SC_Regular(14);
    selectBtn.selected = YES;
    selectBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, -5);
    [selectBtn addTouchAction:^(UIButton *sender) {
        sender.selected = !sender.isSelected;
    }];
    _agreementBtn = selectBtn;
    
    UIButton *btn = [UIButton buttonWithFontSize:14 text:@"《六旺商家版用户协议》" textColor:rgb(255,81,0)];
    [btn addTarget:self action:@selector(toAgrementVC) forControlEvents:UIControlEventTouchUpInside];
    
    [self.scrollView addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(commitBtn);
        make.bottom.mas_equalTo(commitBtn.mas_top).offset(-10);
        make.size.mas_equalTo(CGSizeMake(60, 20));
    }];
    
    [self.scrollView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(selectBtn.mas_right).offset(-5);
        make.centerY.mas_equalTo(selectBtn);
        make.height.mas_equalTo(20);
    }];
}

- (void)toAgrementVC{
    H5CommonViewController *h5 = [[H5CommonViewController alloc] initWithNoEncodeUrl:[NSString stringWithFormat:@"%@?oemId=%@",UserRegisterDelegateURL,OEMID]];
    PushController(h5);
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
    
    NSString *phone = _phoneCell.text;
    if (phone.length != 11) {
        [self showMessage:@"请填写正确的手机号码！"];
        return;
    }
    
    ZZNetWorker.GET.zz_param(@{@"mobile":phone,@"appId":OEMID,@"tempId":@"register"})
    .zz_url(API_sendCode)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self.codeCell.getCodeBtn startWithTime:60 maxTime:60 title:@"获取验证码" countDownTitle:@"s" timeId:@"registerCode"];
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
    
    NSString *invite = _inviteCell.text;
    if (invite.length != 11) {
        [self showMessage:@"请填写正确的邀请人手机号码！"];
        return;
    }
    
    if (self.addressCenter.province.length == 0) {
        [self showMessage:@"请选择地区！"];
        return;
    }
    
    if (!_agreementBtn.isSelected) {
        [self showMessage:@"请先同意注册协议！"];
        return;
    }
    
    NewParams;
    [params setSafeObject:OEMID forKey:@"appId"];
    [params setSafeObject:phone forKey:@"mobile"];
    [params setSafeObject:self.codeData forKey:@"key"];
    [params setSafeObject:code forKey:@"smsCode"];
    [params setSafeObject:invite forKey:@"refMobile"];
    
    [params setSafeObject:self.addressCenter.province forKey:@"provName"];
    [params setSafeObject:self.addressCenter.provinceCode forKey:@"provCode"];
    [params setSafeObject:self.addressCenter.city forKey:@"cityName"];
    [params setSafeObject:self.addressCenter.cityCode forKey:@"cityCode"];
    [params setSafeObject:self.addressCenter.district forKey:@"areaCity"];
    [params setSafeObject:self.addressCenter.districtCode forKey:@"areaCode"];
    
    ZZNetWorker.POST.zz_param(params).zz_url(@"/user-biz/sysUser/register")
        .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"恭喜您注册成功，初始密码为手机号后六位！" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"去登录" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
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
    
    [self.codeCell.getCodeBtn cancelTimer];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.codeCell.getCodeBtn checkTimeWithTimeId:@"registerCode" title:@"发送验证码" countDownTitle:@"s"];
}

@end
