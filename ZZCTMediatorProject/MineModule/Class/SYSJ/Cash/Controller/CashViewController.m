//
//  CashViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/28.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "CashViewController.h"
#import "CashSubmitViewController.h"
#import "CashRecordViewController.h"
#import "BankCardManager.h"
#import "DebitCardModel.h"

@interface CashViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *bankName;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *canCashMoneyLabel;
@property (weak, nonatomic) IBOutlet UIView *infoView;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (nonatomic, assign) CGFloat minAmt;
@property (nonatomic, assign) CGFloat maxAmt;
@property (nonatomic, assign) CGFloat rate;
@property (nonatomic, assign) CGFloat singleFee;

@property (nonatomic, strong) NSString *bankNo;
@property (nonatomic, strong) NSString *bankNameStr;

@property (nonatomic, strong) NSString *ssfStr;
@property (nonatomic, strong) NSString *moneyStr;

@end

@implementation CashViewController

- (void)geRoles{
    
    ZZNetWorker.GET.zz_url(@"/account-biz/withdrawRule/1")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSDictionary *dic = model_net.data;
            if (dic) {
                self.minAmt = [[NSString formatMoneyCentToYuanString:dic[@"minAmt"]] floatValue];
                self.maxAmt = [[NSString formatMoneyCentToYuanString:dic[@"maxAmt"]] floatValue];
                self.rate = [dic[@"rate"] floatValue];
                self.singleFee = [[NSString formatMoneyCentToYuanString:dic[@"singleFee"]] floatValue];
            }
        }
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"提现";
    
    self.textField.delegate = self;
    
    [self.subBtn setDefaultGradientWithCornerRadius:5];
    
    self.canCashMoneyLabel.text = [NSString stringWithFormat:@"可提现金额%.2lf元",[NSString formatMoneyCentToYuanString:CurrentUserWallet.balance].floatValue];
    
    [self geRoles];
    
    @weakify(self);
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (x.length == 0) {
            self.infoView.hidden = YES;
            return ;
        }
        
        self.infoView.hidden = NO;
        
        [self showRaxMoney];
    }];
    
    [self addRightItemWithImage:nil title:@"记录" font:nil color:nil block:^{
        @strongify(self);
        NewClass(vc, CashRecordViewController);
        PushController(vc);
    }];
    
   
    [BankCardManager getDebitCardWithStatus:@"0" block:^(NSArray * _Nonnull array) {
        if (array.count) {
            [self showDebitCard:array.firstObject];
        }
    }];
}


- (IBAction)toSelectCard:(id)sender {
    
    BankCardListViewController *vc = [[BankCardListViewController alloc] initWithIsSelectVC:YES];
    @weakify(self);
    vc.didSelectBlock2 = ^(DebitCardModel * _Nonnull card) {
        @strongify(self);
        [self showDebitCard:card];
    };
    PushController(vc);
}

- (void)showDebitCard:(DebitCardModel *)card{
    self.bankNo = card.debitCardNo;
    self.bankNameStr = card.debitBankName;
    
    if (self.bankNo.length>4) {
        self.bankName.text = [NSString stringWithFormat:@"%@(%@)",self.bankNameStr,[self.bankNo substringWithRange:NSMakeRange(self.bankNo.length-4, 4)]];
    }
}

- (IBAction)cashAll:(id)sender {
    self.infoView.hidden = NO;
    self.textField.text = [NSString formatMoneyCentToYuanString:CurrentUserWallet.balance];
    
    [self showRaxMoney];
}

- (void)showRaxMoney{
    CGFloat money = self.textField.text.floatValue;
    CGFloat ssf = money * self.rate + self.singleFee;
    NSInteger ssf1 = self.rate*100;
    self.infoLabel.text = [NSString stringWithFormat:@"提现手续费%ld%%，实际到账%.2lf元",ssf1,money-ssf];
    self.ssfStr = [NSString formatFloatString:@(money).stringValue];
    self.moneyStr = self.textField.text;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    self.infoView.hidden = YES;
    
    return YES;
}

- (IBAction)cash:(id)sender {
    
    if (self.bankNo.length == 0) {
        [self showMessage:@"请先绑定银行卡!"];
        return;
    }

    if (self.textField.text.length == 0 || !self.textField.text) {
        return;
    }
    
    if (self.textField.text.doubleValue > [NSString formatMoneyCentToYuanString:CurrentUserWallet.balance].floatValue) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"余额不足!"]];
        return ;
    }
    
    if (self.textField.text.doubleValue < self.minAmt) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"提现金额不能少于%ld元!",(NSInteger)self.minAmt]];
        
        return ;
    }
    
    if (self.textField.text.doubleValue > self.maxAmt) {
        [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"提现金额不能多于%ld元!",(NSInteger)self.maxAmt]];
        return ;
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否确认提现？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [self cashMoney];
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)cashMoney{
    
    NSString *money = [NSString stringWithFormat:@"%ld",self.textField.text.integerValue * 100];
    
    NewParams;
    [params setSafeObject:@"1" forKey:@"ruleId"];
    [params setSafeObject:self.bankNo forKey:@"bankNo"];
    [params setSafeObject:money forKey:@"applyAmt"];
    
    [SVProgressHUD show];
    
    ZZNetWorker.POST.zz_willHandlerParam(NO)
    .zz_url(@"/account-biz/withdrawRecord")
    .zz_setParamType(ZZNetWorkerParamTypeNormalBody)
    .zz_param(params)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        [SVProgressHUD dismiss];
        if (model_net.success) {
            NewParams;
            [params setSafeObject:self.ssfStr forKey:@"ssf"];
            [params setSafeObject:self.moneyStr forKey:@"money"];
            [params setSafeObject:self.bankNo forKey:@"cardNo"];
            [params setSafeObject:self.bankNameStr forKey:@"bankName"];
            CashSubmitViewController *vc = [[CashSubmitViewController alloc] initWithDic:params];
            PushIdController(vc, LinearBackId_Cash);
        }else{
            [self showMessage:model_net.message];
        }
    });
}
@end
