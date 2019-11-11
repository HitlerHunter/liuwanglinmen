//
//  CouponDetailTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/31.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "CouponDetailTopView.h"

@interface CouponDetailTopView ()

@property (nonatomic, strong) UILabel *label_1;
@property (nonatomic, strong) UILabel *label_2;
@end

@implementation CouponDetailTopView

- (void)initUI{
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_1];
    
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(self).multipliedBy(0.5);
    }];
    
    UILabel *label_2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(18) text:@"" textColor:rgb(53,53,53) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_2];
    
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_1);
        make.left.mas_equalTo(label_1.mas_right);
        make.right.mas_equalTo(self);
    }];
    
    UILabel *label_3 = [UILabel labelWithFont:Font_PingFang_SC_Medium(11) text:@"已领取" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(label_1.mas_bottom);
        make.centerX.mas_equalTo(label_1);
    }];
    
    UILabel *label_4 = [UILabel labelWithFont:Font_PingFang_SC_Medium(11) text:@"已核销" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_4];
    [label_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(label_3);
        make.centerX.mas_equalTo(label_2);
    }];
    
    _label_1 = label_1;
    _label_2 = label_2;
    
    UIView *view1 = [UIView new];
    view1.backgroundColor = LZBackgroundColor;
    [self addSubview:view1];
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(37);
    }];
    
    UILabel *label_5 = [UILabel labelWithFont:Font_PingFang_SC_Medium(11) text:@"详细数据" textColor:rgb(152,152,152) textAlignment:NSTextAlignmentCenter];
    [self addSubview:label_5];
    [label_5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(-10);
    }];
}

- (void)setHasUsedNumber:(NSInteger)hasUsedNumber{
    _label_2.text = [NSString stringWithFormat:@"%ld",hasUsedNumber];
}

- (void)setHasReceivedNumber:(NSInteger)hasReceivedNumber{
    _label_1.text = [NSString stringWithFormat:@"%ld",hasReceivedNumber];
}

@end
