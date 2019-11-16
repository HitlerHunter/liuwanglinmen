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
#import "NoticeListViewModel.h"

@interface NoticeCenterViewController ()<NinaPagerViewDelegate>

@property (nonatomic, strong) NinaPagerView *pageView;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NoticeListViewController *vc_xiaoxi;
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
    
    NoticeListViewController *vc0 = [[NoticeListViewController alloc] initWithType:@"1"];
    NoticeListViewController *vc2 = [[NoticeListViewController alloc] initWithType:@"0"];
    _vc_xiaoxi = vc0;
    
    _pageView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight) WithTitles:@[@"消息",@"公告",] WithObjects:@[vc0,vc2]];
    _pageView.underlineColor = rgb(255,81,0);
    _pageView.selectTitleColor = rgb(53,53,53);
    _pageView.unSelectTitleColor = rgb(101,101,101);
    _pageView.tintColor = rgb(251,251,251);
    _pageView.delegate = self;
    
    if ([self.type isEqualToString:@"1"]) {
        _pageView.ninaDefaultPage = 1;
    }else if ([self.type isEqualToString:@"0"]) {
        _pageView.ninaDefaultPage = 0;
    }
    
    
    [self.view addSubview:_pageView];
    
}

- (void)ninaCurrentPageIndex:(NSInteger)currentPage currentObject:(id)currentObject lastObject:(id)lastObject{
    if (currentObject == _vc_xiaoxi) {
        @weakify(self);
        [self addRightItemWithImage:nil title:@"清空" font:nil color:nil block:^{
            @strongify(self);
            [self clearAllNotice];
            
        }];
    }else{
        self.navigationItem.rightBarButtonItems = @[];
    }
}

- (void)clearAllNotice{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否清空所有消息？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"清空" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
         [NoticeListViewModel clearNoticeWithBlock:^(BOOL isSuccess) {
             if (isSuccess) {
                 [self.vc_xiaoxi clearDatas];
             }
         }];
    }];
    
    [alert addAction:cancel];
    [alert addAction:sure];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}

@end
