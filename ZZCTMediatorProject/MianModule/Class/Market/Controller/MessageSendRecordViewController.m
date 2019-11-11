//
//  MessageSendRecordViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageSendRecordViewController.h"
#import "NinaPagerView.h"

@interface MessageSendRecordViewController ()

@property (nonatomic, strong) NinaPagerView *pagerView;
@end

@implementation MessageSendRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发送记录";
    
    _pagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight) WithTitles:@[@"已完成",@"执行中"] WithObjects:@[@"MessageRecordDidSendController",@"MessageRecordWaitSendController"]];
    
    _pagerView.underlineColor = rgb(255,81,0);
    _pagerView.selectTitleColor = rgb(255,81,0);
    _pagerView.unSelectTitleColor = rgb(53,53,53);
    _pagerView.titleFont = 16;
    _pagerView.titleScale = 1;
    
    [self.view addSubview:_pagerView];
}


@end
