//
//  RewardRecordViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardRecordViewController.h"
#import "RewardRecordCell.h"
#import "RewardRecordModel.h"
#import "RewardDetailViewController.h"
#import "RewardRecordViewModel.h"

@interface RewardRecordViewController ()

@property (nonatomic, strong) RewardRecordViewModel *viewModel;
@end

@implementation RewardRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"申请记录";
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 94;
    [self.tableView registerClass:[RewardRecordCell class] forCellReuseIdentifier:@"RewardRecordCell"];
    
    _viewModel = [RewardRecordViewModel new];
    _viewModel.tableView = self.tableView;
    
    [_viewModel refreshData];
}


#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RewardRecordModel *model = self.viewModel.dataArray[indexPath.section];
    RewardRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RewardRecordCell"];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RewardRecordModel *model = self.viewModel.dataArray[indexPath.section];
    RewardDetailViewController *vc = [[RewardDetailViewController alloc] initWithModel:model];
    PushController(vc);
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

@end
