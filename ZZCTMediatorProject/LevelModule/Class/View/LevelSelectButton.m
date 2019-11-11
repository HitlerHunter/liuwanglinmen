//
//  LevelSelectButton.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/11.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelSelectButton.h"

@interface LevelSelectButton ()

@property (nonatomic, strong) UIView *line;
@end

@implementation LevelSelectButton

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"VIP" textColor:LZWhiteColor];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(18);
    }];
    
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Medium(12) text:@"专享权益" textColor:LZWhiteColor];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(33);
        make.height.mas_equalTo(18);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = LZWhiteColor;
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.width.mas_equalTo(92);
        make.height.mas_equalTo(1);
        make.centerX.mas_equalTo(0);
    }];
    line.lz_setView.lz_cornerRadius(25);
    
    _titleLabel2 = label1;
    _line = line;
}

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
    _line.hidden = !selected;
    
    if (selected) {
        _titleLabel2.transform = CGAffineTransformMakeScale(1.2, 1.2);
    }else{
        _titleLabel2.transform = CGAffineTransformIdentity;
    }
    
}

@end
