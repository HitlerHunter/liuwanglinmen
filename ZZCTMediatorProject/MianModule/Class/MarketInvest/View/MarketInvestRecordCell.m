//
//  MarketInvestRecordCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/20.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketInvestRecordCell.h"

@interface MarketInvestRecordCell ()

@property (nonatomic, strong) CALayer *line_top;
@property (nonatomic, strong) CALayer *line_bottom;
@property (nonatomic, strong) CALayer *point;
@end

@implementation MarketInvestRecordCell

- (void)initUI{
    self.backgroundColor = LZBackgroundColor;
    
    [self addLeftLineView];
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(53,53,53)];
    UILabel *label_time = [UILabel labelWithFont:Font_PingFang_SC_Medium(13) text:@"" textColor:rgb(152,152,152)];
    UILabel *label_money = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"" textColor:rgb(255,81,0)];
    
    _label_title = label_name;
    _label_info = label_time;
    _label_money = label_money;
    
    [self.contentView addSubview:label_name];
    [self.contentView addSubview:label_time];
    [self.contentView addSubview:label_money];
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.left.mas_equalTo(75);
    }];
    
    [label_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_name);
        make.top.mas_equalTo(label_name.mas_bottom).offset(5);
    }];
    
    [label_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-45);
        make.centerY.mas_equalTo(label_name.mas_bottom);
    }];
}

- (void)addLeftLineView{
    
    [self.layer addSublayer:self.line_top];
    [self.layer addSublayer:self.line_bottom];
    
    
    CALayer *point = [self line];
    point.backgroundColor = rgb(255,81,0).CGColor;
    point.cornerRadius = 8;
    point.masksToBounds = YES;
    [self.layer addSublayer:point];
    _point = point;
}

- (void)isHiddenTopLine:(BOOL)isHidden{
    self.line_top.hidden = isHidden;
    self.line_bottom.hidden = !isHidden;
}

- (void)originalLine{
    self.line_top.hidden = NO;
    self.line_bottom.hidden = NO;
}

- (CALayer *)line{
    CALayer *line = [CALayer layer];
    line.backgroundColor = rgb(251,248,248).CGColor;
    return line;
}

- (CALayer *)line_top{
    if (!_line_top) {
        _line_top = [self line];
    }
    return _line_top;
}

- (CALayer *)line_bottom{
    if (!_line_bottom) {
        _line_bottom = [self line];
    }
    return _line_bottom;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    CGFloat specingX = 45;
    
    self.line_top.frame = CGRectMake(specingX, 0, 2, self.height*0.5);
    self.line_bottom.frame = CGRectMake(specingX, self.height*0.5, 2, self.height*0.5);
    _point.frame = CGRectMake(specingX-7, self.height*0.5-8, 16, 16);
}

@end
