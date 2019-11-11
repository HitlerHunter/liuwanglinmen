//
//  LZNoDataView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LZNoDataView.h"

@interface LZNoDataView ()
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation LZNoDataView


- (void)initUI{
    
    _offsetY = 10;
    
    UILabel *lab = [UILabel labelWithFontSize:15 textColor:rgb(152,152,152)];
    [self addSubview:lab];
    
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_centerY).offset(self.offsetY);
        make.centerX.mas_equalTo(self);
    }];
    
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(lab.mas_top).offset(-self.offsetY*2);
    }];
    
    _messageLabel = lab;
    _imageView = imageView;
}

- (void)setMessage:(NSString *)message{
    _message = message;
    
    _messageLabel.text = message;
}

- (void)setImage:(UIImage *)image{
    _image = image;
    _imageView.image = image;
}

- (void)setOffsetY:(CGFloat)offsetY{
    _offsetY = offsetY;
    
    [_messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_centerY).offset(offsetY);
    }];
    
}
@end
