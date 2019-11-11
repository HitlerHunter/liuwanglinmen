//
//  ManManagerViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "MineTeamViewController.h"
#import "MineTeamHeaderView.h"
#import "ManManagerModel.h"
#import "MineTeamViewModel.h"
#import "MineTeamCell.h"

@interface MineTeamViewController ()

@property (nonatomic, strong) MineTeamHeaderView *headerView;

@property (nonatomic, strong) NSArray *myUserList;
@property (nonatomic, strong) NSArray *elseUserList;

@property (nonatomic, strong) NSArray *currentList;
@end

@implementation MineTeamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
    
    self.title = @"我的团队";
    _headerView = [[MineTeamHeaderView alloc] init];
    [self.view addSubview:_headerView];
    [_headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
//        make.width.mas_equalTo(kScreenWidth);
        make.top.mas_equalTo(self.base_navigationbarHeight);
        make.height.mas_equalTo(170);
    }];
    
    [self.tableView registerClass:[MineTeamCell class] forCellReuseIdentifier:@"MineTeamCell"];
    self.tableView.rowHeight = 60;
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.headerView.mas_bottom).offset(5);
        make.height.mas_equalTo(170);
    }];
    self.tableView.lz_setView.lz_shadow(3, rgba(0, 0, 0, 0.11), CGSizeMake(0, 2), 1, 11);
    
    [MineTeamViewModel getMineTeamData:^(NSDictionary * _Nonnull dic, NSArray<ManManagerModel *> * _Nonnull elseUserList, NSArray<ManManagerModel *> * _Nonnull myUserList) {
        
        
        self.headerView.numberLabelLeft.text = [NSString formatIntString:dic[@"countToday"]];
        self.headerView.numberLabelRight.text = [NSString formatIntString:dic[@"countSum"]];
        
        self.myUserList = myUserList;
        self.elseUserList = elseUserList;
        self.currentList = myUserList;
        
        self.headerView.mineUserCount = myUserList.count;
        self.headerView.otherCount = elseUserList.count;
        
        [self reloadData];
    }];
    
    @weakify(self);
    self.headerView.btnClick = ^(NSInteger index) {
        @strongify(self);
        if (index == 0) {
            self.currentList = self.myUserList;
            [self reloadData];
        }else if (index == 1) {
            self.currentList = self.elseUserList;
            [self reloadData];
        }
    };
}


- (void)reloadData{
    [self.tableView reloadData];
    [self.tableView layoutIfNeeded];
    
    if (self.tableView.contentHeight>self.base_navigationbarHeight+184) {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(5);
            make.bottom.mas_equalTo(-15);
        }];
        self.tableView.scrollEnabled = YES;
        self.tableView.clipsToBounds = YES;
    }else {
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.mas_equalTo(self.headerView.mas_bottom).offset(5);
            make.height.mas_equalTo(self.tableView.contentHeight);
        }];
        self.tableView.scrollEnabled = NO;
    }
}


#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.currentList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManManagerModel *model = self.currentList[indexPath.row];
    MineTeamCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineTeamCell"];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{};
@end
