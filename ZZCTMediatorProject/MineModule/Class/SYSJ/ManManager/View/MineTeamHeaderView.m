//
//  MineTeamHeaderView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineTeamHeaderView.h"

@interface MineTeamHeaderView ()

@property (nonatomic, strong) UIButton *btnLeft;
@property (nonatomic, strong) UIButton *btnRight;
@property (nonatomic, strong) UIImageView *bgImageView;
@property (nonatomic, strong) UIView *btnBgView;
@end

@implementation MineTeamHeaderView

- (void)initUI{
    
    UIImageView *bgImageView = [UIImageView viewWithImage:UIImageName(@"mineTeam_topBg")];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(110);
    }];
    _bgImageView = bgImageView;
    
    UIView *line = [UIView new];
    line.backgroundColor = LZWhiteColor;
    [bgImageView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(1, 30));
        make.center.mas_equalTo(0);
    }];
    
    UILabel *lab1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(20) text:@"0" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [bgImageView addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(line).offset(-3);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(line.mas_left);
    }];
    
    UILabel *lab2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(20) text:@"0" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [bgImageView addSubview:lab2];
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lab1);
        make.left.mas_equalTo(line.mas_right);
        make.right.mas_equalTo(0);
    }];
    
    UILabel *labMessage1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"今日新增 (人)" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [bgImageView addSubview:labMessage1];
    [labMessage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_bottom);
        make.left.right.mas_equalTo(lab1);
    }];
    
    UILabel *labMessage2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"团队总人数 (人)" textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
    [bgImageView addSubview:labMessage2];
    [labMessage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(line.mas_bottom);
        make.left.right.mas_equalTo(lab2);
    }];
    
    _numberLabelLeft = lab1;
    _numberLabelRight = lab2;
    

    UIView *btnBgView = [UIView new];
    [self addSubview:btnBgView];
    
    UIButton *btnLeft = [UIButton buttonWithFontSize:13 text:@"我的用户" textColor:LZWhiteColor];
    [self addSubview:btnLeft];
    [btnLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(bgImageView.mas_bottom).offset(20);
        make.height.mas_equalTo(26);
        make.width.mas_equalTo(kScreenWidth/2);
    }];
    
    UIButton *btnRight = [UIButton buttonWithFontSize:13 text:@"其他" textColor:rgb(101,101,101)];
    [self addSubview:btnRight];
    [btnRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(0);
        make.top.width.height.mas_equalTo(btnLeft);
    }];
    
    [btnBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(btnLeft);
        make.size.mas_equalTo(CGSizeMake(123, 26));
    }];
    
    [btnBgView setDefaultGradientWithCornerRadius:13];
    
    _btnLeft = btnLeft;
    _btnRight = btnRight;
    _btnBgView = btnBgView;
    
    [btnLeft addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [btnRight addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)btn{
    
    
    if (btn == _btnLeft && !_btnLeft.isSelected && _btnClick) {
     
        _btnLeft.selected = YES;
        _btnRight.selected = NO;
        
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.25 animations:^{
            [btn setTitleColor:LZWhiteColor forState:UIControlStateNormal];
            [self.btnRight setTitleColor:rgb(101,101,101) forState:UIControlStateNormal];
            
            [self.btnBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.btnLeft);
                make.size.mas_equalTo(CGSizeMake(123, 26));
            }];
            [self layoutIfNeeded];
        }];
        
        _btnClick(0);
        
    }else if (btn == _btnRight && !_btnRight.isSelected && _btnClick) {
        
        _btnRight.selected = YES;
        _btnLeft.selected = NO;
        
        [self setNeedsUpdateConstraints];
        [UIView animateWithDuration:0.25 animations:^{
            [btn setTitleColor:LZWhiteColor forState:UIControlStateNormal];
            [self.btnLeft setTitleColor:rgb(101,101,101) forState:UIControlStateNormal];
            
            [self.btnBgView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.center.mas_equalTo(self.btnRight);
                make.size.mas_equalTo(CGSizeMake(123, 26));
            }];
            [self layoutIfNeeded];
        }];
        _btnClick(1);
    }
    
}

- (void)setMineUserCount:(NSInteger)mineUserCount{
    
    if (mineUserCount>0) {
        [_btnLeft setTitle:[NSString stringWithFormat:@"我的用户(%ld)",mineUserCount] forState:UIControlStateNormal];
    }else{
        [_btnLeft setTitle:@"我的用户" forState:UIControlStateNormal];
    }
}

- (void)setOtherCount:(NSInteger)otherCount{
    if (otherCount>0) {
        [_btnRight setTitle:[NSString stringWithFormat:@"其他(%ld)",otherCount] forState:UIControlStateNormal];
    }else{
        [_btnRight setTitle:@"其他" forState:UIControlStateNormal];
    }
}

@end
