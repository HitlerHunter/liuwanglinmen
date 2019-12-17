//
//  NoMoreOrderView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NoMoreOrderView.h"

@interface NoMoreOrderView ()

@property (nonatomic, strong) UIImageView *icon;
@end

@implementation NoMoreOrderView

- (void)initUI{
    
    _textLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"没有更多订单哦" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    
    _btn = [UIButton buttonWithFontSize:16 text:@"去逛逛" textColor:rgb(53,53,53)];
    _btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _icon = [UIImageView viewWithImage:UIImageName(@"gengduo1")];
    
    [self addSubview:_textLabel];
    [self addSubview:_icon];
    [self addSubview:_btn];
    
    [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).offset(-30);
    }];
    
    [_icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.textLabel.mas_bottom).offset(3);
        make.left.mas_equalTo(self.textLabel.mas_right).offset(6);
    }];
    
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.icon);
        make.right.mas_equalTo(self.textLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    @weakify(self);
    [_btn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock();
        }
    }];
}

@end
