//
//  HomeViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "HomeViewController.h"
#import "SKMManagerViewController.h"
#import "SKViewController.h"
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


#import <SDCycleScrollView.h>
#import "AdvertManager.h"
#import "RewardViewModel.h"

@interface HomeViewController ()<HomeToolsViewDelegate,SGAdvertScrollViewDelegate,SDCycleScrollViewDelegate>

@property (nonatomic, strong) SGAdvertScrollView *noticeView;
@property (nonatomic, strong) HomeTopToolView *topToolView;
@property (nonatomic, strong) HomeTodayDataView *todayView;
@property (nonatomic, strong) HomeToolsView *toolsView2;

@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) NSArray <AdvertModel *>*advertArray;

@end

@implementation HomeViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self getTodayData];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"首页";
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = LZWhiteColor;
    
    [self addUIToolView1];
    
    [self.scrollView addSubview:self.noticeView];
    [self.scrollView addSubview:self.todayView];
    [self.scrollView addSubview:self.cycleScrollView];
    [self addUIToolView2];
    
    self.scrollView.contentHeight = self.toolsView2.bottom+10;
    
    @weakify(self);
    [[RACObserve(AppMessage.shareInstance, needRefreshUI) takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (AppMessage.shareInstance.needRefreshUI) {
            self.noticeView.titleArray = AppMessage.shareInstance.messageTitleArray;
        }
        
    }];
    
#pragma mark - 获取消息轮播列表
    [AppMessage.shareInstance getNewNotice];
    //激活推送
    CurrentUser.isOpenAppNotification = CurrentUser.isOpenAppNotification;
    
    [self getAppKefuInfo];
    [self getActivitImages];
    
    [AppMessage getHomePresentNoticeWithBlock:^(NoticeModel * _Nonnull message) {
        @strongify(self);
        if (message) {
            [self showAppMessage:message];
        }
    }];
    
    [self addRightItemWithImage:@"messageIcon" title:nil font:nil color:nil block:^{
        @strongify(self);
       UIViewController *vc = [[CTMediator sharedInstance] CTMediator_NoticeCenterViewControllerWithDefaultType:@"all"];
        PushController(vc);
    }];
}


- (void)addUIToolView1{
    [self.scrollView addSubview:self.topToolView];
    
    @weakify(self);
    self.topToolView.clickBlock = ^(NSInteger index) {
        @strongify(self);
        
        if (index == 0) {
            
            UIViewController *vc = [[CTMediator sharedInstance] CTMediator_SKMManagerViewController];
            PushController(vc);
        }else if (index == 1){
            NewClass(vc, SKViewController);
            PushController(vc);
        }else if (index == 2){//报表管理
            UIViewController *vc = [[CTMediator sharedInstance] CTMediator_FormDataManagerController];
            [self presentViewController:vc animated:YES completion:nil];
            
        }
    };
 
}

- (void)addUIToolView2{
    [self.scrollView addSubview:self.toolsView2];
    
    [self.toolsView2 setToolsArray:@[@"优惠券",@"悬赏",@"智慧营销",
                                     @"会员管理",@"店铺管理",@"收银员管理"
                                     ]];
}


#pragma mark - HomeToolsView delegate
- (void)HomeToolsView:(nonnull HomeToolsView *)toolsView clickTitle:(nonnull NSString *)title {
    if ([title isEqualToString:@"收银员管理"]) {
          
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_ManManagerController];
        PushController(vc);
    }else if ([title isEqualToString:@"会员管理"]) {
          
        VipManagerViewController *vc = [VipManagerViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"智慧营销"]) {
          
        MarketMessageViewController *vc = [MarketMessageViewController new];
        PushController(vc);
    }else if ([title isEqualToString:@"悬赏"]) {
         
        [RewardViewModel pushToRewardMoudleWithNav:self.navigationController];
    }else if ([title isEqualToString:@"优惠券"]) {
         
        UIViewController *vc = [[CTMediator sharedInstance] CTMediator_CouponListViewController];
        PushController(vc);
    }else if ([title isEqualToString:@"店铺管理"]) {
         
        [[CTMediator sharedInstance] CTMediator_EditShopInfoViewControllerWithNav:self.navigationController];
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

#pragma mark - 今日收益
- (void)getTodayData{
    
    
}

#pragma mark - 客服信息
- (void)getAppKefuInfo{
    ZZNetWorker.GET.zz_param(@{}).zz_url(@"/general/tbConsumerTimes/app")
    .zz_isPostByURLSession(YES)
    .zz_completion(^(NSDictionary *data, NSError *error) {
        ZZNetWorkModelWithJson(data);
        
        if (model_net.success) {
            
            NSArray *dicArray = model_net.data;
            NSDictionary *kefuDic = dicArray.firstObject;
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"mobile"] forKey:@"kefuPhone"];
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"startTime"] forKey:@"kefuStartTime"];
            [[NSUserDefaults standardUserDefaults] setObject:kefuDic[@"endTime"] forKey:@"kefuEndTime"];
            
            NSDictionary *weixinDic = [dicArray safeObjectWithIndex:1];
            [[NSUserDefaults standardUserDefaults] setObject:weixinDic[@"url"] forKey:@"kefu_weixinCode"];
            [[NSUserDefaults standardUserDefaults] setObject:weixinDic[@"author"] forKey:@"kefu_weixinNumber"];
            
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
        if (arr.count == 0) {
            self.cycleScrollView.hidden = YES;
            self.cycleScrollView.height = 0;
            self.toolsView2.top = self.todayView.bottom+8;
            self.scrollView.contentHeight = self.toolsView2.bottom+10;
        }
    }];
}


/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    AdvertModel *model = [self.advertArray safeObjectWithIndex:index];
    
    [AdvertManager tapAdvertModel:model withController:self];
    
}

- (HomeTopToolView *)topToolView{
    if (!_topToolView) {
        _topToolView = [[HomeTopToolView alloc] initWithFrame:CGRectMake(15, 5, kScreenWidth-30, 110*LZScale)];
    }
    return _topToolView;
}

- (HomeTodayDataView *)todayView{
    if (!_todayView) {
        _todayView = [HomeTodayDataView xibView];
        _todayView.frame = CGRectMake(0, self.noticeView.bottom+10, kScreenWidth, 97);
    }
    return _todayView;
}

- (HomeToolsView *)toolsView2{
    if (!_toolsView2) {
        _toolsView2 = [[HomeToolsView alloc] initWithFrame:CGRectMake(0, self.cycleScrollView.bottom+8, kScreenWidth, 230)];
        _toolsView2.backgroundColor = LZWhiteColor;
        _toolsView2.delegate = self;
    }
    return _toolsView2;
}

- (SGAdvertScrollView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[SGAdvertScrollView alloc] initWithFrame:CGRectMake(0, self.topToolView.bottom+8, kScreenWidth, 41)];
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
        CGFloat width = kScreenWidth-60;
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(30, self.todayView.bottom+8, width, width*(52.0/160)) delegate:self placeholderImage:nil];
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFit;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
    }
    return _cycleScrollView;
}
@end
