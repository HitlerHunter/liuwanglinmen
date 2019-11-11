//
//  SYViewController.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/3.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "SYViewController.h"
#import "CashViewController.h"
#import "SYHomeHeader.h"
#import "SYHomeSectionHeader.h"
#import "SYHomeTableViewCell.h"
#import "SYHomeNavBar.h"
#import "SYHomeViewModel.h"
#import "SYHomeListModel.h"

@interface SYViewController ()<SYHomeTypeViewDelegate>

@property (nonatomic, strong) SYHomeHeader *header;
@property (nonatomic, strong) SYHomeNavBar *navBar;
@property (nonatomic, strong) SYHomeViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray *typeArray;
@property (nonatomic, strong) NSMutableArray *typeTitleArray;
@end

@implementation SYViewController

- (BOOL)willAddTap{
    return NO;
}

- (BOOL)hiddenNavgationBar{
    return YES;
}

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
    
    [self requestHeaderData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的收益";
    
    [self.view addSubview:self.tableView];
    self.header = [SYHomeHeader xibView];
    self.header.frame = CGRectMake(0, 0, kScreenWidth, 250+self.base_navigationbarHeight);
    self.header.delegate = self;
 
    self.tableView.rowHeight = 94;
    self.tableView.tableHeaderView = self.header;
    [self.tableView registerNib:[UINib nibWithNibName:@"SYHomeTableViewCell" bundle:nil] forCellReuseIdentifier:@"SYHomeTableViewCell"];
    
    @weakify(self);
    self.header.toCashBlock = ^{
        @strongify(self);
        [self toCash];
    };
    
    [self.view addSubview:self.navBar];
    
    
    [SYHomeViewModel getTypeList:^(id  _Nullable obj) {
        NSArray *dicArray = obj;
        
        self.typeArray = [NSMutableArray array];
        self.typeTitleArray = [NSMutableArray array];
        [self.typeTitleArray addObject:@"全部"];
        [self.typeArray addObject:@""];
        
        for (NSDictionary *dic in dicArray) {
            [self.typeArray addObject:dic[@"typeId"]];
            [self.typeTitleArray addObject:dic[@"typeName"]];
        }
        
        [self.viewModel refreshData];
        
        [self.header setTitleArray:self.typeTitleArray];
    }];
    
    self.viewModel.tableView = self.tableView;
    
//    [self.header setTitleArray:@[@"全部",@"升级分润",@"无卡分润",@"悬赏分润",@"营销分润"]];
 
    
}


- (void)requestHeaderData{
    [SVProgressHUD show];
    ZZNetWorker.GET.zz_url(@"/view-biz/profitDetailView/sum")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        [SVProgressHUD dismiss];
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            NSString *todayProfit = model_net.data[@"todayProfit"];
            NSString *yesterdayProfit = model_net.data[@"yesterdayProfit"];
            NSString *totalProfit = model_net.data[@"totalProfit"];
            NSString *withdrawalBalance = model_net.data[@"withdrawalBalance"];
            
            CurrentUserWallet.balance = withdrawalBalance;
            
            self.header.canCashMoneyLabel.text = [NSString formatMoneyCentToYuanString:withdrawalBalance];
            self.header.todayLabel.text = [NSString formatMoneyCentToYuanString:todayProfit];
            self.header.moneyAllLabel.text = [NSString formatMoneyCentToYuanString:totalProfit];
            self.header.lastDayLabel.text = [NSString formatMoneyCentToYuanString:yesterdayProfit];
            self.header.allMoney = self.header.moneyAllLabel.text;
        }
        
    });
}

//提现
- (void)toCash{
    
    NewClass(vc, CashViewController);
    PushIdController(vc, LinearBackId_Cash);
}

//type回调
- (void)view:(SYHomeTypeView *)view clickBtnAtIndex:(NSInteger)index{
    if (index == 0) {
        self.viewModel.type = nil;
    }else{
        self.viewModel.type = _typeArray[index];
    }
    
    [self.viewModel refreshData];
};


- (SYHomeNavBar *)navBar{
    if (!_navBar) {
        _navBar = [[SYHomeNavBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, LZApp.shareInstance.app_navigationBarHeight)];
    }
    return _navBar;
}

- (SYHomeViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [SYHomeViewModel new];
    }
    return _viewModel;
}
#pragma mark - method
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        CGFloat alpha = 1- (64 - offsetY) / 64;
        self.navBar.progress = alpha;
    } else {
        self.navBar.progress = 0;
    }
    
    if (offsetY>64) {
        scrollView.bounces = YES;
    }else{
        scrollView.bounces = NO;
    }
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
    SYHomeListModel *model = self.viewModel.dataArray[indexPath.row];
    SYHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SYHomeTableViewCell"];
    
    cell.model = model;
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 32;
//}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    SYHomeSectionHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
//    if (!header) {
//        header = [[SYHomeSectionHeader alloc] initWithReuseIdentifier:@"header"];
//    }
//    header.titleLabel.text = @"本月";
//    header.rightLabel.text = @"3000元";
//
//    return header;
//}

@end
