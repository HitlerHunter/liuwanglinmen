//
//  NoticeCenterViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NoticeCenterViewController.h"
#import "NinaPagerView.h"
#import "NoticeListViewController.h"

@interface NoticeCenterViewController ()

@property (nonatomic, strong) NinaPagerView *pageView;
@property (nonatomic, strong) NSString *type;
@end

@implementation NoticeCenterViewController

- (instancetype)initWithType:(NSString *)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"消息中心";
    
    NoticeListViewController *vc0 = [[NoticeListViewController alloc] initWithType:@"all"];
    NoticeListViewController *vc2 = [[NoticeListViewController alloc] initWithType:@"1"];
    NoticeListViewController *vc3 = [[NoticeListViewController alloc] initWithType:@"3"];
    NoticeListViewController *vc4 = [[NoticeListViewController alloc] initWithType:@"4"];
    
    _pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight) WithTitles:@[@"消息",@"悬赏",@"积分",@"优惠券",] WithObjects:@[vc0,vc2,vc3,vc4]];
    _pageView.underlineColor = rgb(255,81,0);
    _pageView.selectTitleColor = rgb(53,53,53);
    _pageView.unSelectTitleColor = rgb(101,101,101);
    _pageView.tintColor = rgb(251,251,251);
    
    if ([self.type isEqualToString:@"1"]) {
        _pageView.ninaDefaultPage = 1;
    }else if ([self.type isEqualToString:@"3"]) {
        _pageView.ninaDefaultPage = 2;
    }else if ([self.type isEqualToString:@"4"]) {
        _pageView.ninaDefaultPage = 3;
    }else if ([self.type isEqualToString:@"all"]) {
        _pageView.ninaDefaultPage = 0;
    }
    
    
    [self.view addSubview:_pageView];
}



@end
