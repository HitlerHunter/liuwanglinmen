//
//  ChangePswdViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ChangePswdViewController.h"
#import "ChangePswdCell.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"

@interface ChangePswdViewController ()

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *placeholder;

@property (nonatomic, strong) NSString *pswd;
@property (nonatomic, strong) NSString *repswd;
@property (nonatomic, strong) NSString *repswd2;
@end

@implementation ChangePswdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[ChangePswdCell class] forCellReuseIdentifier:@"ChangePswdCell"];
    
    _titleArray = @[@"原密码",@"新密码",@"确认密码"];
    _placeholder = @[@"请输入原密码",@"请输入6-20位密码",@"确认密码"];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"保存" font:nil color:nil block:^{
        @strongify(self);
        [self submit];
    }];
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
    
    ChangePswdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChangePswdCell"];
    cell.textLabel.text = _titleArray[row];
    cell.textField.placeholder = _placeholder[row];
    
    @weakify(self);
    [[cell.textField.rac_textSignal takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self);
        if (row == 0) {
            self.pswd = x;
        }else if (row == 1) {
            self.repswd = x;
        }else if (row == 2) {
            self.repswd2 = x;
        }
    }];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}


- (void)submit{

    [self.view endEditing:YES];
    
    if (!self.pswd.length) {
        [self showMessage:@"请输入原密码！"];
        return;
    }
    
    if (!self.repswd) {
        [self showMessage:@"请输入新密码！"];
        return;
    }
    
    if (![self.repswd isEqualToString:self.repswd2]) {
        [self showMessage:@"确认密码不一致！"];
        return;
    }
    
    [SVProgressHUD show];
    ZZNetWorker.POST.zz_url(@"/user-biz/password/reset")
    .zz_param(@{@"oldPwd":self.pswd.MD5,@"newPwd":self.repswd.MD5})
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            [self showMessage:@"修改成功"];
            [CurrentUser loginOut];
            [CurrentUser OpenAppNotification:NO];
            [[CTMediator sharedInstance] CTMediator_showLoginViewController];
        }else{
            [self showMessage:model_net.message];
        }
        
    });
    
}



@end
