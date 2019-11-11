//
//  MineSettingTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineSettingTopView.h"
#import "MineInfoEditViewController.h"

@implementation MineSettingTopView

- (void)initUI{
    
    self.backgroundColor = rgb(242,242,242);
    
    UIView *bgView = [UIView new];
    bgView.backgroundColor = LZWhiteColor;
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
    
    UIImageView *imageView = [UIImageView new];
    [bgView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(54, 54));
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    imageView.lz_setView.lz_cornerRadius(27);
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Medium(14) text:@"" textColor:rgb(53,53,53)];
    [bgView addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.bottom.mas_equalTo(imageView.mas_centerY).offset(-2);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"" textColor:rgb(152,152,152)];
    [bgView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.top.mas_equalTo(imageView.mas_centerY).offset(2);
    }];
    
    //编辑
    UIButton *editBtn = [UIButton buttonWithFontSize:13 text:@"编辑" textColor:rgb(255,81,0)];
    [bgView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(36, 18));
    }];
    editBtn.lz_setView.lz_cornerRadius(3).lz_border(0.5, rgb(255,81,0));
    
    [editBtn addTarget:self action:@selector(toEditInfo) forControlEvents:UIControlEventTouchUpInside];
    
    //avatar、name
    imageView.image = [AppCenter defaultAppAvatar];
    if (!IsNull(CurrentUser.nickUrl)) {
        [imageView sd_setImageWithURL:TLURL(CurrentUser.nickUrl)];
    }
    
    label1.text = CurrentUser.nickName;

    [RACObserve(CurrentUser, nickName) subscribeNext:^(id  _Nullable x) {
        label1.text = CurrentUser.nickName;
    }];
    
    
    [RACObserve(CurrentUser, nickUrl) subscribeNext:^(id  _Nullable x) {
        if (!IsNull(CurrentUser.nickUrl)) {
            [imageView sd_setImageWithURL:TLURL(CurrentUser.nickUrl)];
        }
    }];
    
    label2.text = [NSString stringWithFormat:@"会员ID：%@",CurrentUser.usrNo];
}

- (void)toEditInfo{
    NewClass(vc, MineInfoEditViewController);
    PushController(vc);
}

@end
