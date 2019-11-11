//
//  MineKefuCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineKefuCell.h"

@implementation MineKefuCell

- (void)initUI{
    
    self.lz_setView.lz_shadow(6, rgba(255,142,1,0.1), CGSizeMake(0, 0), 0.7, 6);
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_subInfo = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(255,1,1)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    
    
    _imageView = imageView;
    _label_title = label_name;
    _label_info = label_phone;
    _label_subInfo = label_subInfo;
    
    [self addSubview:imageView];
    [self addSubview:label_name];
    [self addSubview:label_subInfo];
    [self addSubview:label_phone];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.centerX.mas_equalTo(self.mas_left).offset(39.5);
    }];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_centerY).offset(-5);
        make.left.mas_equalTo(75);
    }];
    
    [label_subInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name.mas_right).offset(4);
        make.centerY.mas_equalTo(label_name);
    }];
    
    [label_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(self.mas_centerY).offset(5);
    }];
    

    UIButton *copyBtn = [UIButton buttonWithFontSize:13 text:@"复制" textColor:rgb(255,0,0)];
    [self addSubview:copyBtn];
    
    [copyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_phone.mas_right).offset(10);
        make.centerY.mas_equalTo(label_phone);
        make.size.mas_equalTo(CGSizeMake(44, 18));
    }];
    
    copyBtn.lz_setView.lz_cornerRadius(2).lz_border(1, rgb(255,0,0));
    
    [copyBtn addTarget:self action:@selector(copyWechat) forControlEvents:UIControlEventTouchUpInside];
}

- (void)copyWechat{
    
    NSString *weixinNumber = [[NSUserDefaults standardUserDefaults] objectForKey:@"kefu_weixinNumber"];
    
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = weixinNumber;
    
    [SVProgressHUD showSuccessWithStatus:@"复制成功!"];
}
@end
