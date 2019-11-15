//
//  LZEmptyViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/13.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZEmptyViewController.h"

@interface LZEmptyViewController ()
@property (nonatomic, strong) LZNoDataView *noDataView;
@end

@implementation LZEmptyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView reloadData];
    
   NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"EmptyControllerTitle"];
    if (!IsNull(str)) {
        self.title = str;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.image = UIImageName(@"wujilu");
        _noDataView.message = @"暂无数据";
    }
    return _noDataView;
}
@end
