//
//  RewardCityViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardCityViewController.h"
#import "RewardCityCell.h"
#import "RewardCityModel.h"
#import "RewardCityViewModel.h"

@interface RewardCityViewController ()

@property (nonatomic, assign) BOOL isNotHiddenBar;
@end

@implementation RewardCityViewController

- (instancetype)initWithNotHiddenNavgationBar:(BOOL)isNotHiddenBar{
    self = [super init];
    if (self) {
        _isNotHiddenBar = isNotHiddenBar;
    }
    return self;
}

- (BOOL)hiddenNavgationBar{
    return !_isNotHiddenBar;
}

- (BOOL)hasHiddenTabBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"同城悬赏";
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 87;
    self.tableView.height -= 40+self.base_navigationbarHeight;
    [self.tableView registerClass:[RewardCityCell class] forCellReuseIdentifier:@"RewardCityCell"];
    
    [RewardCityViewModel getCityRewardWithBlock:^(id  _Nullable obj) {
        self.dataArray = obj;
        [self.tableView reloadData];
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return 10;
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RewardCityModel *model = self.dataArray[indexPath.row];
    
    RewardCityCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RewardCityCell"];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

@end
