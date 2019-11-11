//
//  CouponChoiceViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponChoiceViewController.h"
#import "CouponCell.h"
#import "CouponListViewModel.h"
#import "CouponModel.h"

@interface CouponChoiceViewController ()

@property (nonatomic, strong) CouponListViewModel *viewModel;
@end

@implementation CouponChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"优惠券";
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = LZBackgroundColor;
    [self.tableView registerClass:[CouponCell class] forCellReuseIdentifier:@"CouponCell"];
    
    self.tableView.rowHeight = 120;
    
    _viewModel = [CouponListViewModel new];
    _viewModel.couponStatus = @"1";
    _viewModel.tableView = self.tableView;
    
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
    CouponModel *model = self.viewModel.dataArray[indexPath.row];
    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponCell"];
    cell.model = model;
    cell.canSelected = YES;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}



@end
