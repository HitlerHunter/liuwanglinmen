//
//  CreditCardAddViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/24.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "CreditCardAddViewController.h"
#import "BankCardManager.h"


@interface CreditCardAddViewController ()

@end

@implementation CreditCardAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"添加信用卡";
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[RealNameCell class] forCellReuseIdentifier:@"RealNameCell"];

    NSArray *titles = @[@"姓名：",@"身份证号：",@"信用卡号：",@"银行名称：",@"账单日:",@"还款日:",@"预留手机号："];
    NSArray *placeholders = @[@"",@"",@"请输入您的信用卡卡号",@"请输入信用卡银行名称",@"请填写信用卡的账单日",@"请填写信用卡的还款日",@"请输入该信用卡在银行预留的手机号",];
    NSArray *types = @[@(RealNameCellTypeLabel)
                       ,@(RealNameCellTypeLabel)
                       ,@(RealNameCellTypeScan)
                       ,@(RealNameCellTypeSelect)
                       ,@(RealNameCellTypeTextField)
                       ,@(RealNameCellTypeTextField)
                       ,@(RealNameCellTypeTextField)
                       ];
    NSArray *keyboardTypes = @[@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypeDefault)
                               ,@(UIKeyboardTypePhonePad)];
    
    for (int i = 0; i < titles.count; i++) {
        RealNameModel *model = [RealNameModel new];
        model.title = titles[i];
        model.placeholder = placeholders[i];
        model.type = [types[i] integerValue];
        model.keyboardType = [keyboardTypes[i] integerValue];
        model.isRequested = NO;
        
        [self.dataArray addObject:model];
        
        if (i == 0) {
//            model.content = CurrentUser.card_usrName;
        }else if (i == 1) {
//            model.content = CurrentUser.card_idNo;
        }
    }
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    
    UIButton *sureBtn = [UIButton buttonWithFontSize:20 text:@"确认添加" textColor:LZWhiteColor];
    [sureBtn setBackgroundImage:UIImageName(@"btn") forState:UIControlStateNormal];
    sureBtn.lz_setView.lz_cornerRadius(4);
    
    [bottomView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView).mas_offset(15);
        make.right.mas_equalTo(bottomView).mas_offset(-15);
        make.height.mas_equalTo(51);
        make.top.mas_equalTo(20);
    }];
    
//    UIButton *removeBtn = [UIButton buttonWithFontSize:17 text:@"删除信用卡" textColor:rgb(53,53,53)];
//    
//    [bottomView addSubview:removeBtn];
//    [removeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(bottomView);
//        make.top.mas_equalTo(sureBtn.mas_bottom).offset(8);
//    }];
    
    self.tableView.tableFooterView = bottomView;
    
    [sureBtn addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *imageView = [UIImageView viewWithImage:UIImageName(@"addCardHeaderInfo")];
    imageView.frame = CGRectMake(0, 0, kScreenWidth, 65*LZScale);
    
    self.tableView.tableHeaderView = imageView;
}

- (void)sure{
    
    [self.view endEditing:YES];
    
    RealNameModel *CreditCardModel = [self.dataArray objectAtIndex:2];
    RealNameModel *bankNameModel = [self.dataArray objectAtIndex:3];
    RealNameModel *day1Model = [self.dataArray objectAtIndex:4];//账单日
    RealNameModel *day2Model = [self.dataArray objectAtIndex:5];//还款日
    RealNameModel *phoneModel = [self.dataArray objectAtIndex:6];
    
    NSString *cardNumber = [CreditCardModel.content stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *bankName = bankNameModel.content;
    NSString *phone = phoneModel.content;
    NSString *day1 = day1Model.content;
    NSString *day2 = day2Model.content;
    
    for (RealNameModel *model in self.dataArray) {
        if (!model.content.length) {
            [self showMessage:model.placeholder];
            return;
        }
    }
    
    NewParams;
    [params setSafeObject:phone forKey:@"phone"];
    [params setSafeObject:bankName forKey:@"bankName"];
    [params setSafeObject:cardNumber forKey:@"bankCardNo"];
    [params setSafeObject:day1 forKey:@"billDate"];
    [params setSafeObject:day2 forKey:@"repayDate"];
    
    [BankCardManager addCardWithType:BankCardTypeCredit params:params block:^(BOOL success) {
        if (success) {
            PopController;
        }
    }];
    
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
    
    cell.model = model;
    
    if (model.type == RealNameCellTypeScan) {
        @weakify(self);
        cell.scanBlock = ^(RealNameModel *scanModel) {
            @strongify(self);
//            FBYBankCardViewController *vc = [[FBYBankCardViewController alloc] init];
//            
//            vc.finishBlock = ^(NSString *bank, NSString *cardNumber) {
//                if (cardNumber) {
//                    scanModel.content = cardNumber;
//                }
//            };
//            PushController(vc);
        };
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 3) {
        SelectStoreViewController *vc = [[SelectStoreViewController alloc] initWithDataArray:[LZAppBanks bankArray]];
        
        @weakify(self);
        vc.block = ^(NSInteger index, NSString *name) {
            @strongify(self);
            RealNameModel *bankName = self.dataArray[3];
            bankName.content = name;
        };
        
        vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.definesPresentationContext = YES;
        dispatch_main_async_safe(^{
            [self presentViewController:vc animated:YES completion:nil];
        });
        
    }
};




@end
