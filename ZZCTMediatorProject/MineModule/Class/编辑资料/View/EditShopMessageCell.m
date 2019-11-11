//
//  EditShopMessageCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "EditShopMessageCell.h"
#import "CMInputView.h"

@implementation EditShopMessageCell

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    UILabel *title_label = [UILabel labelWithFont:Font_PingFang_SC_Regular(14) text:@"店铺描述" textColor:rgb(101,101,101)];
    [self addSubview:title_label];
    [title_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(12);
        make.height.mas_equalTo(16);
    }];

    _title_label = title_label;
    
    [self initBoardInfoView];
}

- (void)initBoardInfoView{
    
    UIView *inputBgView = [UIView new];
    inputBgView.backgroundColor = rgb(238,238,238);
    [self addSubview:inputBgView];
    
    [inputBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(43);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(120);
    }];
    
        //输入框
    CMInputView *inputView = [[CMInputView alloc] initWithFrame:CGRectMake(0, 5, kScreenWidth-30, 100)];
    inputView.backgroundColor = rgb(238,238,238);
    inputView.placeholder = @"请输入100字以内店铺描述";
    inputView.placeholderFont = Font_PingFang_SC_Medium(14);
    inputView.font = Font_PingFang_SC_Medium(14);
    inputView.placeholderColor = rgb(152,152,152);
    inputView.maxTextNumber = 100;
    
    _textView = inputView;
    [inputBgView addSubview:inputView];
    
    [inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
        //字数
    NSString *maxNumber = [NSString stringWithFormat:@"%ld",self.textView.maxTextNumber];
    
    UILabel *labMax = [UILabel labelWithFontSize:14 text:[NSString stringWithFormat:@"/%@",maxNumber] textAlignment:NSTextAlignmentRight];
    labMax.textColor = rgb(101,101,101);
    [inputBgView addSubview:labMax];
    [labMax mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:14 text:@"0" textAlignment:NSTextAlignmentRight];
    lab.textColor = rgb(255,81,0);
    _numberLabel = lab;
    [inputBgView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.right.mas_equalTo(labMax.mas_left);
        make.height.mas_equalTo(20);
    }];
    
    @weakify(self);
    inputView.textValueDidChanged = ^(NSString *text) {
        @strongify(self);
        self.numberLabel.text = [NSString stringWithFormat:@"%ld",self.textView.text.length];
    };
}

- (void)setText:(NSString *)text{
    _textView.text = text;
}

- (NSString *)text{
    return _textView.text;
}

@end
