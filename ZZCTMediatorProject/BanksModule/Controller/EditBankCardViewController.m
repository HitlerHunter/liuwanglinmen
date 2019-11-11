//
//  EditBankCardViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/24.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "EditBankCardViewController.h"

#import "BankCardManager.h"
#import "DebitCardModel.h"
#import "RegisterTextFieldCell.h"

@interface EditBankCardViewController ()

@property (nonatomic, strong) DebitCardModel *model;

@property (nonatomic, strong) RegisterTextFieldCell *nameCell;
@property (nonatomic, strong) RegisterTextFieldCell *idCardNumberCell;
@property (nonatomic, strong) RegisterTextFieldCell *bankCardCell;
@property (nonatomic, strong) RegisterTextFieldCell *bankNameCell;
@property (nonatomic, strong) RegisterTextFieldCell *bankPhoneCell;

@property (nonatomic, strong) UIButton *commitBtn;
@end

@implementation EditBankCardViewController

- (instancetype)initWithModel:(DebitCardModel *)model{
    if ([super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"编辑储蓄卡";
    
    [self.view addSubview:self.scrollView];
    
    _nameCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _nameCell.title = @"姓         名";
    _nameCell.textField.placeholder = @"请输入姓名";
    [self.scrollView addSubview:_nameCell];
    [_nameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(kScreenWidth);
    }];
    [_nameCell addBottomLine];
    
    _idCardNumberCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _idCardNumberCell.title = @"身   份  证";
    _idCardNumberCell.textField.placeholder = @"请输入身份证号";
    [self.scrollView addSubview:_idCardNumberCell];
    [_idCardNumberCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameCell.mas_bottom);
        make.left.right.height.mas_equalTo(self.nameCell);
    }];
    [_idCardNumberCell addBottomLine];
    
    _bankCardCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _bankCardCell.title = @"卡         号";
    _bankCardCell.textField.placeholder = @"请输入您的银行卡号";
    [self.scrollView addSubview:_bankCardCell];
    [_bankCardCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.idCardNumberCell.mas_bottom);
        make.left.right.height.mas_equalTo(self.idCardNumberCell);
    }];
    [_bankCardCell addBottomLine];
    
    _bankNameCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _bankNameCell.title = @"所属银行";
    _bankNameCell.textField.placeholder = @"请选择所属银行";
    [self.scrollView addSubview:_bankNameCell];
    [_bankNameCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankCardCell.mas_bottom);
        make.left.right.height.mas_equalTo(self.bankCardCell);
    }];
    [_bankNameCell addBottomLine];
    
    _bankPhoneCell = [[RegisterTextFieldCell alloc] initWithStyle:RegisterTextFieldCellStyleNomal];
    _bankPhoneCell.title = @"预留手机号";
    _bankPhoneCell.textField.placeholder = @"请输入您的银行卡预留手机号码";
    [self.scrollView addSubview:_bankPhoneCell];
    [_bankPhoneCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bankNameCell.mas_bottom);
        make.left.right.height.mas_equalTo(self.bankNameCell);
    }];
    
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"添加" textColor:LZWhiteColor];
    [self.scrollView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.right.mas_equalTo(-24);
        make.top.mas_equalTo(self.bankPhoneCell.mas_bottom).offset(30);
        make.height.mas_equalTo(45);
    }];
    
    _commitBtn = commitBtn;
    [_commitBtn setDefaultGradientWithCornerRadius:4];
    [_commitBtn addTarget:self action:@selector(submit) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 25)];
    UIButton *scanCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [scanCardBtn setImage:UIImageName(@"certification_scanning") forState:UIControlStateNormal];
    scanCardBtn.frame = CGRectMake(0, 0, 25, 25);
    [scanCardBtn addTarget:self action:@selector(scanCard) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:scanCardBtn];
    _bankCardCell.textField.rightView = view;
    _bankCardCell.textField.rightViewMode = UITextFieldViewModeAlways;
    
    UIButton *moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [moreBtn setImage:UIImageName(@"more_gray") forState:UIControlStateNormal];
    moreBtn.frame = CGRectMake(0, 0, 25, 25);
    _bankNameCell.textField.rightView = moreBtn;
    _bankNameCell.textField.rightViewMode = UITextFieldViewModeAlways;
    _bankNameCell.textField.enabled = NO;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectBankName)];
    [_bankNameCell addGestureRecognizer:tap];
    
    
    self.nameCell.textField.text = _model.userName;
    self.idCardNumberCell.textField.text = _model.idCardNo;
    self.bankCardCell.textField.text = _model.debitCardNo;
    self.bankNameCell.textField.text = _model.debitBankName;
    self.bankPhoneCell.textField.text = _model.debitMobile;
    

}

//扫描银行卡
- (void)scanCard{
    
//    FBYBankCardViewController *vc = [[FBYBankCardViewController alloc] init];
//    @weakify(self);
//    vc.finishBlock = ^(NSString *bank, NSString *cardNumber) {
//        @strongify(self);
//        if (cardNumber) {
//            self.bankCardCell.textField.text = cardNumber;
//        }
//
//    };
//    PushController(vc);
}

- (void)selectBankName{
    
    SelectStoreViewController *vc = [[SelectStoreViewController alloc] initWithDataArray:[LZAppBanks bankArray]];
    @weakify(self);
    vc.block = ^(NSInteger index, NSString *name) {
        @strongify(self);
        self.bankNameCell.textField.text = name;
    };
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    [self presentViewController:vc animated:YES completion:nil];
}



- (void)submit{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否修改？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"修改" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *name = self.nameCell.textField.text;
        NSString *idCard = self.idCardNumberCell.textField.text;
        
        NSString *phone = self.bankPhoneCell.textField.text;
        NSString *bankName = self.bankNameCell.textField.text;
        NSString *cardNumber = [self.bankCardCell.textField.text stringByReplacingOccurrencesOfString:@" " withString:@""];
        
        NewParams;
        [params setSafeObject:bankName forKey:@"bankName"];
        [params setSafeObject:cardNumber forKey:@"bankCardNo"];
        [params setSafeObject:phone forKey:@"phone"];
        [params setSafeObject:@"debit" forKey:@"bankCardType"];
        
        [BankCardManager editCardWithParams:params block:^(BOOL success) {
            if (success) {
                [SVProgressHUD showSuccessWithStatus:@"修改成功！"];
                PopController;
            }
        }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)remove{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}

@end
