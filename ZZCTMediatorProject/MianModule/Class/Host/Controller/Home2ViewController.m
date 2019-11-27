//
//  Home2ViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "Home2ViewController.h"
#import "Home2HeaderView.h"
#import "MineMessageDetailViewController.h"

#import "HomeNewsCell.h"
#import "BossStudyViewModel.h"
#import "BossStudyModel.h"
#import "BossStudyViewController.h"
#import "MianSectionHeader.h"
#import "MainStudyCell.h"

#import "IPAddressHelper.h"
#import "GoodsDetailViewController.h"

@interface Home2ViewController ()
@property (nonatomic, strong) Home2HeaderView *headerView;
@property (nonatomic, strong) BossStudyViewModel *viewModel;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation Home2ViewController

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITabBarController *tabbar = (UITabBarController *)KeyWindow.rootViewController;
    if ([tabbar isKindOfClass:[UITabBarController class]]) {
        if (tabbar.selectedViewController != self.navigationController) {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    
    [self.headerView getTodayData];
    
    
}

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titleArray = @[@"精选课堂",@"精选推荐"];
    
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomeNewsCell" bundle:nil] forCellReuseIdentifier:@"HomeNewsCell"];
    [self.tableView registerClass:[MainStudyCell class] forCellReuseIdentifier:@"MainStudyCell"];
    
    @weakify(self);
    [AppMessage getHomePresentNoticeWithBlock:^(NoticeModel * _Nonnull message) {
        @strongify(self);
        if (message) {
            [self showAppMessage:message];
        }
    }];
    
    [self getAppKefuInfo];
    
        //激活推送
    CurrentUser.isOpenAppNotification = CurrentUser.isOpenAppNotification;
    
    [self.viewModel refreshData];
    
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

#pragma mark - 处理推送消息
- (void)handleNotice{
    if (AppMessage.shareInstance.noticeParams) {
        
        NoticeModel *message = [NoticeModel mj_objectWithKeyValues:AppMessage.shareInstance.noticeParams];
        if (message) {
                //消息详情
            MineMessageDetailViewController *detail = [[MineMessageDetailViewController alloc] initWithModel:message];
            PushController(detail);
            
            AppMessage.shareInstance.noticeParams = nil;
        }
    }
}

#pragma mark - 通知弹窗
- (void)showAppMessage:(NoticeModel *)message{
    
    if (message.content != nil && message.content.length > 0) {
        NSString *messageStr = [NSString stringWithFormat:@"\n%@",message.content];
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:message.title message:messageStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *act = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        }];
        [alertVC addAction:act];
        [self presentViewController:alertVC animated:YES completion:nil];
    }
}

#pragma mark - 客服信息
- (void)getAppKefuInfo{
    
    ZZNetWorker.GET.zz_param(@{})
    .zz_url(@"/outside-biz/consumerService/6w")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSDictionary *kefuDic = model_net.data;
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"mobile"] forKey:@"kefuPhone"];
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"startTime"] forKey:@"kefuStartTime"];
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"endTime"] forKey:@"kefuEndTime"];
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"url"] forKey:@"kefu_weixinCode"];
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"author"] forKey:@"kefu_weixinNumber"];
            
        }
    });
}

- (Home2HeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[Home2HeaderView alloc] init];
    }
    return _headerView;
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.viewModel.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 175;
    }
    return 121;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        MainStudyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MainStudyCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
    }
    
    BossStudyModel *model = self.viewModel.dataArray[indexPath.row];
    HomeNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeNewsCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.titleLab.text = model.title;
    cell.readNumberLabel.text = @"";
    cell.timeLabel.text = model.showTime;
    
    [cell.imgView sd_setImageWithURL:TLURL(model.picture)];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BossStudyModel *model = self.viewModel.dataArray[indexPath.row];
//    [AppCenter openURL:model.jumpUrl];
    
    GoodsDetailViewController *vc = [GoodsDetailViewController new];
    PushController(vc);
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    MianSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (!header) {
        header = [[MianSectionHeader alloc] initWithReuseIdentifier:@"header"];
    }
    header.titleLabel.text = _titleArray[section];
    header.moreIcon.hidden = YES;
    header.rightLabel.hidden = YES;
//    if (section == 0) {
//        header.moreIcon.hidden = NO;
//        header.rightLabel.hidden = NO;
//        @weakify(self);
//        header.clickBlock = ^{
//            @strongify(self);
//                //财商课堂
//            NewClass(vc, BossStudyViewController);
//            PushController(vc);
//        };
//    }else {
//        header.moreIcon.hidden = YES;
//        header.rightLabel.hidden = YES;
//    }
    return header;
}


- (BossStudyViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [BossStudyViewModel new];
    }
    return _viewModel;
}
@end
