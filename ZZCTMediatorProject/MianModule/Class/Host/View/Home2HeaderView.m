//
//  Home2HeaderView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "Home2HeaderView.h"

#import "SKMManagerViewController.h"
#import "MineMessageDetailViewController.h"
#import "MarketMessageViewController.h"
#import "VipManagerViewController.h"

#import "HomeToolsView.h"
#import "HomeTopToolView.h"
#import "HomeTodayDataView.h"
#import "SGAdvertScrollView.h"

#import "CTMediator+ModuleScanActions.h"
#import "CTMediator+ModuleMainActions.h"
#import "CTMediator+CTMediatorModuleLoginActions.h"
#import "CTMediator+ModuleMineActions.h"
#import "CTMediator+ModuleBookActions.h"

#import <SDCycleScrollView.h>
#import "AdvertManager.h"
#import "RewardViewModel.h"

@interface Home2HeaderView ()<HomeToolsViewDelegate,SGAdvertScrollViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) SGAdvertScrollView *noticeView;
@property (nonatomic, strong) HomeTopToolView *topToolView;
@property (nonatomic, strong) HomeTodayDataView *todayView;
@property (nonatomic, strong) HomeToolsView *toolsView2;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView2;
@property (nonatomic, strong) NSArray <AdvertModel *>*advertArray;
@property (nonatomic, strong) NSArray <AdvertModel *>*advertArray2;

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *userInfoView;
@end

@implementation Home2HeaderView

- (void)initUI{
    self.backgroundColor = LZBackgroundColor;
    
    [self addHeader];
    [self addSubview:self.cycleScrollView];
    [self addSubview:self.noticeView];
    [self addSubview:self.todayView];
    [self addUIToolView2];
    [self addSubview:self.cycleScrollView2];
    
    self.height = self.cycleScrollView2.bottom+10;
    
    @weakify(self);
    [[RACObserve(AppMessage.shareInstance, needRefreshUI) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (AppMessage.shareInstance.needRefreshUI) {
            self.noticeView.titleArray = AppMessage.shareInstance.messageTitleArray;
        }
        
    }];
    
#pragma mark - 获取消息轮播列表
    [AppMessage.shareInstance getNewNotice];
    
    
    [self getActivitImages];
}

- (void)addHeader{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, LZApp.shareInstance.app_navigationBarHeight)];
    view.backgroundColor = LZWhiteColor;
    _userInfoView = view;
    
    UIImageView *avatar = [UIImageView new];
    UILabel *nameLabel = [UILabel labelWithFontSize:16];
    UIImageView *message = [UIImageView viewWithImage:UIImageName(@"xiaoxi")];
//    message.hidden = YES;
    
    [view addSubview:avatar];
    [view addSubview:nameLabel];
    [view addSubview:message];
    
    [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-8);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(avatar.mas_right).offset(8);
        make.centerY.mas_equalTo(avatar);
        make.right.mas_equalTo(-80);
    }];
    
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(avatar);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    message.userInteractionEnabled = YES;
    UITapGestureRecognizer *msgTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toMessage)];
    [message addGestureRecognizer:msgTap];
    
    [self addSubview:view];
    
    avatar.lz_setView.lz_cornerRadius(15);
    
    nameLabel.text = IsNull(CurrentUser.nickName)?@"":CurrentUser.nickName;
    
        //avatar、name
    avatar.image = [AppCenter defaultAppAvatar];
    if (!IsNull(CurrentUser.nickUrl)) {
        [avatar sd_setImageWithURL:TLURL(CurrentUser.nickUrl)];
    }
    
    nameLabel.text = CurrentUser.nickName;
    
    [RACObserve(CurrentUser, nickName) subscribeNext:^(id  _Nullable x) {
        nameLabel.text = CurrentUser.nickName;
    }];
  
    [RACObserve(CurrentUser, nickUrl) subscribeNext:^(id  _Nullable x) {
        if (!IsNull(CurrentUser.nickUrl)) {
            [avatar sd_setImageWithURL:TLURL(CurrentUser.nickUrl)];
        }
    }];
}

- (void)toMessage{
    UIViewController *vc = [[CTMediator sharedInstance] CTMediator_NoticeCenterViewControllerWithDefaultType:@"all"];
    PushController(vc);
}

- (void)addUIToolView2{
    [self addSubview:self.toolsView2];
    
    [self.toolsView2 setToolsArray:@[@"扫码收款",@"悬赏拓客",@"优惠券",
                                     @"短信营销",@"会员管理",@"店铺账本",
                                     @"数据统计",@"同城优惠",
                                     ]];//店铺账本
}

#pragma mark - HomeToolsView delegate
- (void)HomeToolsView:(nonnull HomeToolsView *)toolsView clickTitle:(nonnull NSString *)title {
    if ([title isEqualToString:@"收银员"]) {
        AppCenterCheckNotOpen
        APPCenterPowerCheckMerchant
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_ManManagerController];
        PushController(vc);
    }else if ([title isEqualToString:@"会员管理"]) {
          
        VipManagerViewController *vc = [VipManagerViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"短信营销"]) {
        [AppCenter setEmptyControllerTitle:@"短信营销"];
        APPCenterPowerCheckMerchant
        MarketMessageViewController *vc = [MarketMessageViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"悬赏拓客"]) {
        
        [RewardViewModel pushToRewardMoudleWithNav:self.navigationController];
    }else if ([title isEqualToString:@"优惠券"]) {
         APPCenterPowerCheckMerchant
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_CouponListViewController];
        PushController(vc);
    }else if ([title isEqualToString:@"店铺管理"]) {
         
        [[CTMediator sharedInstance] CTMediator_EditShopInfoViewControllerWithNav:self.navigationController];
    }else if ([title isEqualToString:@"店铺账本"]) {
        APPCenterPowerCheckMerchant
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_BookViewController];
        PushController(vc);
    }else if ([title isEqualToString:@"数据统计"]) {

        APPCenterPowerCheckMerchant
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_FormDataManagerController];
        [self.viewController presentViewController:vc animated:YES completion:nil];
    }else if ([title isEqualToString:@"扫码收款"]) {
        APPCenterPowerCheckMerchant
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_SKMManagerViewController];
        PushController(vc);
    }else if ([title isEqualToString:@"同城优惠"]) {
       [AppCenter toMiniProgram];
    }
    
}

#pragma mark - 消息通知
- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index{
    
    NoticeModel *message = [AppMessage.shareInstance.messageArray safeObjectWithIndex:index];
    
    if (message) {
            //消息详情
        MineMessageDetailViewController *detail = [[MineMessageDetailViewController alloc] initWithModel:message];
        PushController(detail);
        
    }
}

#pragma mark - 今日收益
/**收益数据*/
- (void)getTodayData{
    
    ZZNetWorker.GET.zz_url(@"/view-biz/profitDetailView/sum")
    .zz_completion(^(NSDictionary *data, NSError *error) {
        
        ZZNetWorkModelWithJson(data);
        if (model_net.success) {
            NSString *todayProfit = model_net.data[@"todayProfit"];
            NSString *todayReceiptAmt = model_net.data[@"todayReceiptAmt"];
            NSString *totalProfit = model_net.data[@"totalProfit"];
            NSString *receiptAmt = model_net.data[@"receiptAmt"];
            
            HomeTodayMoneyModel *model1 = [HomeTodayMoneyModel new];
            HomeTodayMoneyItemModel *item1 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:todayProfit] title:@"今日收益 (元)"];
            HomeTodayMoneyItemModel *item2 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:totalProfit] title:@"累计收益 (元)"];
            model1.dataArray = @[item1,item2];
            
            if (CurrentUser.lzUserType == LZUserTypeMerchant) {
                HomeTodayMoneyModel *model2 = [HomeTodayMoneyModel new];
                HomeTodayMoneyItemModel *item3 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:todayReceiptAmt] title:@"今日收款 (元)"];
                HomeTodayMoneyItemModel *item4 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:receiptAmt] title:@"累计收款 (元)"];
                model2.dataArray = @[item3,item4];
                self.todayView.dataArray = @[model1,model2];
            }else{
                self.todayView.dataArray = @[model1];
            }
            
            
        }
        
    });
}

#pragma mark - 获取活动图
- (void)getActivitImages{
        //轮播图
    [AdvertManager getAdvertWithType:AdvertTypeHome block:^(NSArray<AdvertModel *> * _Nonnull arr) {
        self.advertArray = arr;
        NSMutableArray *imageArray = [NSMutableArray array];
        for (AdvertModel *model in arr) {
            [imageArray addObject:IsNull(model.imageUrl)?@"":model.imageUrl];
        }
        
        self.cycleScrollView.imageURLStringsGroup = imageArray;
    }];
    
    [AdvertManager getAdvertWithType:AdvertTypeOther block:^(NSArray<AdvertModel *> * _Nonnull arr) {
        self.advertArray2 = arr;
        NSMutableArray *imageArray = [NSMutableArray array];
        for (AdvertModel *model in arr) {
            [imageArray addObject:IsNull(model.imageUrl)?@"":model.imageUrl];
        }
        
        self.cycleScrollView2.imageURLStringsGroup = imageArray;
    }];
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    AdvertModel *model;
    if (cycleScrollView == _cycleScrollView) {
        model = [self.advertArray safeObjectWithIndex:index];
    }else if (cycleScrollView == _cycleScrollView2) {
        model = [self.advertArray2 safeObjectWithIndex:index];
    }
    
    [AdvertManager tapAdvertModel:model withController:self.viewController];
    
}


- (HomeTodayDataView *)todayView{
    if (!_todayView) {
        _todayView = [HomeTodayDataView new];
        _todayView.frame = CGRectMake(0, self.toolsView2.bottom+10, kScreenWidth, 97);
    }

    return _todayView;
}

- (HomeToolsView *)toolsView2{
    if (!_toolsView2) {
        _toolsView2 = [[HomeToolsView alloc] initWithFrame:CGRectMake(0, self.noticeView.bottom, kScreenWidth, 160)];
        _toolsView2.backgroundColor = LZWhiteColor;
        _toolsView2.maxCountOneLine = 4;
        _toolsView2.topSpacing = 20;
        _toolsView2.delegate = self;
    }
    return _toolsView2;
}

- (SGAdvertScrollView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[SGAdvertScrollView alloc] initWithFrame:CGRectMake(0, self.cycleScrollView.bottom, kScreenWidth, 41)];
        _noticeView.timeInterval = 3;
        _noticeView.image = UIImageName(@"tongzhi");
        _noticeView.titleFont = Font_PingFang_SC_Regular(13);
        _noticeView.titleColor = rgb(101,101,101);
        _noticeView.advertScrollViewDelegate = self;
    }
    return _noticeView;
}

- (SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        CGFloat width = kScreenWidth-20;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, self.userInfoView.bottom, width, width*(70.0/160)) delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 9;
        _cycleScrollView.showPageControl = YES;
//        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _cycleScrollView.backgroundColor = [UIColor whiteColor];
        _cycleScrollView.lz_setView.lz_cornerRadius(4);
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, _cycleScrollView.top, kScreenWidth, _cycleScrollView.height)];
        view.backgroundColor = LZWhiteColor;
        [self addSubview:view];
    }
    return _cycleScrollView;
}

- (SDCycleScrollView *)cycleScrollView2{
    if (!_cycleScrollView2) {
        CGFloat width = kScreenWidth;
        _cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, self.todayView.bottom+10, width, width*(200.0/750)) delegate:self placeholderImage:nil];
        _cycleScrollView2.autoScrollTimeInterval = 9;
        _cycleScrollView2.showPageControl = NO;
        _cycleScrollView2.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _cycleScrollView2.backgroundColor = [UIColor whiteColor];
    }
    return _cycleScrollView2;
}
@end
