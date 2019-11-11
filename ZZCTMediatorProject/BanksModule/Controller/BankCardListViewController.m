//
//  BankCardListViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/19.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BankCardListViewController.h"
#import "BankCardCell.h"
#import "BankCardAddViewController.h"
#import "BankCardManager.h"
#import "BankCardModel.h"
#import "EditBankCardViewController.h"

@interface BankCardListViewController ()

@property (nonatomic, assign) BOOL isSelectVC;
@end

@implementation BankCardListViewController

- (instancetype)initWithIsSelectVC:(BOOL)isSelectVC{
    if ([super init]) {
        _isSelectVC = isSelectVC;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getData];
}

- (void)getData{
    [BankCardManager getDebitCardWithBlock:^(id  _Nullable obj) {
        self.dataArray = obj;
        [self.tableView reloadData];
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"银行卡管理";
    
    self.tableView.rowHeight = 150;
    [self.view addSubview:self.tableView];
    
    if (_isSelectVC) {
        self.title = @"银行卡选择";
    }
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil] forCellReuseIdentifier:@"BankCardCell"];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 80)];
    
    UIButton *btn = [UIButton buttonWithFontSize:20 text:@"添加新储蓄卡" textColor:LZWhiteColor cornerRadius:10];
    [btn setBackgroundImage:UIImageName(@"btn") forState:UIControlStateNormal];
    [bottomView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.center.mas_equalTo(bottomView);
        make.height.mas_equalTo(45);
    }];
    [btn setDefaultGradientWithCornerRadius:5];
    self.tableView.tableFooterView = bottomView;
    
    [btn addTarget:self action:@selector(addNewCard) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addNewCard{
    BankCardAddViewController *vc = [[BankCardAddViewController alloc] init];
    PushController(vc);
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
//    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DebitCardModel *model = self.dataArray[indexPath.row];
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCardCell"];
    cell.icon.image = [LZAppBanks getBankLog:model.debitBankName];
    cell.nameLabel.text = model.debitBankName;
    cell.typeLabel.text = @"储蓄卡";
    cell.bgImageView.image = [LZAppBanks getCardBgImageWithBankName:model.debitBankName];
    
    cell.cardNumberLabel.text = [NSString stringWithFormat:@"****  *****  *****  %@",[model.debitCardNo substringFromIndex:model.debitCardNo.length-4]];
    
    @weakify(self);
    cell.editBlock = ^{
        @strongify(self);
        [self removeCardWithCardNo:model.debitCardNo];
    };
    
    cell.bgImageView.image = [LZAppBanks getCardBgImageWithBankName:model.debitBankName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DebitCardModel *model = self.dataArray[indexPath.row];
    
    if (self.isSelectVC) {
        if (self.didSelectBlock) {
            self.didSelectBlock(model.debitCardNo, model.debitBankName);
            PopController;
        }
        
        if (self.didSelectBlock2) {
            self.didSelectBlock2(model);
            PopController;
        }
    }
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27;
}

- (void)removeCardWithCardNo:(NSString *)cardNo{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [BankCardManager removeCardWithType:BankCardTypeDebit cardNo:cardNo block:^(BOOL success) {
            if (success) {
                [self getData];
            }
        }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
}
@end
