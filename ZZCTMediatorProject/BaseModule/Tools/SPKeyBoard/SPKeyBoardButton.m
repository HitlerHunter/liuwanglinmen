//
//  SPKeyBoardButton.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SPKeyBoardButton.h"

@interface SPKeyBoardButton ()
@property (nonatomic, strong) UIView *line;
@end

@implementation SPKeyBoardButton

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = kfont(25);
        self.backgroundColor = LZKeyBoardBtnBGColor;
//        _line = [[UIView alloc] init];
//        _line.backgroundColor = LZKeyBoardTitleColor;
//        [self addSubview:_line];
    }
    return self;
}

- (void)setValue:(NSString *)value{
    _value = value;
    
    [self setTitle:value forState:UIControlStateNormal];
    [self setTitleColor:LZKeyBoardTitleColor forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    if (self.direction == ContentDirectionCenter) {
        self.titleLabel.center = CGPointMake(self.width*0.5, self.height*0.5);
    }else if (self.direction == ContentDirectionLeft) {
        self.titleLabel.center = CGPointMake(self.width/4.0, self.height*0.5);
    }
    
//    self.line.frame = CGRectMake(self.titleLabel.left, self.titleLabel.bottom-3, self.titleLabel.width, 1);
}

@end
