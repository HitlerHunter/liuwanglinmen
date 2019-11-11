//
//  CouponDetailViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponDetailViewController.h"
#import "VipManagerMenuView.h"
#import "CouponDetailTableViewCell.h"
#import "CouponVipModel.h"
#import "CouponDetailViewModel.h"
#import "CouponModel.h"
#import "CouponDetailTopView.h"
#import "CouponViewModel.h"
#import "CouponSendRecordController.h"

@interface CouponDetailViewController ()<VipManagerMenuDelegate,LDActionSheetDelegate>
@property (nonatomic, strong) LZNoDataView *noDataView;
@property (nonatomic, strong) CouponModel *model;
@property (nonatomic, strong) CouponDetailTopView *topView;
@property (nonatomic, strong) VipManagerMenuView *menuView;
@property (nonatomic, strong) CouponDetailViewModel *viewModel;
@end

@implementation CouponDetailViewController

- (instancetype)initWithModel:(CouponModel *)model{
    self =[super init];
    if (self) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = _model.couponName;
    
    //topView
    _topView = [[CouponDetailTopView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90)];
    
    _menuView = [[VipManagerMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 35)];
    _menuView.delegate = self;
    
    //menu
    VipManagerMenuModel *menu1 = [VipManagerMenuModel initWithTitle:@"会员信息" status:VipManagerMenuStatusUnableStatus];
    VipManagerMenuModel *menu2 = [VipManagerMenuModel initWithTitle:@"领取时间" status:VipManagerMenuStatusNoSelected];
    VipManagerMenuModel *menu3 = [VipManagerMenuModel initWithTitle:@"核销时间" status:VipManagerMenuStatusNoSelected];
    [_menuView initUIWithMenuModelArray:@[menu1,menu2,menu3]];

    self.tableView.tableHeaderView = _topView;
    [self.view addSubview:self.tableView];
    self.tableView.rowHeight = 60;
    [self.tableView registerClass:[CouponDetailTableViewCell class] forCellReuseIdentifier:@"CouponDetailTableViewCell"];
    
    @weakify(self);
    [self addRightItemWithImage:nil title:@"更多" font:nil color:nil block:^{
        @strongify(self);
        [self showMoreChoice];
    }];
    
    //数据
    _viewModel = [CouponDetailViewModel new];
    _viewModel.couponId = self.model.Id;
    _viewModel.sortBy = @"1";
    _viewModel.orderBy = @"2";
    _viewModel.tableView = self.tableView;
    
    [self.viewModel getDetailTopData];
    [RACObserve(self.viewModel, verifySum) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        self.topView.hasUsedNumber = self.viewModel.verifySum;
        self.topView.hasReceivedNumber = self.viewModel.distributedSum;
    }];
    
        //默认
    [_menuView setSelectedAtIndex:1];
}

#pragma mark - 更多
- (void)showMoreChoice{
    
    LDActionSheet *sheet;
    
    if (self.model.couponStatus.integerValue == 1) {
        //上架
        sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"上架",@"删除优惠券", nil];
    }else if (self.model.couponStatus.integerValue == 2) {
            //下架
        sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"下架",@"删除优惠券", nil];
    }else{
        sheet = [[LDActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"删除优惠券", nil];
    }
    
    
    [sheet showInView:KeyWindow];
    
}

- (void)actionSheet:(LDActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (self.model.couponStatus.integerValue == 1) {
            //上架
        if (buttonIndex == 0) {
            [self showUpDown:YES];
        }else if (buttonIndex == 1) {
            [self showRemove];
        }else if (buttonIndex == 2) {
            CouponSendRecordController *record = [[CouponSendRecordController alloc] initWithModel:self.model];
            PushController(record);
        }
    }else if (self.model.couponStatus.integerValue == 2) {
            //下架
        if (buttonIndex == 0) {
            [self showUpDown:NO];
        }else if (buttonIndex == 2) {
            CouponSendRecordController *record = [[CouponSendRecordController alloc] initWithModel:self.model];
            PushController(record);
        }else if (buttonIndex == 1) {
            [self showRemove];
        }
    }else{
        if (buttonIndex == 1) {
            
            CouponSendRecordController *record = [[CouponSendRecordController alloc] initWithModel:self.model];
            PushController(record);
        }else if (buttonIndex == 0) {
            [self showRemove];
        }
    }
}

- (void)showRemove{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"删除优惠券" message:@"是否删除优惠券?" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *remove = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CouponViewModel removeCouponWithCouponModel:self.model block:^(id  _Nullable obj, NSString * _Nullable msg, BOOL success) {
            if (success) {
                [[NSNotificationCenter defaultCenter] postNotificationName:CouponSendRecordNeedRefreshNotificationName object:nil];
                [self lz_popController];
            }else{
                [self showMessage:msg];
            }
        }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:remove];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)showUpDown:(BOOL)isUp{
    
    NSString *title = @"下架";
    NSString *message = @"是否下架优惠券?";
    
    if (isUp) {
        title = @"上架";
        message = @"是否上架优惠券?";
    }
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *remove = [UIAlertAction actionWithTitle:title style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CouponViewModel upDownCouponWithCouponModel:self.model block:^(id  _Nullable obj, NSString * _Nullable msg, BOOL success) {
            if (success) {
                [[NSNotificationCenter defaultCenter] postNotificationName:CouponSendRecordNeedRefreshNotificationName object:nil];
                [self lz_popController];
            }else{
                [self showMessage:msg];
            }
        }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:remove];
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - VipManagerMenuDelegate
- (void)VipManagerMenuDidSelectedWithTitle:(NSString *)title status:(VipManagerMenuStatus)status{
    
    _viewModel.orderBy = nil;
    _viewModel.sortBy = nil;
    
    id sortType = @"0";
    if (status == VipManagerMenuStatusUp) {
        sortType = @"1";
    }else if (status == VipManagerMenuStatusDown) {
        sortType = @"2";
    }else if (status == VipManagerMenuStatusNoSelected) {
        sortType = nil;
    }
    
    _viewModel.orderBy = sortType;
    
    if ([title isEqualToString:@"领取时间"]) {
        _viewModel.sortBy = @"1";
    }else if ([title isEqualToString:@"核销时间"]) {
        _viewModel.sortBy = @"2";
    }
    
    [self.viewModel refreshData];
}

#pragma mark - tableView Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.viewModel.dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.viewModel.dataArray.count>0?1:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponVipModel *model = self.viewModel.dataArray[indexPath.row];
    CouponDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponDetailTableViewCell"];
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
};

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return _menuView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return _menuView.height;
}

#pragma mark - TableView 占位图
- (UIView   *)xy_noDataView{
    return self.noDataView;
}

- (LZNoDataView *)noDataView{
    if (!_noDataView) {
        _noDataView = [[LZNoDataView alloc] initWithFrame:self.tableView.frame];
        _noDataView.image = UIImageName(@"coupon_detail_empyt");
        _noDataView.message = @"暂无数据~";
    }
    return _noDataView;
}
@end
