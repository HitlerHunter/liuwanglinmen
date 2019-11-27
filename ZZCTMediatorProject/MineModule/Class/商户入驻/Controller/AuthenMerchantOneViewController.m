//
//  AuthenMerchantOneViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantOneViewController.h"
#import "AuthenMerchantTopView.h"
#import "HooDatePicker.h"
#import "AuthenMerchantTwoViewController.h"
#import "CTMediator+ModuleMineActions.h"

@interface AuthenMerchantOneViewController ()<HooDatePickerDelegate>

@property (nonatomic, strong) LZUserMerchant *merchant;
@property (nonatomic, strong) HooDatePicker *YMDPicker;
@property (nonatomic, assign) BOOL isSelectCorporationIdcard;
@property (nonatomic, assign) BOOL isSelectIDCardStartDate;
@property (nonatomic, strong) NSString *dateString;
@end

@implementation AuthenMerchantOneViewController

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
    topView.step = 1;
    
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
            AuthenMerchantTwoViewController *one = [[AuthenMerchantTwoViewController alloc] initWithMerchant:self.merchant];
            PushIdController(one, LinearBackId_AuthenLine);
        }
        
    }];
    
    self.tableView.tableFooterView = footer;
    
    if (self.merchant.pmsMerchantInfo.status_lz == AuthenMerchantStatusNoSubmit) {
        self.merchant.pmsMerchantInfo.pnrpayMerType = @"5";
        self.merchant.pmsMerchantSettlement.balanceUserFlag = @"01";
        self.merchant.pmsMerchantSettlement.balanceUserType = @"02";
        self.merchant.pmsMerchantInfo.merchantType = @"03";
        self.merchant.pmsMerchantSettlement.fee01 = @"0";
    }
    
    
    [self configDataModel];
}

- (void)configDataModel{
    NSArray *titles = @[@"商户名称"
                        ,@"商户类型"
                        ,@"店主名称"
                        ,@"法人姓名"
                        ,@"法人身份证"
                        ,@"法人身份证有效日期"
                        ,@"营业执照号"
                        ,@"营业执照有效期"
                        ,@"经营地址"];
    NSArray *placeholders = @[@"请与商户营业执照保持一致"
                              ,@"请选择商户类型"
                              ,@"填写营业执照名称或者法人姓名"
                              ,@"请填写法人姓名"
                              ,@"请填写法人身份证号"
                              ,@""
                              ,@"请填写营业执照号"
                              ,@""
                              ,@"请填写商户实际经营地址"];
    
    NSArray *types = @[@(RealNameCellTypeTextField),
                       @(RealNameCellTypeSelect),
                       @(RealNameCellTypeTextField),
                       @(RealNameCellTypeTextField),
                       @(RealNameCellTypeTextField),
                       @(RealNameCellTypeSelect),
                       @(RealNameCellTypeTextField),
                       @(RealNameCellTypeSelect),
                       @(RealNameCellTypeTextField)];
    
    NSArray *keyboardTypes = @[@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
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
            model.content = self.merchant.pmsMerchantInfo.merchantName;
        }break;
        case 1:{
            model.vaule = self.merchant.pmsMerchantInfo.pnrpayMerType;
            model.content = getMerchantTypeNameWithType(model.vaule);
        }break;
        case 2:{
            model.content = self.merchant.pmsMerchantInfo.linkmanName;
        }break;
        case 3:{
            model.content = self.merchant.pmsMerchantInfo.corporationName;
        }break;
        case 4:{
            model.content = self.merchant.pmsMerchantInfo.corporationIdcard;
        }break;
        case 5:{
            model.vaule = self.merchant.pmsMerchantInfo.corporationIdcardSdate;
            model.vaule2 = self.merchant.pmsMerchantInfo.corporationIdcardEdate;
            if (!IsNull(model.vaule) && !IsNull(model.vaule2)) {
                model.content = [NSString stringWithFormat:@"%@ 至\n%@",model.vaule,model.vaule2];
            }
        }break;
        case 6:{
            model.content = self.merchant.pmsMerchantInfo.creditCode;
        }break;
        case 7:{
            
            model.vaule = self.merchant.pmsMerchantInfo.licSdate;
            model.vaule2 = self.merchant.pmsMerchantInfo.licEdate;
            if (!IsNull(model.vaule) && !IsNull(model.vaule2)) {
                model.content = [NSString stringWithFormat:@"%@ 至\n%@",model.vaule,model.vaule2];
            }
        }break;
        case 8:{
            model.content = self.merchant.pmsMerchantInfo.address;
        }break;
        
        default:
            break;
    }
    
}

- (BOOL)getModelValueWithIndex:(NSInteger)index model:(RealNameModel *)model{
    
    switch (index) {
        case 0:{
            self.merchant.pmsMerchantInfo.merchantName = model.content;
        }break;
        case 1:{
            self.merchant.pmsMerchantInfo.pnrpayMerType = model.vaule;
        }break;
        case 2:{
            self.merchant.pmsMerchantInfo.linkmanName = model.content;
        }break;
        case 3:{
            self.merchant.pmsMerchantInfo.corporationName = model.content;
        }break;
        case 4:{
            self.merchant.pmsMerchantInfo.corporationIdcard = model.content;
        }break;
        case 5:{
            self.merchant.pmsMerchantInfo.corporationIdcardSdate = model.vaule;
            self.merchant.pmsMerchantInfo.corporationIdcardEdate = model.vaule2;
        }break;
        case 6:{
            self.merchant.pmsMerchantInfo.creditCode = model.content;
        }break;
        case 7:{
            self.merchant.pmsMerchantInfo.licSdate = model.vaule;
            self.merchant.pmsMerchantInfo.licEdate = model.vaule2;
        }break;
        case 8:{
            self.merchant.pmsMerchantInfo.address = model.content;
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
        case 1:{
            NSArray *arr = @[@"政府机构",@"国营企业",@"私营企业"
                             ,@"外资企业",@"个体工商户",@"事业单位",];
            NSArray *vauleArr = @[@"1",@"2",@"3"
            ,@"4",@"5",@"7",];
            UIViewController *viewController = [[CTMediator sharedInstance] CTMediator_SelectStoreWithDataArray:arr block:^(NSInteger index, NSString *storeName) {
                model.content = storeName;
                model.vaule = vauleArr[index];
            }];
            dispatch_main_async_safe(^{
                [self presentViewController:viewController animated:YES completion:nil];
            });
        }break;
        case 5:{
            self.isSelectIDCardStartDate = YES;
            self.isSelectCorporationIdcard = YES;
            self.YMDPicker.title = @"开始日期";
            _YMDPicker.maximumDate = nil;
            _YMDPicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:1];
            [self.YMDPicker show];
        }break;
        case 7:{
            self.isSelectIDCardStartDate = YES;
            self.isSelectCorporationIdcard = NO;
            self.YMDPicker.title = @"开始日期";
            _YMDPicker.maximumDate = nil;
            _YMDPicker.minimumDate = [NSDate dateWithTimeIntervalSince1970:1];
            [self.YMDPicker show];
        }break;
            
        default:
            break;
    }
};

#pragma mark - dateDelegate
- (void)datePicker:(HooDatePicker *)dataPicker didSelectedDate:(NSDate *)date{
    
    RealNameModel *model;
    
    if (_isSelectCorporationIdcard) {
        model = [self.dataArray safeObjectWithIndex:5];
    }else{
        model = [self.dataArray safeObjectWithIndex:7];
    }
    
    if (self.isSelectIDCardStartDate) {
        _dateString = [date formatYMDWithSeparate:@"-"];
        self.isSelectIDCardStartDate = NO;
        self.YMDPicker.title = @"结束日期";
        
        _YMDPicker.maximumDate = [NSDate dateWithTimeIntervalSinceNow:3111111111];
        _YMDPicker.minimumDate = [NSDate date];
        [self.YMDPicker performSelector:@selector(show) withObject:nil afterDelay:1];
        model.vaule = _dateString;
        
    }else{
        model.vaule2 = [date formatYMDWithSeparate:@"-"];
        _dateString = [NSString stringWithFormat:@"%@ 至\n%@",_dateString,model.vaule2];
        model.content = _dateString;
        _YMDPicker.maximumDate = nil;
        
    }
    
}

- (HooDatePicker *)YMDPicker{
    if (!_YMDPicker) {
        _YMDPicker = [[HooDatePicker alloc] initDatePickerMode:HooDatePickerModeDate andAddToSuperView:KeyWindow];
        _YMDPicker.delegate = self;
            //        _YMDPicker.timeZone = [NSTimeZone localTimeZone];
        
    }
    return _YMDPicker;
}
@end
