//
//  MineSettingViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "MineSettingViewController.h"
#import "SettingNormalCell.h"
#import "SettingSwitchCell.h"
#import "MineKefuViewController.h"

#import "MineNoticeSettingViewController.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"
#import "LoginOutCell.h"
#import "AccountSafeViewController.h"
#import "MineSettingTopView.h"
#import "FeedbackViewController.h"

@interface MineSettingViewController ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *iconArray;
@end

@implementation MineSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"设置";
    self.view.backgroundColor = LZWhiteColor;
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    [self.tableView registerClass:[SettingSwitchCell class] forCellReuseIdentifier:@"SettingSwitchCell"];
    [self.tableView registerClass:[LoginOutCell class] forCellReuseIdentifier:@"LoginOutCell"];
    
    MineSettingTopView *topView = [[MineSettingTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    self.tableView.tableHeaderView = topView;
    
    _titleArray = @[@[@"账户与安全"],@[@"语音播报",@"消息推送设置"],@[@"清除缓存",@"当前版本",@"意见反馈"],@[@"退出登录"]];
    _iconArray = @[@[@"zhanghaoshezhi"],@[@"yuyinbobaox",@"yuyinbobaox"],@[@"qinglihuancun",@"banben",@"guanyu"],@[@""]];
}


#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = _titleArray[section];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    NSString *title = _titleArray[section][row];
    NSString *icon = _iconArray[section][row];
    if (section == 1 && row == 0) {
        SettingSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingSwitchCell"];
        cell.textLabel.text = title;
        cell.imageView.image = UIImageName(icon);
        cell.switch_.on = !CurrentUser.isCloseTTS;
        
        cell.vauleChangedBlock = ^(BOOL isOn) {
            CurrentUser.isCloseTTS = !isOn;
        };
        
        return cell;
    }
    
    if (section == 3 && row == 0) {
        LoginOutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LoginOutCell"];
        cell.textLabel.text = title;
        return cell;
    }

    
    SettingNormalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingNormalCell"];
    if (!cell) {
        cell = [[SettingNormalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SettingNormalCell"];
    }
    
    cell.textLabel.text = title;
    cell.imageView.image = UIImageName(icon);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if (section == 2) {
        if (row == 0) {
            cell.detailTextLabel.text = [self getLocalCache];
            
        }else if (row == 1) {
            cell.detailTextLabel.text = AppVersion;
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSInteger row = indexPath.row;
    NSInteger section = indexPath.section;
    
    if (section == 0 && row == 0) {
        AccountSafeViewController *vc = [AccountSafeViewController new];
        PushController(vc);
    }else if (section == 1 && row == 1) {
        MineNoticeSettingViewController *vc = [MineNoticeSettingViewController new];
        PushController(vc);
    }else if (section == 2) {
        if (row == 0) {
            [self clearLocalCache];
        }else if (row == 1) {
            
        }else if (row == 2) {
            FeedbackViewController *vc = [FeedbackViewController new];
            PushController(vc);
        }else if (row == 3) {
            
        }
    }else if (section == 3 && row == 0) {
        [self logout];
    }
    
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (NSString *)getLocalCache{
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    CGFloat size_M = cacheSize/(1024*1024.0);
    
    return [NSString stringWithFormat:@"%.1lfM",size_M];
}

- (void)clearLocalCache{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否清除缓存？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    @weakify(self);
    UIAlertAction *clear = [UIAlertAction actionWithTitle:@"清除缓存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD showWithStatus:@"正在清除"];
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [SVProgressHUD dismiss];
            [SVProgressHUD showSuccessWithStatus:@"清除完成"];
            
            @strongify(self);
            [self.tableView reloadData];
        }];
    }];
    [alertVC addAction:cancel];
    [alertVC addAction:clear];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)logout{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否退出登录？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *man = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *woman = [UIAlertAction actionWithTitle:@"退出登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CurrentUser loginOut];
        [CurrentUser OpenAppNotification:NO];
        [[CTMediator sharedInstance] CTMediator_showLoginViewController];
    }];
    [alertVC addAction:man];
    [alertVC addAction:woman];
    
    [self presentViewController:alertVC animated:YES completion:nil];
}
@end
