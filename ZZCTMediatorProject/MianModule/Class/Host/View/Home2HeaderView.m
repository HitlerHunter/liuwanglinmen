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


- (void)toMessage{
    UIViewController *vc = [[CTMediator sharedInstance] CTMediator_NoticeCenterViewControllerWithDefaultType:@"all"];
    PushController(vc);
}

- (void)addUIToolView2{
    [self addSubview:self.toolsView2];
    
    [self.toolsView2 setToolsArray:@[@"爆品商城",@"商家收款",@"预借现金",
                                     @"办信用卡"
                                     ]];//店铺账本
}

#pragma mark - HomeToolsView delegate
- (void)HomeToolsView:(nonnull HomeToolsView *)toolsView clickTitle:(nonnull NSString *)title {
    if ([title isEqualToString:@"短信营销"]) {
        [AppCenter setEmptyControllerTitle:@"短信营销"];
        APPCenterPowerCheckMerchant
        MarketMessageViewController *vc = [MarketMessageViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"悬赏拓客"]) {
        
        [RewardViewModel pushToRewardMoudleWithNav:self.navigationController];
    }else if ([title isEqualToString:@"商家收款"]) {
        AdvertModel *model = [AdvertModel new];
        model.func = @"receive";
        [AdvertManager tapAdvertModel:model withController:self.viewController];
    }else if ([title isEqualToString:@"爆品商城"]) {
        AdvertModel *model = [AdvertModel new];
        model.remark = @"hotSale";
        model.func = @"shopping";
        [AdvertManager tapAdvertModel:model withController:self.viewController];
    }else if ([title isEqualToString:@"预借现金"]) {
        AdvertModel *model = [AdvertModel new];
        model.func = @"cash";
        [AdvertManager tapAdvertModel:model withController:self.viewController];
    }else if ([title isEqualToString:@"办信用卡"]) {
        AdvertModel *model = [AdvertModel new];
        model.remark = @"http://admin.6wang666.com/new6wH5/html/applyCard.html";
        model.redirectUrl = @"http://admin.6wang666.com/new6wH5/html/bankList.html";
        model.func = @"applycard";
        [AdvertManager tapAdvertModel:model withController:self.viewController];
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
//            NSString *todayReceiptAmt = model_net.data[@"todayReceiptAmt"];
            NSString *totalProfit = model_net.data[@"totalProfit"];
//            NSString *receiptAmt = model_net.data[@"receiptAmt"];
            
            HomeTodayMoneyModel *model1 = [HomeTodayMoneyModel new];
            HomeTodayMoneyItemModel *item1 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:todayProfit] title:@"今日收益 (元)"];
            HomeTodayMoneyItemModel *item2 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:totalProfit] title:@"累计收益 (元)"];
            model1.dataArray = @[item1,item2];

            self.todayView.dataArray = @[model1];
            /*
            if (CurrentUser.lzUserType == LZUserTypeMerchant) {
                HomeTodayMoneyModel *model2 = [HomeTodayMoneyModel new];
                HomeTodayMoneyItemModel *item3 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:todayReceiptAmt] title:@"今日收款 (元)"];
                HomeTodayMoneyItemModel *item4 = [HomeTodayMoneyItemModel modelWithMoney:[NSString formatMoneyCentToYuanString:receiptAmt] title:@"累计收款 (元)"];
                model2.dataArray = @[item3,item4];
                self.todayView.dataArray = @[model1,model2];
            }else{
                self.todayView.dataArray = @[model1];
            }*/
            
            
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
        _todayView.frame = CGRectMake(0, self.toolsView2.bottom, kScreenWidth, 97);
    }

    return _todayView;
}

- (HomeToolsView *)toolsView2{
    if (!_toolsView2) {
        _toolsView2 = [[HomeToolsView alloc] initWithFrame:CGRectMake(0, self.noticeView.bottom, kScreenWidth, 100)];
        _toolsView2.backgroundColor = LZWhiteColor;
        _toolsView2.maxCountOneLine = 4;
        _toolsView2.topSpacing = 25;
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
        CGFloat width = kScreenWidth;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, width, width*(100.0/75)) delegate:self placeholderImage:nil];
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
