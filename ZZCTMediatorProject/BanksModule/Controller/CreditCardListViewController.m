//
//  CreditCardListViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/24.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "CreditCardListViewController.h"
#import "BankCardCell.h"
#import "BankCardManager.h"
#import "BankCardModel.h"

#import "CreditCardAddViewController.h"
#import "EditCreditCardViewController.h"

@interface CreditCardListViewController ()
@property (nonatomic, assign) BOOL isSelectVC;
@end

@implementation CreditCardListViewController

- (instancetype)initWithIsSelectVC:(BOOL)isSelectVC{
    if ([super init]) {
        _isSelectVC = isSelectVC;
    }
    return self;
}

- (BOOL)hiddenNavgationBar{
    return !_isSelectVC;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
//    [BankCardManager getCardWithType:BankCardTypeCredit block:^(id  _Nullable obj) {
//        self.dataArray = obj;
//        [self.tableView reloadData];
//    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    self.title = @"信用卡";
    
    self.tableView.rowHeight = 150;
    [self.view addSubview:self.tableView];
    
    self.tableView.backgroundColor = [UIColor blackColor];
    
    if (self.isSelectVC) {
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.bottom.mas_equalTo(self.view);
            make.top.mas_equalTo(LZApp.shareInstance.app_navigationBarHeight);
        }];
    }else{
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.top.bottom.mas_equalTo(self.view);
        }];
    }
    
    [self.tableView registerNib:[UINib nibWithNibName:@"BankCardCell" bundle:nil] forCellReuseIdentifier:@"BankCardCell"];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 120)];
    
    UIButton *btn = [UIButton buttonWithFontSize:20 text:@"添加信用卡" textColor:LZWhiteColor cornerRadius:10];
    [btn setBackgroundImage:UIImageName(@"btn") forState:UIControlStateNormal];
    [bottomView addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.center.mas_equalTo(bottomView);
        make.height.mas_equalTo(45);
    }];
    
    self.tableView.tableFooterView = bottomView;
    
    [btn addTarget:self action:@selector(addNewCard) forControlEvents:UIControlEventTouchUpInside];
     
}

- (void)addNewCard{
    CreditCardAddViewController *vc = [[CreditCardAddViewController alloc] init];
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
    BankCardModel *model = self.dataArray[indexPath.row];
    BankCardCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BankCardCell"];
    cell.icon.image = [LZAppBanks getBankLog:model.bankName];
    cell.nameLabel.text = model.bankName;
    cell.typeLabel.text = @"信用卡";
    cell.bgImageView.image = [LZAppBanks getCardBgImageWithBankName:model.bankName];
    
    cell.cardNumberLabel.text = [NSString stringWithFormat:@"****  *****  *****  %@",[model.cardNo substringFromIndex:model.cardNo.length-4]];
    
    @weakify(self);
    cell.editBlock = ^{
        @strongify(self);
        EditCreditCardViewController *edit = [[EditCreditCardViewController alloc] initWithModel:model];
        PushController(edit);
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BankCardModel *model = self.dataArray[indexPath.row];
    
    if (self.isSelectVC) {
        if (self.didSelectBlock) {
            self.didSelectBlock(model.cardNo, model.bankName);
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

@end
