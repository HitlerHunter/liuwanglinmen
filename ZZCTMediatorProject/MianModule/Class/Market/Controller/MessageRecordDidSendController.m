//
//  MessageRecordDidSendController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageRecordDidSendController.h"
#import "MessageSendRecordDetailViewController.h"
#import "MessageSendRecordCell.h"
#import "MessageSendRecordModel.h"
#import "MessageTaskViewModel.h"

@interface MessageRecordDidSendController ()

@property (nonatomic, strong) MessageTaskViewModel *viewModel;
@end

@implementation MessageRecordDidSendController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (BOOL)isWaitingSend{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.top.mas_equalTo(self.view);
    }];
    
    self.tableView.rowHeight = 122;
    [self.tableView registerClass:[MessageSendRecordCell class] forCellReuseIdentifier:@"MessageSendRecordCell"];
    
    
    _viewModel = [MessageTaskViewModel new];
    _viewModel.isWaitingSend = [self isWaitingSend];
    _viewModel.tableView = self.tableView;
    
    [self.viewModel refreshData];
    
    @weakify(self);
    [[[[NSNotificationCenter defaultCenter] rac_addObserverForName:MessageSendRecordNeedRefreshNotificationName object:nil] takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        [self.viewModel refreshData];
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageSendRecordModel *model = self.viewModel.dataArray[indexPath.row];
    
    MessageSendRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageSendRecordCell"];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MessageSendRecordModel *model = self.viewModel.dataArray[indexPath.row];
    MessageSendRecordDetailViewController *vc = [[MessageSendRecordDetailViewController alloc] initWithModel:model viewModel:_viewModel];
    
    PushController(vc);
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

@end
