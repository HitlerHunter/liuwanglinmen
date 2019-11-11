//
//  CollectionMoneyViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/8.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CollectionMoneyViewController.h"
#import "NinaPagerView.h"

@interface CollectionMoneyViewController ()
@property (nonatomic, strong) NinaPagerView *pagerView;
@end

@implementation CollectionMoneyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"扫码收款";
    
    _pagerView = [[NinaPagerView alloc] initWithFrame:CGRectMake(0, self.base_navigationbarHeight, kScreenWidth, self.contentHeight) WithTitles:@[@"二维码收款",@"商户主扫"] WithObjects:@[@"SKMManagerViewController",@"SKViewController"]];
    
    _pagerView.underlineColor = rgb(255,81,0);
    _pagerView.selectTitleColor = rgb(255,81,0);
    _pagerView.unSelectTitleColor = rgb(53,53,53);
    _pagerView.titleFont = 16;
    _pagerView.titleScale = 1;
    
    [self.view addSubview:_pagerView];
}


@end
