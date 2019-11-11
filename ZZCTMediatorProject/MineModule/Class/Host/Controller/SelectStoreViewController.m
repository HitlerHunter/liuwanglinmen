//
//  SelectStoreViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/18.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SelectStoreViewController.h"
#import "StoreSelectCell.h"

@interface SelectStoreViewController ()
@property (nonatomic, strong) UIView *bgView;
@end

@implementation SelectStoreViewController

- (BOOL)hasHiddenTabBar{
    return YES;
}

- (instancetype)initWithDataArray:(NSArray *)dataArray{
    self = [super init];
    if (self) {
        self.dataArray = (NSMutableArray *)dataArray;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor clearColor];
    UIView *bgView = [[UIView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [self.view addSubview:bgView];
    _bgView = bgView;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancel)];
    [bgView addGestureRecognizer:tap];
    
    [self.tableView registerClass:[StoreSelectCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 50;
    
    CGFloat maxHeight = kScreenHeight - LZApp.shareInstance.app_navigationBarHeight;
    CGFloat cellHeight = 50*self.dataArray.count;
    
    if (cellHeight>maxHeight) {
        cellHeight = maxHeight;
    }
    
    self.tableView.height = cellHeight;
    self.tableView.bottom = kScreenHeight;
}

- (void)cancel{
    [self dismiss];
}

- (void)dismiss{
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.2;
        self.tableView.top = kScreenHeight;
    } completion:^(BOOL finished) {
        dispatch_main_async_safe(^{
            [self dismissViewControllerAnimated:NO completion:nil];
        });
    }];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
//    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    StoreSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    id obj = self.dataArray[indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        cell.textLabel.text = self.dataArray[indexPath.row];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.block) {
        self.block(indexPath.row, self.dataArray[indexPath.row]);
    }
    
    [self dismiss];
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
@end
