//
//  GoodsCountSelectView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/13.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "GoodsCountSelectView.h"

@interface GoodsCountSelectView ()
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UILabel *numberLabel;

@property (nonatomic, assign) CGFloat minWidth;
@property (nonatomic, assign) CGFloat maxWidth;
@end

@implementation GoodsCountSelectView


- (void)initUI{
    
    _minWidth = 30;
    _maxWidth = 40;
    
    _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_leftBtn setBackgroundImage:UIImageName(@"jian") forState:UIControlStateNormal];
    [_leftBtn addTarget:self action:@selector(reduce) forControlEvents:UIControlEventTouchUpInside];
    
    
    _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_rightBtn setBackgroundImage:UIImageName(@"jia") forState:UIControlStateNormal];
    [_rightBtn addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
    
    _numberLabel = [UILabel labelWithFont:Font_PingFang_SC_Regular(15) text:nil textColor:rgb(51,51,51) textAlignment:NSTextAlignmentCenter];
    
    [self addSubview:_numberLabel];
    [self addSubview:_rightBtn];
    [self addSubview:_leftBtn];
    
    [_numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.height.mas_equalTo(21);
        make.width.mas_equalTo(30);
    }];
    
    [_rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numberLabel);
        make.left.mas_equalTo(self.numberLabel.mas_right);
    }];
    
    [_leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.numberLabel);
        make.right.mas_equalTo(self.numberLabel.mas_left);
    }];
    
    _minCount = 1;
    _maxCount = 10000;
    self.count = _minCount;
    
}

- (void)reduce{
    
    if (self.count == _minCount) {
        
        return;
    }
    
    self.count -= 1;
    if (self.countDidChangeBlock) {
        self.countDidChangeBlock(self.count);
    }
}

- (void)add{
    
    if (self.count >= _maxCount) {
        self.count = _maxCount;
        return;
    }
    
    self.count += 1;
    if (self.countDidChangeBlock) {
        self.countDidChangeBlock(self.count);
    }
}

- (void)setCount:(NSUInteger)count{
    _count = count;
    
    self.numberLabel.text = [NSString stringWithFormat:@"%ld",count];
    
    if (count > 99 && _numberLabel.width < self.maxWidth) {
        [_numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.maxWidth, 16));
        }];
    }else if(_numberLabel.width > self.minWidth){
        [_numberLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(self.minWidth, 16));
        }];
    }
}
@end
