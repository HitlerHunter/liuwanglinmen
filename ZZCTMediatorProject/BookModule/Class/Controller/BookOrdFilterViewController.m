//
//  BookOrdFilterViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/17.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookOrdFilterViewController.h"
#import "BookOrdFilterCell.h"
#import "FilterTimeTableViewCell.h"
#import "FilterCellModel.h"
#import "FilterModel.h"
#import "BookViewModel.h"
#import "OperatorManModel.h"
#import "CTMediator+ModuleMineActions.h"

@interface BookOrdFilterViewController ()
@property (nonatomic, strong) NSArray *filterTextArray;
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSMutableArray *manNameArray;
@end

@implementation BookOrdFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"筛选";
    [self configUI];
    
    //
    _filterTextArray = @[@[@"微信支付",@"支付宝支付"],@[@"收款成功",@"收款失败",@"支付中",],@[@"退款成功",@"退款失败",@"退款中"],@[],self.manNameArray];
    
    
    _titleArray = @[@"支付方式",@"支付状态",@"退款状态",@"交易时间"];
    
    [self getModels];
    
    self.view.backgroundColor = LZBackgroundColor;
    [self.view bringSubviewToFront:self.bottomView];
    
    
}

- (void)requestData{
    
    if (self.viewModel.operatorManArray.count) {
        for (OperatorManModel *model in self.viewModel.operatorManArray) {
            [self.manNameArray addObject:model.name?model.name:@""];
        }
        return;
    }
    
    
    [SVProgressHUD show];
    @weakify(self);
    [[CTMediator sharedInstance] CTMediator_getOperatorMansWithBlock:^(NSArray *datas) {
        [SVProgressHUD dismiss];
        @strongify(self);
        if (datas) {
            
            [self.viewModel.operatorManArray addObjectsFromArray:datas];
            
            if (CurrentUser.sysUser.lzUserType == LZUserTypeMerchant) {
                
                //boss放第一个
                [self.viewModel.operatorManArray sortUsingComparator:^NSComparisonResult(OperatorManModel * _Nonnull obj1, OperatorManModel *  _Nonnull obj2) {
                    if ([obj2.userId isEqualToString:CurrentUser.usrNo]) {
                        return NSOrderedAscending;
                    }
                    return NSOrderedDescending;
                }];
            }
            
            for (OperatorManModel *model in self.viewModel.operatorManArray) {
                [self.manNameArray addSafeObject:model.name];
            }
            if (self.dataArray.count >= 5) {
                FilterCellModel *model = self.dataArray[4];
                model.filterModelArray = nil;
                [self.tableView reloadData];
            }
        }
    }];
    
}

- (void)getModels{
    
    for (int i = 0; i < _titleArray.count; i++) {
        NSArray *arr = _filterTextArray[i];
        FilterCellModel *model = [FilterCellModel new];
        if (i == 4) {
            model.canShowMore = YES;
        }
        model.filterTextArray = arr;
        [self.dataArray addObject:model];
    }
    
}

- (void)configUI{
    self.tableView.height = self.tableView.height - 50;
    [self.tableView registerClass:[BookOrdFilterCell class] forCellReuseIdentifier:@"BookOrdFilterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"FilterTimeTableViewCell" bundle:nil] forCellReuseIdentifier:@"FilterTimeTableViewCell"];
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    
    self.bottomView = [UIView new];
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithFontSize:16 text:@"重置" textColor:rgb(53,53,53)];
    UIButton *rightBtn = [UIButton buttonWithFontSize:16 text:@"确定" textColor:LZWhiteColor];
    
    leftBtn.backgroundColor = LZWhiteColor;
    rightBtn.backgroundColor = LZOrangeColor;
    
    [self.bottomView addSubview:leftBtn];
    [self.bottomView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.left.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(rightBtn);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.top.right.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(leftBtn);
        make.left.mas_equalTo(leftBtn.mas_right);
    }];
    
    [leftBtn addTarget:self action:@selector(clearAll) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(makeSure) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)clearAll{
    [[NSNotificationCenter defaultCenter] postNotificationName:FilterClearAllNotificationName object:nil];
}

- (void)makeSure{
    
    FilterCellModel *model1 = self.dataArray[0];
    FilterCellModel *model2 = self.dataArray[1];
    FilterCellModel *model3 = self.dataArray[2];
    
    FilterTimeTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:3]];
    SDLog(@"\n%@\n%@",cell.start,cell.end);
    
    SDLog(@"\n%@\n%@\n%@\n",
          model1.seletedModel.title,
          model2.seletedModel.title,
          model3.seletedModel.title);
    
    NSString *operatorId = nil;
    if (self.dataArray.count >= 5) {
        FilterCellModel *model4 = self.dataArray[4];
        
        if (model4.seletedModel) {
            operatorId = [self.viewModel.operatorManArray[model4.selectedIndex] userId];
        }
        
        SDLog(@"%@",model4.seletedModel.title);
    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setSafeObject:model1.seletedModel.title forKey:@"payWay"];
    [dic setSafeObject:model2.seletedModel.title forKey:@"payStatus"];
    [dic setSafeObject:model3.seletedModel.title forKey:@"refundStatus"];
    
    [dic setSafeObject:operatorId forKey:@"operatorId"];
    [dic setSafeObject:cell.start forKey:@"startTime"];
    [dic setSafeObject:cell.end forKey:@"endTime"];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didFinishSelect:)]) {
        [_delegate didFinishSelect:dic];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 3) {
        FilterTimeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FilterTimeTableViewCell"];
        
        return cell;
    }
    
    FilterCellModel *model = self.dataArray[indexPath.section];
    BookOrdFilterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookOrdFilterCell"];
    cell.model = model;
    if (indexPath.section == 4) {
        @weakify(self);
        cell.showBlock = ^{
            @strongify(self);
            [self.tableView reloadData];
        };
    }
    
    if (indexPath.section == 1) {
        @weakify(self);
        cell.clickBlock = ^{
            @strongify(self);
            FilterCellModel *model = self.dataArray[2];
            model.seletedModel.isSelected = NO;
            model.seletedModel = nil;
        };
    }
    
    if (indexPath.section == 2) {
        @weakify(self);
        cell.clickBlock = ^{
            @strongify(self);
            FilterCellModel *model = self.dataArray[1];
            model.seletedModel.isSelected = NO;
            model.seletedModel = nil;
        };
    }
    
    cell.titleLab.text = _titleArray[indexPath.section];
    //最关键的一步,解决不正常显示问题
    [cell layoutIfNeeded];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 3) {
        return 141;
    }
    
    FilterCellModel *model = self.dataArray[indexPath.section];
    return model.cellHeight != -1?model.cellHeight:UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = LZBackgroundColor;
    return view;
}

- (NSMutableArray *)manNameArray{
    if (!_manNameArray) {
        _manNameArray = [NSMutableArray array];
    }
    return _manNameArray;
}
@end
