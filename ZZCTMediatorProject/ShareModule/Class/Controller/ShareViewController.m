//
//  ShareViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/10.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "ShareViewController.h"
#import "ShareInterfaceCell.h"
#import "FaceToFaceViewController.h"
#import "GeneralizeCodeImageController.h"

@interface ShareViewController ()

@property (nonatomic, strong) UIView *cellView;
@end

@implementation ShareViewController

- (BOOL)hiddenNavgationBar{
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    UITabBarController *tabbar = (UITabBarController *)KeyWindow.rootViewController;
    if ([tabbar isKindOfClass:[UITabBarController class]]) {
        if (tabbar.selectedViewController != self.navigationController) {
            [self.navigationController setNavigationBarHidden:YES animated:NO];
        }else{
            [self.navigationController setNavigationBarHidden:YES animated:YES];
        }
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = LZWhiteColor;
    
    UIView *topView = [UIView new];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(0);
        make.height.mas_equalTo(self.base_navigationbarHeight+75);
    }];
    [topView setDefaultGradient];
    
    UILabel *titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"邀请好友" textColor:LZWhiteColor];
    [topView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(topView);
        make.bottom.mas_equalTo(-75);
    }];
    
    UIView *cellView = [UIView new];
    [self.view addSubview:cellView];
    [cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.base_navigationbarHeight+10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(98*3);
    }];
    
    @weakify(self);
    ShareInterfaceCell *cell1 = [ShareInterfaceCell cellWithLogo:UIImageName(@"share_code") title:@"二维码图片链接" subTitle:@"识别二维码下载注册一起玩" btnTitle:@"马上邀请" block:^{
        NewClass(codeImageVC, GeneralizeCodeImageController);
        PushController(codeImageVC);
    }];
    [cellView addSubview:cell1];
    [cell1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(98);
    }];
    
    ShareInterfaceCell *cell2 = [ShareInterfaceCell cellWithLogo:UIImageName(@"share_link") title:@"注册邀请链接" subTitle:@"邀请您的好友一起赚钱" btnTitle:@"马上邀请" block:^{
        [AppCenter shareURL:[AppCenter shareRegisterURL]];
    }];
    [cellView addSubview:cell2];
    [cell2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(cell1.mas_bottom);
        make.height.mas_equalTo(98);
    }];
    
    ShareInterfaceCell *cell3 = [ShareInterfaceCell cellWithLogo:UIImageName(@"share_people") title:@"面对面开通" subTitle:@"可快速帮好友开通" btnTitle:@"帮好友开通" block:^{
        @strongify(self);
        NewClass(vc, FaceToFaceViewController);
        PushController(vc);
    }];
    [cellView addSubview:cell3];
    [cell3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(cell2.mas_bottom);
        make.height.mas_equalTo(98);
    }];
    
    [cellView layoutIfNeeded];
    cellView.lz_setView.lz_shadow(10, rgba(255,142,1,0.4), CGSizeMake(0, 1), 1, 10);
    _cellView = cellView;
}



@end
