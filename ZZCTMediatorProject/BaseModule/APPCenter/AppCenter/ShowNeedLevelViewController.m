//
//  ShowNeedLevelViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ShowNeedLevelViewController.h"

@interface ShowNeedLevelViewController ()

@property (nonatomic, weak) UIViewController *superController;
@end

@implementation ShowNeedLevelViewController

+ (ShowNeedLevelViewController *)showNeedAuthenWithController:(UIViewController *)superController{
    ShowNeedLevelViewController *vc = [ShowNeedLevelViewController new];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    superController.definesPresentationContext = YES;
    [superController presentViewController:vc animated:YES completion:nil];
    vc.superController = superController;
    
    return vc;
}

- (BOOL)willAddTap{
    return YES;
}

- (void)selfViewTap{
    [super selfViewTap];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    UIView *cardView = [UIView new];
    cardView.backgroundColor = LZWhiteColor;
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-40);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(165);
    }];
    cardView.lz_setView.lz_cornerRadius(8);
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"您不是服务商哦，" textColor:rgb(101,101,101)];
    [cardView addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *label_title2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"升级服务商享受更多特权" textColor:rgb(101,101,101)];
    [cardView addSubview:label_title2];
    [label_title2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_title.mas_bottom).offset(10);
        make.centerX.mas_equalTo(0);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *cancel = [UIImageView viewWithImage:UIImageName(@"cancel")];
    [cardView addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UIButton *commitBtn = [UIButton buttonWithFontSize:16 text:@"点我升级" textColor:LZWhiteColor];
    [cardView addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(44);
        make.right.mas_equalTo(-24);
    }];
    [commitBtn setGradientWithColorArray:@[rgb(247,165,66),rgb(236,196,89),rgb(255,122,57)] cornerRadius:3 directionType:GradientDirectionTypeHorizontal];
    
    @weakify(self);
    [commitBtn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [[NSNotificationCenter defaultCenter] postNotificationName:LevelUpNeedSelectedNotificationName object:@(2)];
        self.superController.tabBarController.selectedIndex = 2;
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}



@end
