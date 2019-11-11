//
//  UserInfoShowView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "UserInfoShowView.h"
#import "MineInfoEditViewController.h"

//UserLevelButton
@implementation UserLevelButton

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.left = 6;
    self.imageView.size = CGSizeMake(14, 14);
    self.imageView.centerY = self.height/2;
    
    self.titleLabel.centerY = self.imageView.centerY;
    self.titleLabel.left = self.imageView.right+2;
}

@end

@interface UserInfoShowView ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UserLevelButton *btn;
@end

@implementation UserInfoShowView

- (void)initUI{
    
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(0);
    }];
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"" textColor:LZWhiteColor];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(10);
        make.top.mas_equalTo(imageView.mas_top).offset(5);
    }];
    
    //编辑
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [editBtn setImage:UIImageName(@"Edit_white") forState:UIControlStateNormal];
    [self addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label1.mas_right).offset(1);
        make.centerY.mas_equalTo(label1);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    UserLevelButton *btn = (UserLevelButton *)[UserLevelButton buttonWithFontSize:12 text:@"" textColor:rgb(101,101,101)];
    btn.backgroundColor = LZWhiteColor;
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(76);
        make.height.mas_equalTo(18);
        make.bottom.mas_equalTo(imageView.mas_bottom).offset(-1);
        make.left.mas_equalTo(label1);
    }];
    
    imageView.lz_setView.lz_cornerRadius(25).lz_border(1, LZWhiteColor);
    btn.lz_setView.lz_cornerRadius(9);
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"升级的不只是荣誉，更多的是收益" textColor:LZWhiteColor];
    label2.numberOfLines = 2;
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btn.mas_right).offset(10);
        make.centerY.mas_equalTo(btn);
        make.right.mas_equalTo(-20);
    }];
    
    _imageView = imageView;
    _titleLabel = label1;
    _subTitleLabel = label2;
    _btn = btn;
    _editBtn = editBtn;
    
    [btn addTarget:self action:@selector(levelBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
    
    //level
    [self getUserType];
    
    [RACObserve(CurrentUser, userLvl) subscribeNext:^(id  _Nullable x) {
        [self getUserType];
    }];
    
    [RACObserve(CurrentUser, nickUrl) subscribeNext:^(id  _Nullable x) {
        if (!IsNull(CurrentUser.nickUrl)) {
            [imageView sd_setImageWithURL:TLURL(CurrentUser.nickUrl)];
        }
    }];
}

- (void)getUserType{
    NSString *type = getRoleNameWithLZUserTypeAndLevel(CurrentUser.lzUserType,CurrentUser.userLvl);
    [_btn setTitle:type forState:UIControlStateNormal];
    
    NSString *icon = getRoleIconWithLevel(CurrentUser.userLvl);
    [_btn setImage:UIImageName(icon) forState:UIControlStateNormal];
    
    CGFloat w = [type tt_sizeWithFont:Font_PingFang_SC_Regular(12)].width + 30;
    [_btn mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(w);
    }];
}

- (void)toEditInfo{
    NewClass(vc, MineInfoEditViewController);
    PushController(vc);
}

- (void)levelBtnClick{
    
}

- (void)setShowEditBtn:(BOOL)showEditBtn{
    _editBtn.hidden = !showEditBtn;
}

- (void)setShowAbleInfo:(BOOL)showAbleInfo{
    _subTitleLabel.hidden = !showAbleInfo;
}
@end
