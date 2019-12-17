//
//  MineOrderViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/18.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineOrderViewController.h"
#import "NinaPagerView.h"
#import "HooDatePicker.h"
#import "MineOrderBaseViewController.h"

@interface MineOrderViewController ()<NinaPagerViewDelegate>
@property (nonatomic, strong) NinaPagerView *ninaPagerView;
@property (nonatomic, assign) NSInteger index;
@end

@implementation MineOrderViewController

- (instancetype)initWithIndex:(NSInteger)index{
    self = [super init];
    if (self) {
        _index = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    
    [self.view addSubview:self.ninaPagerView];
 
    [self.ninaPagerView setNinaDefaultPage:_index];
}

#pragma mark - NinaParaArrays
/**
 *  上方显示标题(您需要注意的是，虽然框架中对长标题进行了优化处理，但是建议您设置标题时汉字的长度不要超过10)。
 *  Titles showing on the topTab
 *
 *  @return Array of titles.
 */
- (NSArray *)ninaTitleArray {
    return @[
             @"全部",
             @"待付款",
             @"待发货",
             @"已发货",
             @"已取消",
             ];
}


- (NSArray *)ninaVCsArray {
    return @[
             [[MineOrderBaseViewController alloc] init],
             [[MineOrderBaseViewController alloc] initWithStatus:@"1"],
             [[MineOrderBaseViewController alloc] initWithStatus:@"2"],
             [[MineOrderBaseViewController alloc] initWithStatus:@"3"],
             [[MineOrderBaseViewController alloc] initWithStatus:@"0"],
             ];
}

#pragma mark - LazyLoad
- (NinaPagerView *)ninaPagerView {
    if (!_ninaPagerView) {
        NSArray *titleArray = [self ninaTitleArray];
        NSArray *vcsArray = [self ninaVCsArray];
        /**
         *  创建ninaPagerView，控制器第一次是根据您划的位置进行相应的添加的，类似网易新闻虎扑看球等的效果，后面再滑动到相应位置时不再重新添加，如果想刷新数据，您可以在相应的控制器里加入刷新功能。需要注意的是，在创建您的控制器时，设置的frame为FUll_CONTENT_HEIGHT，即全屏高减去导航栏高度，如果这个高度不是您想要的，您可以去在下面的frame自定义设置。
         *  A tip you should know is that when init the VCs frames,the default frame i set is FUll_CONTENT_HEIGHT,it means fullscreen height - NavigationHeight - TabbarHeight.If the frame is not what you want,just set frame as you wish.
         */
        CGRect pagerRect = CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight);
        _ninaPagerView = [[NinaPagerView alloc] initWithFrame:pagerRect WithTitles:titleArray WithObjects:vcsArray];
        _ninaPagerView.ninaPagerStyles = NinaPagerStyleBottomLine;
        _ninaPagerView.delegate = self;
        _ninaPagerView.topTabHeight = 46;
        _ninaPagerView.selectTitleColor = rgb(53,53,53);
    }
    return _ninaPagerView;
}

@end
