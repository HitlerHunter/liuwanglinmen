//
//  MineAddressViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineAddressViewController.h"
#import "MineAddressCell.h"
#import "CreatMineAddressViewController.h"
#import "MineAddressViewModel.h"

@interface MineAddressViewController ()
@property (nonatomic, strong) LZNoDataView *noDataView;

@end

@implementation MineAddressViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [MineAddressViewModel getAddressListWithBlock:^(id  _Nullable obj) {
        if (obj) {
            self.dataArray = obj;
            [self.tableView reloadData];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"收货地址";
    
    self.tableView.height -= 44;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 88;
    [self.tableView registerClass:[MineAddressCell class] forCellReuseIdentifier:@"MineAddressCell"];
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"添加新地址" textColor:LZWhiteColor];
    [self.view addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(44);
    }];
    [btn setDefaultGradient];
    
    [btn addTarget:self action:@selector(toAdd) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)toAdd{
    CreatMineAddressViewController *vc = [CreatMineAddressViewController new];
    PushController(vc);
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddressCell"];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_didSelectBlock) {
        _didSelectBlock(self.dataArray[indexPath.row]);
        PopController;
    }
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.image = UIImageName(@"mineAddress_none");
        _noDataView.message = @"暂无收货地址~";
    }
    return _noDataView;
}
@end
