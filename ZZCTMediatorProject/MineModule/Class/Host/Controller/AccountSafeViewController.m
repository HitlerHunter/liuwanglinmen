//
//  AccountSafeViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AccountSafeViewController.h"
#import "SettingNormalCell.h"
#import "ChangePswdViewController.h"
#import "ChangePhoneViewController.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"

@interface AccountSafeViewController ()

@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation AccountSafeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账户与安全";
    self.view.backgroundColor = LZWhiteColor;
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    //@"注销账户",
    _titleArray = @[@"会员名",@"修改手机号码",@"修改登录密码",];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titleArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    NSString *title = _titleArray[row];
   
    SettingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingNormalCell"];
    if (!cell) {
        cell = [[SettingNormalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingNormalCell"];
    }
    
    cell.textLabel.text = title;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (row == 0) {
        cell.detailTextLabel.text = CurrentUser.usrName;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if (row == 1) {
        cell.detailTextLabel.text = CurrentUser.mobile;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    
    if (row == 0) {
        
    }else if (row == 1) {
        ChangePhoneViewController *vc = [ChangePhoneViewController new];
        PushController(vc);
    }else if (row == 2) {
        ChangePswdViewController *vc = [ChangePswdViewController new];
        PushController(vc);
    }else if (row == 3) {
        
    }
    
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

/**注销*/
- (void)logout{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"账户注销确认" message:@"账户注销后，您的交易数据*****" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *man = [UIAlertAction actionWithTitle:@"暂不注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *woman = [UIAlertAction actionWithTitle:@"确定继续注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [[UserManager shareInstance] changeUserInfo:@{@"delFlag":@"1"} block:^{
            [CurrentUser loginOut];
            [CurrentUser OpenAppNotification:NO];
            [[CTMediator sharedInstance] CTMediator_showLoginViewController];
        }];
        
    }];
    [alertVC addAction:man];
    [alertVC addAction:woman];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

@end
