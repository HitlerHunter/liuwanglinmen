//
//  HomeToolItem.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/6/30.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "HomeToolItem.h"

@implementation HomeToolItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLab = [UILabel labelWithFontSize:13 textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.titleLab];
        
        self.imgView = [UIImageView new];
        [self addSubview:self.imgView];
        
        self.messageLabel = [UILabel labelWithFontSize:8 textColor:LZWhiteColor textAlignment:NSTextAlignmentCenter];
        [self addSubview:self.messageLabel];
        self.messageLabel.backgroundColor = UIColorHex(0xD82222);
        
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self);
            make.height.mas_equalTo(13);
        }];
        
        [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.titleLab.mas_top).offset(-9);
            make.centerX.mas_equalTo(self);
        }];
        
        [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.imgView.mas_right);
            make.centerY.mas_equalTo(self.imgView.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(30, 14));
        }];
        
        self.messageLabel.lz_setView.lz_cornerRadius(3);
        self.messageLabel.hidden = YES;
    }
    
    return self;
}

- (void)setMessage:(NSString *)message{
    if (message.length == 0) {
        self.messageLabel.hidden = YES;
    }else{
        self.messageLabel.hidden = NO;
        self.messageLabel.text = message;
    }
}
@end
