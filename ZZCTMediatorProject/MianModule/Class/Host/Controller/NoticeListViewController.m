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
#import "MineMessageDetailViewController.h"

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
    return NO;
}
- (BOOL)hasHiddenTabBar{
    return YES;
}

- (void)clearDatas{
    [self.viewModel.dataArray removeAllObjects];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[NoticeTableViewCell class] forCellReuseIdentifier:@"NoticeTableViewCell"];
    self.tableView.rowHeight = 75;
    self.tableView.height -= 40;
    self.tableView.top = 0;
    self.viewModel.tableView = self.tableView;
    
    if (self.viewModel.type.intValue == 1) {
        UILongPressGestureRecognizer *longpress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(pressAction:)];
        [self.tableView addGestureRecognizer:longpress];
        
    }
    
    [self.viewModel refreshData];
    
}


- (NoticeListViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [NoticeListViewModel new];
        _viewModel.userNo = CurrentUser.usrNo;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoticeModel *model = self.viewModel.dataArray[indexPath.row];
    if (model.isClick.intValue == 1) {
        //消息详情
        MineMessageDetailViewController *detail = [[MineMessageDetailViewController alloc] initWithModel:model];
        PushController(detail);
    }
}

- (void)pressAction:(UILongPressGestureRecognizer *)longPressGesture
{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {//手势开始
        CGPoint point = [longPressGesture locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point]; // 可以获取我们在哪个cell上长按
        NSLog(@"%ld",indexPath.row);
        NoticeModel *model = self.viewModel.dataArray[indexPath.row];
        [self removeNotice:model indexPath:indexPath];
    }
    if (longPressGesture.state == UIGestureRecognizerStateEnded)//手势结束
    {
        
        
    }
}

- (void)removeNotice:(NoticeModel *)model indexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否删除消息？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"清空" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NoticeListViewModel removeNoticeWithNoticeId:model.nid block:^(BOOL isSuccess) {
            if (isSuccess) {
                [self.viewModel.dataArray removeObject:model];
                 [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            }
        }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
