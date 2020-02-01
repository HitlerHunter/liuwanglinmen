//
//  LevelTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelTopView.h"
#import "LevelSelectButton.h"
#import "UserInfoShowView.h"

@interface LevelTopView ()

@property (nonatomic, strong) LevelSelectButton *btn1;
@property (nonatomic, strong) LevelSelectButton *btn2;
@property (nonatomic, strong) LevelSelectButton *btn3;
@end

@implementation LevelTopView

- (void)initUI{
    
    UIImageView *bgImageView = [UIImageView viewWithImage:UIImageName(@"share_topBg")];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
//    [bgImageView setDefaultGradient];
    
    UserInfoShowView *userInfo = [UserInfoShowView new];
    userInfo.showEditBtn = NO;
    [self addSubview:userInfo];
    [userInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(16);
        make.height.mas_equalTo(50);
    }];
    
    LevelSelectButton *btn1 = [LevelSelectButton new];
    btn1.titleLabel2.text = @"副业";
    [self addSubview:btn1];
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(97);
        make.height.mas_equalTo(68);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    LevelSelectButton *btn2 = [LevelSelectButton new];
    btn2.titleLabel2.text = @"创业";
    [self addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn1.mas_right);
        make.top.mas_equalTo(btn1);
        make.height.mas_equalTo(btn1);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
//    LevelSelectButton *btn3 = [LevelSelectButton new];
//    btn3.titleLabel2.text = @"区域服务商";
//    [self addSubview:btn3];
//    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(btn2.mas_right);
//        make.top.mas_equalTo(btn1);
//        make.height.mas_equalTo(btn1);
//        make.width.mas_equalTo(kScreenWidth/3);
//    }];
    
    btn1.selected = YES;
    btn2.selected = NO;
//    btn3.selected = NO;
    
    btn1.tag = 101;
    btn2.tag = 102;
//    btn3.tag = 103;
    
    _btn1 = btn1;
    _btn2 = btn2;
//    _btn3 = btn3;
    
    [btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];=
    
}

- (void)btnClick:(UIButton *)btn{
    btn.selected = YES;
    
    if (btn.tag == 101) {
        _btn2.selected = NO;
        _btn3.selected = NO;
        if (_levelClickBlock) {
            _levelClickBlock(1);
        }
    }else if (btn.tag == 102) {
        _btn1.selected = NO;
        _btn3.selected = NO;
        if (_levelClickBlock) {
            _levelClickBlock(2);
        }
    }else if (btn.tag == 103) {
        _btn2.selected = NO;
        _btn1.selected = NO;
        if (_levelClickBlock) {
            _levelClickBlock(3);
        }
    }
}

- (void)toSelectInde:(NSInteger)index{
    
    if (index == 1) {
        [_btn1 sendActionsForControlEvents:UIControlEventTouchUpInside];
    }else if (index == 2) {
        [_btn2 sendActionsForControlEvents:UIControlEventTouchUpInside];
    }else if (index == 3) {
        [_btn3 sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}

@end
