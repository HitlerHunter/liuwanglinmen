//
//  LevelUpSuccessViewController.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelUpSuccessViewController.h"

@interface LevelUpSuccessViewController ()

@property (nonatomic, assign) LevelUpSuccessType type;
@end

@implementation LevelUpSuccessViewController

+ (void)showSuccessWithController:(UIViewController *)superController
                             type:(LevelUpSuccessType)type{
    LevelUpSuccessViewController *vc = [[LevelUpSuccessViewController alloc] initWityType:type];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    superController.definesPresentationContext = YES;
    [superController presentViewController:vc animated:YES completion:nil];
}

- (instancetype)initWityType:(LevelUpSuccessType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (BOOL)willAddTap{
    return YES;
}

- (void)selfViewTap{
    
    if (_type == LevelUpSuccessTypeVIP ||
        _type == LevelUpSuccessTypeServer) {
        [[UserManager shareInstance] getUserInfo:^(BOOL isSuccess) {
            [AppCenter toTabBarController];
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    
    UIImageView *cardView = [UIImageView new];
    cardView.backgroundColor = LZWhiteColor;
    [self.view addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(-40);
        make.centerX.mas_equalTo(0);
        make.width.mas_equalTo(305);
    }];
    cardView.lz_setView.lz_cornerRadius(8);
    
    if (_type == LevelUpSuccessTypeVIP) {
        cardView.image = UIImageName(@"LevelUpSuccessTypeVIP");
    }else if (_type == LevelUpSuccessTypeAlreadyVIP) {
        cardView.image = UIImageName(@"LevelUpSuccessTypeAlreadyVIP");
    }else if (_type == LevelUpSuccessTypeServer) {
        cardView.image = UIImageName(@"LevelUpSuccessTypeServer");
    }else if (_type == LevelUpSuccessTypeAreaServer) {
        cardView.image = UIImageName(@"LevelUpSuccessTypeServer");
    }
}

@end
