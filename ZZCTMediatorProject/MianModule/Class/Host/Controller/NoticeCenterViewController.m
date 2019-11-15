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
    
    NoticeListViewController *vc0 = [[NoticeListViewController alloc] initWithType:@"0"];
    NoticeListViewController *vc2 = [[NoticeListViewController alloc] initWithType:@"1"];
    
    _pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight) WithTitles:@[@"消息",@"公告",] WithObjects:@[vc0,vc2]];
    _pageView.underlineColor = rgb(255,81,0);
    _pageView.selectTitleColor = rgb(53,53,53);
    _pageView.unSelectTitleColor = rgb(101,101,101);
    _pageView.tintColor = rgb(251,251,251);
    
    if ([self.type isEqualToString:@"1"]) {
        _pageView.ninaDefaultPage = 1;
    }else if ([self.type isEqualToString:@"0"]) {
        _pageView.ninaDefaultPage = 0;
    }
    
    
    [self.view addSubview:_pageView];
}



@end
