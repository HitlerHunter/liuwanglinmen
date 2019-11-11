//
//  LZLodingButton.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/5/8.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "LZLodingButton.h"

@interface LZLodingButton ()

@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
@property (nonatomic, assign) BOOL hasInit;
@end

@implementation LZLodingButton

- (void)dealloc{
    [_activityIndicator stopAnimating];
}

- (void)configInit{
    
    if (!_hasInit) {
        _hasInit = YES;
        self.loadState = LZLodingButtonStateNormal;
        [self addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
}

- (void)configText:(NSString *)text
        loadingText:(NSString *)loadingText{
    
    [self configColor:LZLodingBtnNormalColor
         loadingColor:LZMianBtnDisableColor
        disabledColor:LZMianBtnDisableColor
                 text:text
          loadingText:loadingText
                 font:kfont(20)
            textColor:LZWhiteColor];
}

- (void)configColor:(UIColor *)color
       loadingColor:(UIColor *)loadingColor
       disabledColor:(UIColor *)disabledColor
               text:(NSString *)text
        loadingText:(NSString *)loadingText
               font:(UIFont *)font
          textColor:(UIColor *)textColor{
    
    [self configInit];
    
    [self setBackgroundColor:color forState:UIControlStateNormal];
    [self setBackgroundColor:disabledColor forState:UIControlStateDisabled];
    
    [self setTitle:text forState:UIControlStateNormal];
    [self setTitleColor:textColor forState:UIControlStateNormal];
    
    self.normalBackGroundColor = color;
    self.loadingBackGroundColor = loadingColor;
    self.disabledColor = disabledColor;
    
    self.normalText = text;
    self.loadingText = loadingText;
    
    if (font) {
        self.titleLabel.font = font;
    }else{
        self.titleLabel.font = kfont(16);
    }
}

- (void)loading{
    
    [self setTitle:self.loadingText forState:UIControlStateNormal];
    
    if (!_activityIndicator) {
        [self addSubview:self.activityIndicator];
    }
    
    [_activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.titleLabel.mas_left).offset(-15);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    self.loadState = LZLodingButtonStateLoading;
    [self setBackgroundColor:self.loadingBackGroundColor forState:UIControlStateNormal];
    
    [self.activityIndicator startAnimating];
}

- (void)stopLoading{
    [_activityIndicator stopAnimating];
    [self setBackgroundColor:self.normalBackGroundColor forState:UIControlStateNormal];
    [self setTitle:self.normalText forState:UIControlStateNormal];
    self.loadState = LZLodingButtonStateNormal;
}

- (void)buttonClick:(id)sender{
    
    if (self.loadState == LZLodingButtonStateNormal) {
        if (_clickReturn) {
            _clickReturn(self);
        }
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

- (UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        _activityIndicator.frame= CGRectMake(0, 0, 10, 10);
        _activityIndicator.color = [UIColor whiteColor];
        _activityIndicator.backgroundColor = [UIColor clearColor];
    }
    return _activityIndicator;
}
@end
