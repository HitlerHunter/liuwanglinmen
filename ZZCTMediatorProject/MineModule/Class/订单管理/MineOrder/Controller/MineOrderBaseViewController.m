//
//  MineOrderBaseViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/18.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineOrderBaseViewController.h"
#import "MineOrderTableViewCell.h"
#import "MineOrderDetailViewController.h"
#import "NoMoreOrderView.h"

@interface MineOrderBaseViewController ()
@property (nonatomic, strong) NoMoreOrderView *noOrderView;
@end

@implementation MineOrderBaseViewController

- (BOOL)hiddenNavgationBar{
    return NO;
}

- (BOOL)hasHiddenTabBar{
    return YES;
}

- (instancetype)initWithStatus:(NSString *)status{
    self = [super init];
    if (self) {
        self.viewModel.orderStatus = status;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = LZBackgroundColor;
    [self.view addSubview:self.tableView];
    self.tableView.height -= 46;
    self.tableView.top = 0;
    self.tableView.rowHeight = 216;
    
    [self.tableView registerClass:[MineOrderTableViewCell class] forCellReuseIdentifier:@"MineOrderTableViewCell"];
    
    
    self.viewModel.tableView = self.tableView;
    
    
    [self refreshData];
    
    @weakify(self);
    //支付回调处理
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:WXPayFinishedHotGoodsNotificationName object:nil] subscribeNext:^(NSNotification * _Nullable x) {
        @strongify(self);
        AppPayStatus status = [x.object integerValue];
        if (status == AppPayStatusSuccess) {
            
            [self refreshData];
        }
    }];
}

- (void)refreshData{
    [self.viewModel refreshData];
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
    MineOrderModel *model = self.viewModel.dataArray[indexPath.row];
    
    MineOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOrderTableViewCell"];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineOrderModel *model = self.viewModel.dataArray[indexPath.row];
    MineOrderDetailViewController *vc = [[MineOrderDetailViewController alloc] initWithOrderId:model.Id];
    PushController(vc);
    
};

- (MineOrderViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [MineOrderViewModel new];
    }
    return _viewModel;
}

@end
