//
//  AuthenMerchantInfoViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/1.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AuthenMerchantInfoViewController.h"
#import "VipPersonDetailCellView.h"

@interface AuthenMerchantInfoViewController ()

@property (nonatomic, strong) VipPersonDetailCellView *cellView1;
@property (nonatomic, strong) VipPersonDetailCellView *cellView2;
@property (nonatomic, strong) LZUserMerchant *merchant;
@end

@implementation AuthenMerchantInfoViewController

- (instancetype)initWithMerchant:(LZUserMerchant *)merchant{
    self = [super init];
    if (self) {
        self.merchant = merchant;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商户信息";
    
    [self.view addSubview:self.scrollView];
    
    [self initCellView1];
    [self initCellView2];
}

- (void)initCellView1{
    NSArray *titleArray = @[@"商户名称",@"店主名称",@"法人姓名",@"法人身份证",@"法人身份证有效期",@"经营地址"];
    NSArray *vauleArray = [self creatVauleArray1];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        model.titleTextColor = rgb(152,152,152);
        model.vauleTextColor = rgb(53,53,53);

        [arr1 addObject:model];
    }
    
    _cellView1 = [VipPersonDetailCellView new];
    _cellView1.dataArray = arr1;
    [self.scrollView addSubview:_cellView1];
    
    [_cellView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(10);
        make.width.mas_equalTo(kScreenWidth-30);
    }];
    
    _cellView1.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
}

- (void)initCellView2{
    
    NSArray *titleArray = @[@"结算账号标志",@"结算类型",@"结算费率"
                            ,@"银行名称",@"银行账号",@"开户地",@"开户支行"];
    
    NSArray *vauleArray = [self creatVauleArray2];
    
    NSMutableArray *arr1 = [NSMutableArray array];
    for (int i = 0; i < titleArray.count; i++) {
        VipPersonDetailCellModel *model = [VipPersonDetailCellModel new];
        model.title = titleArray[i];
        model.vaule = vauleArray[i];
        model.textAlignment = NSTextAlignmentRight;
        model.titleTextColor = rgb(152,152,152);
        model.vauleTextColor = rgb(53,53,53);
        [arr1 addObject:model];
      
    }
    
    _cellView2 = [VipPersonDetailCellView new];
    _cellView2.dataArray = arr1;
    [self.scrollView addSubview:_cellView2];
    
    [_cellView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.cellView1.mas_bottom).offset(10);
        make.width.mas_equalTo(kScreenWidth-30);
        make.bottom.mas_equalTo(self.scrollView.mas_bottom).offset(-30);
    }];
    
    _cellView2.lz_setView.lz_shadow(0, rgba(0, 0, 0, 0.14), CGSizeMake(0, 1), 1, 2);
    
}


- (NSMutableArray *)creatVauleArray1{
 
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    [vauleArray addSafeObject:self.merchant.pmsMerchantInfo.merchantName];
    [vauleArray addSafeObject:self.merchant.pmsMerchantInfo.linkmanName];
    [vauleArray addSafeObject:self.merchant.pmsMerchantInfo.corporationName];
    [vauleArray addSafeObject:self.merchant.pmsMerchantInfo.corporationIdcard];
    
    NSString *start = self.merchant.pmsMerchantInfo.corporationIdcardSdate;
    NSString *end = self.merchant.pmsMerchantInfo.corporationIdcardEdate;
    [vauleArray addSafeObject:[NSString stringWithFormat:@"%@\n%@",start,end]];
    
    [vauleArray addSafeObject:self.merchant.pmsMerchantInfo.address];
    
    return vauleArray;
    
}

- (NSMutableArray *)creatVauleArray2{
    
    NSMutableArray *vauleArray = [NSMutableArray array];
    
    NSString *type_js = self.merchant.pmsMerchantSettlement.balanceUserFlag;
    if (type_js.integerValue == 1) {
        type_js = @"对私";
    }else if (type_js.integerValue == 2) {
        type_js = @"对公";
    }
    
    NSString *type2_js = self.merchant.pmsMerchantSettlement.balanceUserType;
    if (type2_js.integerValue == 2) {
        type2_js = @"D+1结算";
    }else{
        type2_js = @"T+1结算";
    }
    
    [vauleArray addSafeObject:type_js];
    [vauleArray addSafeObject:type2_js];
    
    NSString *str = self.merchant.pmsMerchantSharecomp.shareComp1;
    if (IsNull(str)) {
        str = @"0";
    }
    str = [NSString stringWithFormat:@"微信/支付宝结算费率%.2lf%%",str.floatValue/100];
    
    [vauleArray addSafeObject:str];
    
    [vauleArray addSafeObject:self.merchant.pmsMerchantSettlement.headBankName];
    [vauleArray addSafeObject:self.merchant.pmsMerchantSettlement.bankAccount];
    [vauleArray addSafeObject:self.merchant.pmsMerchantSettlement.bankProvince];
    [vauleArray addSafeObject:self.merchant.pmsMerchantSettlement.bankBranch];
    
    return vauleArray;
    
}

@end
