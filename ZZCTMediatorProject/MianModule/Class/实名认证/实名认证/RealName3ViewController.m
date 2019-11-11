//
//  RealName3ViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "RealName3ViewController.h"
#import "RealNameViewModel.h"
#import "LZAddressCenter.h"
#import "UIButton+timeDown.h"

#import "SelectStoreViewController.h"
#import "BankCardManager.h"
#import "JYBDBankCardVC.h"
@interface RealName3ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *bankCardTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *bankNameLabel;

@property (weak, nonatomic) IBOutlet UIButton *nextBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthConstraint;

@end

@implementation RealName3ViewController

- (void)setViewModel:(RealNameViewModel *)viewModel{
    _viewModel = viewModel;
    
    [self setUIData];
}

- (BOOL)needDismissHUD{
    return YES;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    [_nextBtn setDefaultGradientWithCornerRadius:4];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.nextBtn.lz_setView.lz_cornerRadius(10);

    self.widthConstraint.constant = kScreenWidth;
    
    [self setUIData];
}

- (void)setUIData{
    if (_viewModel.name) {
        _nameLabel.text = _viewModel.name;
    }
    
    if (_viewModel.IDCardNumber) {
        _cardNumberLabel.text = _viewModel.IDCardNumber;
    }
    
    if (_viewModel.bankCardNumber) {
        _bankCardTextField.text = _viewModel.bankCardNumber;
    }
    
    if (_viewModel.phone) {
        _phoneTextField.text = _viewModel.phone;
    }
    
    if (_viewModel.bankName) {
        _bankNameLabel.text = _viewModel.bankName;
    }
    
}


- (IBAction)selectBankName:(id)sender {
    
    SelectStoreViewController *vc = [[SelectStoreViewController alloc] initWithDataArray:[LZAppBanks bankArray]];
    @weakify(self);
    vc.block = ^(NSInteger index, NSString *name) {
        @strongify(self);
        self.viewModel.bankName = name;
        self.bankNameLabel.text = name;
    };
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    [self presentViewController:vc animated:YES completion:nil];
}


- (IBAction)scanCard:(id)sender {
    
//    FBYBankCardViewController *vc = [[FBYBankCardViewController alloc] init];
//    @weakify(self);
//    vc.finishBlock = ^(NSString *bank, NSString *cardNumber) {
//        @strongify(self);
//        if (cardNumber) {
//            self.bankCardTextField.text = cardNumber;
//        }
//    };
//    PushController(vc);
    
        __weak __typeof__(self) weakSelf = self;
       JYBDBankCardVC *vc = [[JYBDBankCardVC alloc]init];
       vc.finish = ^(JYBDBankCardInfo *info, UIImage *image) {

           weakSelf.bankCardTextField.text = info.bankNumber;
       };
       [self.navigationController pushViewController:vc animated:YES];
}



- (IBAction)submit:(id)sender {
    
    NSString *phone = self.phoneTextField.text;
    NSString *bankCardNum = self.bankCardTextField.text;
    
    if (phone.length != 11) {
        [self showMessage:@"请输入正确的手机号码"];
        return;
    }
 
    if (bankCardNum.length == 0) {
        [self showMessage:@"请输入银行卡号"];
        return;
    }
 
    if (!self.viewModel.bankName.length) {
        [self showMessage:@"请选择所属银行"];
        return;
    }
    
    self.viewModel.phone = phone;
    self.viewModel.bankCardNumber = bankCardNum;
    
    
        //验证验证码
    [SVProgressHUD show];
    
    NewParams;
    [params setSafeObject:self.viewModel.bankName forKey:@"debitBankName"];
    [params setSafeObject:self.viewModel.bankCardNumber forKey:@"debitCardNo"];
    [params setSafeObject:self.viewModel.phone forKey:@"debitMobile"];
    [params setSafeObject:self.viewModel.IDCardNumber forKey:@"idCardNo"];
    [params setSafeObject:@"1" forKey:@"idCardType"];
    [params setSafeObject:@"0" forKey:@"state"];
    [params setSafeObject:self.viewModel.name forKey:@"userName"];
    [params setSafeObject:CurrentUser.usrNo forKey:@"usrNo"];
    
    [BankCardManager addCardWithType:BankCardTypeDebit params:params block:^(BOOL success) {
        [SVProgressHUD dismiss];
        [self showMessage:@"实名认证成功!"];
        [[UserManager shareInstance] getUserInfo:^(BOOL isSuccess) {
            [AppCenter toTabBarController];
        }];
//        [self lineBackWithId:LinearBackId_realName];
    }];
}



@end
