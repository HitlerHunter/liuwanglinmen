//
//  NoticeListViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NoticeListViewController.h"
#import "NoticeListViewModel.h"
#import "NoticeTableViewCell.h"

@interface NoticeListViewController ()

@property (nonatomic, strong) NoticeListViewModel *viewModel;

@end

@implementation NoticeListViewController

- (instancetype)initWithType:(NSString *)type{
    self = [super init];
    if (self) {
        self.viewModel.type = type;
    }
    return self;
}

- (BOOL)hiddenNavgationBar{
    return YES;
}
- (BOOL)hasHiddenTabBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[NoticeTableViewCell class] forCellReuseIdentifier:@"NoticeTableViewCell"];
    self.tableView.rowHeight = 75;
    self.tableView.height -= 40;
    self.viewModel.tableView = self.tableView;
    
    [self.viewModel refreshData];
}


- (NoticeListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [NoticeListViewModel new];
    }
    return _viewModel;
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
    NoticeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NoticeTableViewCell"];
    cell.model = self.viewModel.dataArray[indexPath.row];
    return cell;
}

@end
