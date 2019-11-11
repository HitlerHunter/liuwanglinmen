//
//  BookViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/15.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

/*
 SUCCESS("01","支付成功"),
 
 PASSCHECK("06","转入退款"),
 
 NOPASSCHECK("00","未支付"),
 
 CLOSE("02","已关闭"),
 
 CANCEL("03","已撤销"),
 
 PAYMENTS("04","支付中"),
 
 FAIL("05","支付失败"),
 
 //是否退款(100:是,101:否,默认值为:101)
 HASREFUND("100", "已退款"),
 
 //是否退款(100:是,101:否,默认值为:101)
 NOTREFUND("101", "未退款");
 */

#import "BookViewController.h"
#import "BookTableViewCell.h"
#import "BookTableViewHeaderView.h"
#import "CTMediator+ModuleBookActions.h"
#import "CTMediator+ModuleMineActions.h"
#import "BookViewModel.h"
#import "BookSectionModel.h"
#import "BookOrdFilterViewController.h"

@interface BookViewController ()<BookOrdFilterDelegate>

@property (nonatomic, strong) BookViewModel *viewModel;
@end

@implementation BookViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"账目";
    [self.view addSubview:self.tableView];
    
    [self configUI];
//    [self configDate];
    
    self.viewModel.tableView = self.tableView;
    [self setTableViewRefreshLoad];
    [self.viewModel refreshData];
    
}

- (void)configUI{
    
    [self.tableView registerClass:[BookTableViewCell class] forCellReuseIdentifier:@"BookTableViewCell"];
    [self.tableView registerClass:[BookTableViewHeaderView class] forHeaderFooterViewReuseIdentifier:@"bookHeader"];
    self.tableView.rowHeight = 68;
    
        //定制左按钮
    UIButton *search = [UIButton buttonWithType:UIButtonTypeCustom];
    search.frame = CGRectMake(0,0, 30, 44);
    
    [search setImage:UIImageName(@"sousuo") forState:UIControlStateNormal];
    search.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);

    search.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [search addTarget:self action:@selector(searchClick)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *searchButton = [[UIBarButtonItem alloc]initWithCustomView:search];
    
    UIButton *filter = [UIButton buttonWithType:UIButtonTypeCustom];
    filter.frame = CGRectMake(0,0, 30, 44);
    
    [filter setImage:UIImageName(@"shaixuan") forState:UIControlStateNormal];
    filter.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    filter.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [filter addTarget:self action:@selector(filterClick)forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem  *filterButton = [[UIBarButtonItem alloc]initWithCustomView:filter];
    self.navigationItem.rightBarButtonItems = @[filterButton,searchButton];
    
}

- (void)configDate{
    
    self.viewModel.beginTime = [self configBeginDate];
    self.viewModel.endTime = [self configEndDate];
}

- (NSString *)configBeginDate{
    NSDate *beginDate = [NSDate date];
    NSString *beginStr = [beginDate formatYMDWithSeparate:@"-"];
    beginStr = [beginStr stringByAppendingString:@" 00:00:00"];
    return beginStr;
}

- (NSString *)configEndDate{
    
    NSDate *endDate = [NSDate date];
    NSString *endStr = [endDate formatYMDWithSeparate:@"-"];
    endStr = [endStr stringByAppendingString:@" 23:59:59"];
    
    return endStr;
}

- (void)setTableViewRefreshLoad{
    WeakSelf(weakSelf);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            //刷新 取默认今日 数据
        [weakSelf configDicData:nil];
//        [weakSelf configDate];
        [weakSelf.viewModel refreshData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf.viewModel loadMoreData];
    }];
}

- (void)searchClick{
    
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Book" bundle:nil] instantiateViewControllerWithIdentifier:@"searchOrderID"];
    PushController(vc);
}

- (void)filterClick{
    BookOrdFilterViewController *filterVC = [[BookOrdFilterViewController alloc] init];
    filterVC.viewModel = self.viewModel;
    filterVC.delegate = self;
    PushController(filterVC);
}

- (void)didFinishSelect:(NSDictionary *)dic{
    
    [self configDicData:dic];
    [self.viewModel refreshData];
}

- (void)configDicData:(NSDictionary *)dic{
    
    self.viewModel.beginTime = dic[@"startTime"];
    self.viewModel.endTime = dic[@"endTime"];
    
    NSString *payWay = dic[@"payWay"];
    if ([payWay isEqualToString:@"微信支付"]) {
        self.viewModel.payWayCode = @"10";
    }else if ([payWay isEqualToString:@"支付宝支付"]){
        self.viewModel.payWayCode = @"20";
    }else{
        self.viewModel.payWayCode = nil;
    }
    
    NSString *payStatus = dic[@"payStatus"];
    NSString *refundStatus = dic[@"refundStatus"];
    
    if ([payStatus isEqualToString:@"收款成功"]) {
        self.viewModel.status = @"01";
    }else if ([payStatus isEqualToString:@"收款失败"]){
        self.viewModel.status = @"05";
    }else if ([payStatus isEqualToString:@"支付中"]){
        self.viewModel.status = @"04";
    }else if ([payStatus isEqualToString:@"转入退款"]){
        self.viewModel.status = @"06";
    }else if ([refundStatus isEqualToString:@"退款成功"]) {//退款
        self.viewModel.status = @"07";
    }else if ([refundStatus isEqualToString:@"退款失败"]){
        self.viewModel.status = @"09";
    }else if ([refundStatus isEqualToString:@"退款中"]){
        self.viewModel.status = @"08";
    }else{
        self.viewModel.status = nil;
    }
    
    
    
    
    self.viewModel.operatorNo = dic[@"operatorId"];
    
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.viewModel.dataArray[section] listOrders] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BookListModel *model = [[self.viewModel.dataArray[indexPath.section] listOrders] objectAtIndex:indexPath.row];
    BookTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookTableViewCell"];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookListModel *model = [[self.viewModel.dataArray[indexPath.section] listOrders] objectAtIndex:indexPath.row];
    if (model.status == IntegralOrderStatusPaying) {
        return;
    }
    
    [[CTMediator sharedInstance] CTMediator_ShowOrdDetailWithOrdID:model.transOrderNo nav:self.navigationController];
    
};

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 41;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    BookSectionModel *model = self.viewModel.dataArray[section];
    
    BookTableViewHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"bookHeader"];
    header.textLabel.font = kfont(14);
    
    NSString *lastTime = @"";
    if (model.createTime.length>10) {
        lastTime = [model.createTime substringToIndex:10];
    }
    header.textLabel.text = lastTime;
//    header.detailTextLabel.text = [NSString stringWithFormat:@"共%ld笔 ￥%.2lf元",model.orderCount,model.totalAmount];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%ld笔  ",model.orderCount]];
    [attStr addAttributes:@{NSFontAttributeName:kfont(14)} range:NSMakeRange(0, attStr.length)];
    
    NSMutableAttributedString *attStr2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"￥%.2lf元",model.totalAmount]];
    [attStr2 addAttributes:@{NSFontAttributeName:kfont(14),NSForegroundColorAttributeName:UIColorHex(0xEF883A)} range:NSMakeRange(0, attStr2.length)];
    
    [attStr appendAttributedString:attStr2];
    
    header.detailTextLabel.attributedText = attStr;
    return header;
}


- (BookViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [BookViewModel new];
    }
    return _viewModel;
}
@end
