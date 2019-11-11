//
//  CouponVipChoiceController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponVipChoiceController.h"
#import "CouponModel.h"
#import "CouponVipModel.h"
#import "CouponVipViewModel.h"
#import "CouponVipCell.h"
#import "CouponVipSectionHeaderView.h"
#import "CounponVipSearchBarView.h"
#import "CouponSendResultController.h"
#import "CouponViewModel.h"

@interface CouponVipChoiceController ()
@property (nonatomic, strong) CouponModel *model;
@property (nonatomic, strong) CouponVipViewModel *viewModel;
@property (nonatomic, strong) CounponVipSearchBarView *searchBar;
@property (nonatomic, strong) LZNoDataView *noDataView;

@property (nonatomic, strong) UIButton *chioceAllBtn;
@property (nonatomic, strong) UIButton *makeSureBtn;
@property (nonatomic, strong) UILabel *label_selectCount;
/**是否全选所有的vip*/
@property (nonatomic, assign) BOOL hasSelectedAll;
@end

@implementation CouponVipChoiceController

- (instancetype)initWithModel:(CouponModel *)model{
    self =[super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"选择会员";
    
    _searchBar = [[CounponVipSearchBarView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 70)];
    self.tableView.tableHeaderView = _searchBar;
    
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 65;
    
    [self.tableView registerClass:[CouponVipCell class] forCellReuseIdentifier:@"CouponVipCell"];
    [self.tableView registerClass:[CouponVipSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"CouponVipSectionHeaderView"];
    
    @weakify(self);
    [self.viewModel getAllVipWithBlock:^(BOOL success) {
        @strongify(self);
        if (success) {
            [self.searchBar setVipNumber:[self getCurrentAllVipCount] couponNumber:self.model.canUseCouponNum];
            [self.tableView reloadData];
        }
    }];
    
    _searchBar.didReturnBlock = ^(NSString * _Nonnull str) {
        @strongify(self);
        if (str.length == 0) {//展示所有的vip数据
            self.viewModel.searchStr = @"";
            [self.searchBar setVipNumber:[self getCurrentAllVipCount] couponNumber:self.model.canUseCouponNum];
            [self.tableView reloadData];
        }else {//搜索
            self.viewModel.searchStr = str;
            [self.viewModel searchVipWithBlock:^(BOOL success) {
                if (success) {
                    [self.searchBar setVipNumber:[self getCurrentAllVipCount] couponNumber:self.model.canUseCouponNum];
                    [self.tableView reloadData];
                }
            }];
        }
    };
    
    [self addBottomView];
    
}

- (void)addBottomView{
    UIView *bottomView = [UIView new];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    leftBtn.backgroundColor = LZWhiteColor;
    [leftBtn setImage:UIImageName(@"board_unSelected") forState:UIControlStateNormal];
    [leftBtn setImage:UIImageName(@"board_selected") forState:UIControlStateSelected];
    [leftBtn setTitle:@"全选" forState:UIControlStateNormal];
    [leftBtn setTitleColor:rgb(53,53,53) forState:UIControlStateNormal];
    
    [bottomView addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(bottomView);
        make.width.mas_equalTo(kScreenWidth*0.5);
    }];
    
    UIButton *rightBtn = [UIButton buttonWithFontSize:15 text:@"确定" textColor:LZWhiteColor];
    [bottomView addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.mas_equalTo(bottomView);
        make.width.mas_equalTo(leftBtn);
    }];
    [rightBtn setDefaultGradient];
    
    _chioceAllBtn = leftBtn;
    _makeSureBtn = rightBtn;
    
    [leftBtn addTarget:self action:@selector(chioceAllVip) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn addTarget:self action:@selector(makeSureMethod) forControlEvents:UIControlEventTouchUpInside];
    
    //监听全选或全不选 改变全选按钮的状态
    @weakify(self);
    [RACObserve(self, hasSelectedAll) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.chioceAllBtn.selected = self.hasSelectedAll;
    }];
    
    UILabel *label_selectCount = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(255,81,0) textAlignment:NSTextAlignmentCenter];
    [self.view addSubview:label_selectCount];
    [label_selectCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(bottomView.mas_top).offset(-10);
        make.centerX.mas_equalTo(bottomView);
    }];
    _label_selectCount = label_selectCount;
}

#pragma mark -- choice method --
- (void)chioceAllVip{
    self.hasSelectedAll = !_hasSelectedAll;
    
    //全选或全取消
    [[self currentDataArray] enumerateObjectsUsingBlock:^(CouponVipSectionModel *  _Nonnull sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [sectionModel selectAllOrNot:self.hasSelectedAll];
    }];
    
    [self.tableView reloadData];
    [self showSelectVipCount];
}

//检查是否全选
- (void)checkHasSelectAll{
    
    __block BOOL isAllSelected = YES;
    [[self currentDataArray] enumerateObjectsUsingBlock:^(CouponVipSectionModel  *sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!sectionModel.isSelected) {
            isAllSelected = NO;
            *stop = YES;
        }
    }];
    
    self.hasSelectedAll = isAllSelected;
}

//展示 选中的vip数量
- (void)showSelectVipCount{

    NSInteger count = [self getSelectVipCount];
    _label_selectCount.hidden = count==0?YES:NO;
    _label_selectCount.text = [NSString stringWithFormat:@"已选择%ld位会员",count];
}

- (NSInteger)getCurrentAllVipCount{
    NSInteger count = 0;
    for (CouponVipSectionModel *sectionModel in [self currentDataArray]) {
        count += sectionModel.vipArray.count;
    }
    
    return count;
}

//计算 选中的vip数量
- (NSInteger)getSelectVipCount{
    NSInteger count = 0;
    for (CouponVipSectionModel *sectionModel in [self currentDataArray]) {
        count += sectionModel.didSelectCount;
    }
    
    return count;
}

//获取 选中的vip的userId
- (NSArray *)getSelectedVipArray{
    
    NSMutableArray *array = [NSMutableArray array];
    for (CouponVipSectionModel *sectionModel in [self currentDataArray]) {
        for (CouponVipModel *vip in sectionModel.vipArray) {
            if (vip.isSelected) {
                
                NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                [dic setSafeObject:vip.avatar forKey:@"avatar"];
                [dic setSafeObject:vip.nickName forKey:@"nickName"];
                [dic setSafeObject:vip.phone forKey:@"phone"];
                [dic setSafeObject:vip.tagsName forKey:@"tagsName"];
                [dic setSafeObject:vip.userId forKey:@"userId"];
                
                [array addObject:dic];
            }
        }
    }
    
    return array;
}


#pragma mark -- 提交发布 --
- (void)makeSureMethod{
    
    [CouponViewModel publishCouponWithCouponModel:self.model userIdArray:[self getSelectedVipArray] block:^(id  _Nullable obj, NSString * _Nullable msg, BOOL success) {
        if (success) {
            CouponSendResultController *vc = [[CouponSendResultController alloc] initWithSendCount:[obj integerValue]];
            PushIdController(vc, LinearBackId_AuthenLine);
        }else{
            [self showMessage:msg];
        }
    }];
    
    
}


#pragma mark -- --
- (CouponVipViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [CouponVipViewModel new];
    }
    return _viewModel;
}

//当前展示的数据
- (NSArray *)currentDataArray{
    if (self.viewModel.searchStr.length > 0) {
        return self.viewModel.searchDataArray;
    }else{
        return self.viewModel.dataArray;
    }
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    CouponVipSectionModel *sectionModel = [self currentDataArray][section];
    if (!sectionModel.isShow) {
        return 0;
    }
    return sectionModel.vipArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self currentDataArray].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponVipSectionModel *sectionModel = [self currentDataArray][indexPath.section];
    CouponVipModel *model = sectionModel.vipArray[indexPath.row];
    
    CouponVipCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponVipCell"];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponVipSectionModel *sectionModel = [self currentDataArray][indexPath.section];
    CouponVipModel *model = sectionModel.vipArray[indexPath.row];
    
    model.isSelected = !model.isSelected;
    if (model.isSelected) {
        //检查是否全选
        [sectionModel checkSelect];
    }else{
        //没有全选
        sectionModel.isSelected = NO;
    }
    
    [self showSelectVipCount];
};

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //section header
    CouponVipSectionModel *sectionModel = [self currentDataArray][section];
    
    CouponVipSectionHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"CouponVipSectionHeaderView"];
    header.model = sectionModel;
    
    //组 选中或取消
    @weakify(self);
    header.didChangeChoiceBlock = ^(CouponVipSectionModel * _Nonnull sectionModel) {
        @strongify(self);
        [sectionModel selectAllOrNot:!sectionModel.isSelected];
        sectionModel.isSelected = sectionModel.isSelected;
        [self showSelectVipCount];
    };
    
    //收起，展开
    [[RACObserve(sectionModel, isShow) takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        [UIView performWithoutAnimation:^{
            NSIndexSet *reloadSet = [NSIndexSet indexSetWithIndex:section];
            [self.tableView reloadSections:reloadSet withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    }];
    
    //监听选中状态
    [[RACObserve(sectionModel, isSelected) takeUntil:header.rac_prepareForReuseSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (sectionModel.isSelected) {
            [self checkHasSelectAll];
        }else{
            self.hasSelectedAll = NO;
        }
        
    }];
    
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}

#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (BOOL)xy_needSectionHasData{
    return YES;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.image = UIImageName(@"coupon_detail_empyt");
        _noDataView.message = @"暂无会员";
    }
    return _noDataView;
}
@end
