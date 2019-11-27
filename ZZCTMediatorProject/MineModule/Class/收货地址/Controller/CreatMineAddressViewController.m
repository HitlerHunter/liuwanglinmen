//
//  CreatMineAddressViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CreatMineAddressViewController.h"
#import "MineInfoEditStyle1Cell.h"
#import "MineInfoEditInputCell.h"
#import "MineAddressModel.h"
#import "MineAddressViewModel.h"
#import "SettingSwitchView.h"
#import "LZAddressCenter.h"

@interface CreatMineAddressViewController ()

@property (nonatomic, strong) MineInfoEditInputCell *nameCell;
@property (nonatomic, strong) MineInfoEditInputCell *phoneCell;
@property (nonatomic, strong) MineInfoEditInputCell *detailAddressCell;
@property (nonatomic, strong) SettingSwitchView *defaultCell;
@property (nonatomic, strong) MineInfoEditStyle1Cell *addressCell;

@property (nonatomic, strong) LZAddressCenter *addressCenter;
@property (nonatomic, strong) MineAddressModel *model;
@property (nonatomic, assign) BOOL isAdd;
@end

@implementation CreatMineAddressViewController

- (MineAddressModel *)model{
    if (!_model) {
        _model = [MineAddressModel new];
        _model.isDefault = YES;
    }
    return _model;
}

- (instancetype)initWithModel:(MineAddressModel *)model{
    self = [super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (_model) {
        self.title = @"编辑收货地址";
    }else{
        self.title = @"新增收货地址";
        _isAdd = YES;
    }
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(self.base_navigationbarHeight+10);
        make.height.mas_greaterThanOrEqualTo(47);
    }];
    
    MineInfoEditInputCell *cell_name = [MineInfoEditInputCell new];
    cell_name.titleLabel.text = @"收货人";
    cell_name.titleLabel.textColor = rgb(152,152,152);
    cell_name.textField.text = self.model.userName;
    cell_name.textField.placeholder = @"请输入收货人名称";
    [self.view addSubview:cell_name];
    _nameCell = cell_name;
    
    MineInfoEditInputCell *cell_phone = [MineInfoEditInputCell new];
    cell_phone.titleLabel.text = @"联系方式";
    cell_phone.titleLabel.textColor = rgb(152,152,152);
    cell_phone.textField.text = self.model.mobile;
    cell_phone.textField.placeholder = @"请输入联系方式";
    [self.view addSubview:cell_phone];
    _phoneCell = cell_phone;
    
    @weakify(self);
    MineInfoEditStyle1Cell *cell_address = [MineInfoEditStyle1Cell cellWithTitle:@"所在地区" vaule:self.model.showAddress placeholder:@"请选择所在地区" block:^{
        @strongify(self);
        [self showAddress];
    }];
    cell_address.titleLabel.textColor = rgb(152,152,152);
    cell_address.valueLabel.textColor = rgb(53,53,53);
    cell_address.valueLabel.font = Font_PingFang_SC_Regular(14);
    _addressCell = cell_address;
    
    MineInfoEditInputCell *cell_detailAddress = [MineInfoEditInputCell new];
    cell_detailAddress.titleLabel.text = @"详细地址";
    cell_detailAddress.titleLabel.textColor = rgb(152,152,152);
    cell_detailAddress.textField.text = self.model.address;
    cell_detailAddress.textField.placeholder = @"请输入详细地址";
    [self.view addSubview:cell_detailAddress];
    _detailAddressCell = cell_detailAddress;
    
    NSArray *cellArray = @[cell_name,cell_phone,cell_address,cell_detailAddress];
    
    UIView *lastView = nil;
    for (UIView *cell in cellArray) {
        [bgView addSubview:cell];
        
        if (!lastView) {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(40);
            }];
        }else {
            [cell mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.mas_equalTo(0);
                make.height.mas_equalTo(40);
                make.top.mas_equalTo(lastView.mas_bottom);
            }];
        }
        lastView = cell;
    }
    [lastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    
    SettingSwitchView *cell_default = [SettingSwitchView new];
    cell_default.titleLabel.text = @"设为默认地址";
    cell_default.titleLabel.textColor = rgb(152,152,152);
    cell_default.isOn = self.model.isDefault;
    [self.view addSubview:cell_default];
    _defaultCell = cell_default;
    [cell_default mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(bgView.mas_bottom).offset(10);
    }];
    
    UIButton *saveBtn = [UIButton buttonWithFontSize:16 text:@"确认" textColor:LZWhiteColor];
    [self.view addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(cell_default.mas_bottom).offset(30);
        make.height.mas_equalTo(44);
        make.left.mas_equalTo(18);
        make.right.mas_equalTo(-18);
    }];
    [saveBtn setDefaultGradientWithCornerRadius:6];
    
    //按钮事件
    [saveBtn addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    
    if (!_isAdd) {
        UIButton *removeBtn = [UIButton buttonWithFontSize:16 text:@"删除地址" textColor:rgb(0,0,0)];
        [self.view addSubview:removeBtn];
        [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(saveBtn.mas_bottom).offset(10);
            make.height.left.right.mas_equalTo(saveBtn);
        }];
        removeBtn.lz_setView.lz_cornerRadius(6).lz_border(1, rgb(193,193,193));
        [removeBtn addTarget:self action:@selector(removeAddress) forControlEvents:UIControlEventTouchUpInside];
    }
   
    [cell_name.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.userName = x;
    }];
    
    [cell_phone.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.mobile = x;
    }];
    
    [cell_detailAddress.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        self.model.address = x;
    }];
}

- (void)showAddress{
    [LZAddressCenter gotoSelectAddressWithController:self];
}

- (void)Center:(LZAddressCenter *)center
      Province:(NSString *)province
          city:(NSString *)city
      district:(NSString *)district{
    
    self.model.showAddress = nil;
    
    self.model.provName = province;
    self.model.cityName = city;
    self.model.areaName = district;
    
    _addressCell.valueLabel.text = self.model.showAddress;
    self.addressCenter = center;
}

- (void)save{
    
    self.model.isDefault = self.defaultCell.isOn;
    
    if (_isAdd) {
        [MineAddressViewModel addAddressWithModel:self.model block:^(BOOL success) {
            if (success) {
                [self showMessage:@"新增地址成功!"];
                [self lz_popControllerAfterDelay:1];
            }
        }];
    }else{
        [MineAddressViewModel editAddressWithModel:self.model block:^(BOOL success) {
            [self showMessage:@"修改成功!"];
            [self lz_popControllerAfterDelay:1];
        }];
    }
}

- (void)removeAddress{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除收货地址？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [MineAddressViewModel removeAddressWithModel:self.model block:^(BOOL success) {
            [self showMessage:@"已删除!"];
            [self lz_popController];
        }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

@end
