//
//  MarketPortCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketPortCell.h"

@implementation MarketPortCell

- (void)initUI{
    
    self.lz_setView.lz_shadow(6, rgba(255,142,1,0.1), CGSizeMake(0, 0), 0.7, 6);
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [UIImageView new];
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_subInfo = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(255,1,1)];
    UILabel *label_phone = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    UIImageView *moreIcon = [UIImageView viewWithImage:UIImageName(@"more_gray")];
    
    _imageView = imageView;
    _label_title = label_name;
    _label_info = label_phone;
    _label_subInfo = label_subInfo;
    _moreIcon = moreIcon;
    
    [self addSubview:imageView];
    [self addSubview:label_name];
    [self addSubview:label_subInfo];
    [self addSubview:label_phone];
    [self addSubview:moreIcon];
    
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
    
    [moreIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-20);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfClicked)];
    [self addGestureRecognizer:tap];
}

- (void)selfClicked{
    if (self.clickBlock) {
        self.clickBlock(self.label_title.text);
    }
}

@end
