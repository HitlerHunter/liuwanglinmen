//
//  AuthenMerchantTwoViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantTwoViewController.h"
#import "AuthenMerchantTopView.h"
#import "HooDatePicker.h"
#import "AuthenMerchantThreeViewController.h"
#import "CTMediator+ModuleMineActions.h"
#import "AuthenBankManager.h"
#import "LZAddressCenter.h"
#import "AuthenMerchantAddressApiRequest.h"

@interface AuthenMerchantTwoViewController ()<HooDatePickerDelegate,AddressSelectDelegate>

@property (nonatomic, strong) LZUserMerchant *merchant;
@property (nonatomic, strong) AuthenBankManager *bankManager;
@property (nonatomic, strong) LZAddressCenter *addressCenter;
@end

@implementation AuthenMerchantTwoViewController

- (instancetype)initWithMerchant:(LZUserMerchant *)merchant{
    self = [super init];
    if (self) {
        self.merchant = merchant;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户录入";
    [self.view addSubview:self.scrollView];
    
    AuthenMerchantTopView *topView = [[AuthenMerchantTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    topView.step = 2;
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[RealNameCell class] forCellReuseIdentifier:@"RealNameCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableHeaderView = topView;
    
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    UIButton *btn = [UIButton buttonWithFontSize:18 text:@"下一步" textColor:LZWhiteColor];
    [footer addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
    }];
    
    [btn setDefaultGradientWithCornerRadius:4];
    
    @weakify(self);
    [btn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if ([self getSubmitVaule]) {
            AuthenMerchantThreeViewController *one = [[AuthenMerchantThreeViewController alloc] initWithMerchant:self.merchant];
            PushIdController(one, LinearBackId_AuthenLine);
        }
        
    }];
    
    self.tableView.tableFooterView = footer;
    
    self.merchant.pmsMerchantSharecomp.shareComp1 = @"35";
    self.merchant.pmsMerchantSharecomp.shareComp3 = @"35";
    
    if (self.merchant.pmsMerchantInfo.pnrpayMerType.intValue == 5) {
        self.merchant.pmsMerchantSettlement.balanceUserFlag = @"01";
    }
    
    [self configDataModel];
}

- (void)configDataModel{
    NSArray *titles = @[@"结算账号标志"
                        ,@"结算类型"
                        ,@"结算费率"
                        ,@"银行账号"
                        ,@"银行名称"
                        ,@"账户名称"
                        ,@"开户地"
                        ,@"开户支行"
                        ];
    NSArray *placeholders = @[@"结算账号标志"
                              ,@"结算类型"
                              ,@""
                              ,@"请与上传的银行卡照片账号一致"
                              ,@"请选择银行名称"
                              ,@"填写营业执照名称或者法人姓名"
                              ,@"请输入开户省"
                              ,@"请选择开户支行"
                              ];
    
    NSArray *types = @[@(RealNameCellTypeSelect),
                       @(RealNameCellTypeSelect),
                       @(RealNameCellTypeLabel),
                       @(RealNameCellTypeTextField),
                       @(RealNameCellTypeSelect),
                       @(RealNameCellTypeTextField),
                       @(RealNameCellTypeSelect),
                       @(RealNameCellTypeSelect),
                       ];
    
    NSArray *keyboardTypes = @[@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ];
    
    for (int i = 0; i < titles.count; i++) {
        RealNameModel *model = [RealNameModel new];
        model.title = titles[i];
        model.placeholder = placeholders[i];
        model.keyboardType = [keyboardTypes[i] integerValue];
        model.isRequested = YES;
        [self.dataArray addObject:model];
        
            //可否编辑
        if (!self.merchant.canEdit) {
            model.type = RealNameCellTypeLabel;
            model.isRequested = NO;
        }else{
            model.type = [types[i] integerValue];
        }
        
            //信息展示
        if (self.merchant.pmsMerchantInfo) {
            [self setModelValueWithIndex:i model:model];
        }
    }
}

- (BOOL)getSubmitVaule{
    __block BOOL isfinish = NO;
    [self.dataArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        isfinish =  [self getModelValueWithIndex:idx model:obj];
        if (!isfinish) {
            *stop = YES;
        }
    }];
    
    return isfinish;
}

- (void)setModelValueWithIndex:(NSInteger)index model:(RealNameModel *)model{
    
    switch (index) {
        case 0:{
            model.vaule = self.merchant.pmsMerchantSettlement.balanceUserFlag;
            if (model.vaule.integerValue == 1) {
                model.content = @"对私";
            }else if (model.vaule.integerValue == 2) {
                model.content = @"对公";
            }
        }break;
        case 1:{
            model.vaule = self.merchant.pmsMerchantSettlement.balanceUserType;
            model.content = model.vaule.integerValue == 2?@"D+1":@"T+1";
        }break;
        case 2:{
            NSString *str = self.merchant.pmsMerchantSharecomp.shareComp1;
            if (IsNull(str)) {
                str = @"0";
            }
            model.content = [NSString stringWithFormat:@"微信/支付宝结算费率%.2lf%%",str.floatValue/100];
        }break;
        case 3:{
            model.content = self.merchant.pmsMerchantSettlement.bankAccount;
        }break;
        case 4:{
            model.content = self.merchant.pmsMerchantSettlement.headBankName;
        }break;
        case 5:{
            model.content = self.merchant.pmsMerchantSettlement.bankUser;
        }break;
        case 6:{
            
            NSString *pro = self.merchant.pmsMerchantSettlement.bankProvince;
            NSString *city = self.merchant.pmsMerchantSettlement.bankCity;
            if (!IsNull(pro)) {
                if (!IsNull(city)) {
                    model.content = [pro stringByAppendingString:city];
                }else{
                    model.content = pro;
                }
            }
            model.content2 = self.merchant.pmsMerchantSettlement.bankProvince;
            model.vaule2 = self.merchant.pmsMerchantSettlement.bankProvinceId;
            model.content3 = self.merchant.pmsMerchantSettlement.bankCity;
            model.vaule3 = self.merchant.pmsMerchantSettlement.bankCityId;
        }break;
        case 7:{
            model.content = self.merchant.pmsMerchantSettlement.bankBranch;
            
        }break;
        
        default:
            break;
    }
    
}

- (BOOL)getModelValueWithIndex:(NSInteger)index model:(RealNameModel *)model{
    
    switch (index) {
        case 0:{
            self.merchant.pmsMerchantSettlement.balanceUserFlag = model.vaule;
        }break;
        case 1:{
            self.merchant.pmsMerchantSettlement.balanceUserType = model.vaule;
        }break;
        case 2:{
            
        }break;
        case 3:{
            self.merchant.pmsMerchantSettlement.bankAccount = model.content;
        }break;
        case 4:{
            self.merchant.pmsMerchantSettlement.headBankName = model.content;
        }break;
        case 5:{
            self.merchant.pmsMerchantSettlement.bankUser = model.content;
        }break;
        case 6:{
            self.merchant.pmsMerchantSettlement.bankProvince = model.content2;
            self.merchant.pmsMerchantSettlement.bankProvinceId = model.vaule2;
            self.merchant.pmsMerchantSettlement.bankCity = model.content3;
            self.merchant.pmsMerchantSettlement.bankCityId = model.vaule3;
        }break;
        case 7:{
            self.merchant.pmsMerchantSettlement.bankBranch = model.content;
        }break;
            
        default:
            break;
    }
    
    if (!model.content && !model.content2 && !model.content3 && !model.vaule && !model.vaule2 && !model.vaule3) {
        [self showMessage:@"请完善资料!"];
        return NO;
    }
    return YES;
}

- (void)Center:(LZAddressCenter *)center
      Province:(NSString *)province
          city:(NSString *)city
      district:(NSString *)district{
    
    RealNameModel *model = self.dataArray[6];
    model.content = [NSString stringWithFormat:@"%@%@",province,city];
    model.content2 = province;
    model.vaule2 = center.provinceCode;
    model.content3 = city;
    model.vaule3 = center.cityCode;
    self.addressCenter = center;
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RealNameModel *model = self.dataArray[indexPath.row];
    RealNameCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RealNameCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.merchant.canEdit) return;
    
    RealNameModel *model = self.dataArray[indexPath.row];
    
    switch (indexPath.row) {
        case 0:{
            NSString *merchantType = self.merchant.pmsMerchantInfo.pnrpayMerType;
            if (merchantType.intValue == 5) {
                return;
            }
            
            UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_SelectStoreWithDataArray:@[@"对私",@"对公"] block:^(NSInteger index, NSString *storeName) {
                model.content = storeName;
                
                if (index == 0) {
                    model.vaule = @"01";
                }else{
                    model.vaule = @"02";
                }
            }];
            dispatch_main_async_safe(^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
            
        }break;
        case 1:{
            UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_SelectStoreWithDataArray:@[@"D+1",@"T+1"] block:^(NSInteger index, NSString *storeName) {
                model.content = storeName;
                
                if (index == 0) {
                    model.vaule = @"02";
                    self.merchant.pmsMerchantSettlement.fee01 = @"0";
                }else{
                    model.vaule = @"01";
                    self.merchant.pmsMerchantSettlement.fee01 = @"";
                }
            }];
            dispatch_main_async_safe(^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
            
        }break;
        case 4:{
            [AuthenBankManager ShowBankListChoiceController:self.navigationController block:^(NSString * _Nonnull bankName) {
                model.content = bankName;
            }];
            
            
        }break;
        case 6:{
            [LZAddressCenter gotoSelectAddressWithController:self apiRequest:[AuthenMerchantAddressApiRequest new] type:AddressSelectTypeProvince finishStep:AddressSelectTypeCity];
            
        }break;
        case 7:{
            RealNameModel *model = self.dataArray[4];
            if (model.content.length == 0) {
                [self showMessage:@"请先选择银行名称!"];
                return;
            }
            [AuthenBankManager ShowBankBranchListChoiceControllerWithBankName:model.content nav:self.navigationController block:^(NSString * _Nonnull bankName) {
                RealNameModel *submodel = self.dataArray[7];
                submodel.content = bankName;
            }];
            
        }break;
    }
}

- (AuthenBankManager *)bankManager{
    if (!_bankManager) {
        _bankManager = [AuthenBankManager new];
    }
    return _bankManager;
}

@end
