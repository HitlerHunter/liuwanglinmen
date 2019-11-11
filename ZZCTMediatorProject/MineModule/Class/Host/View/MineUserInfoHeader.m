//
//  MineUserInfoHeader.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/21.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "MineUserInfoHeader.h"
#import "UserInfoShowView.h"

@interface MineUserInfoHeader ()

@end

@implementation MineUserInfoHeader

- (void)initUI{
    
    UIImageView *bgImageView = [UIImageView viewWithImage:UIImageName(@"share_topBg")];
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsZero);
    }];
    

    UserInfoShowView *userInfo = [UserInfoShowView new];
    userInfo.showAbleInfo = NO;
    [self addSubview:userInfo];
    [userInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(-58);
        make.height.mas_equalTo(50);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = rgb(42,42,42);
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(45);
    }];
    bottomView.lz_setView.lz_cornerRadius(5);
    
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"gengduo_baise")];
    [bottomView addSubview:moreIcon];
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(5, 8));
        make.right.mas_equalTo(-19);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"去开通" textColor:rgb(231,222,183)];
    [bottomView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(moreIcon.mas_left).offset(-5);
        make.centerY.mas_equalTo(moreIcon);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"会员享更多特权" textColor:rgb(231,222,183)];
    [bottomView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.centerY.mas_equalTo(moreIcon);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toLevelUp)];
    [bottomView addGestureRecognizer:tap];
}

- (void)toLevelUp{
    self.cyl_tabBarController.selectedIndex = 2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.radian = 7;
}

@end
