//
//  MineInfoEditStyle1Cell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineInfoEditStyle1Cell.h"

@interface MineInfoEditStyle1Cell ()

@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) void (^clickBlock)(void);
@end

@implementation MineInfoEditStyle1Cell

+ (MineInfoEditStyle1Cell *)cellWithTitle:(NSString *)title
                                    vaule:(NSString *)vaule
                                    block:(void (^)(void))block{
    
    MineInfoEditStyle1Cell *cell = [MineInfoEditStyle1Cell new];
    cell.titleLabel.text = title;
    cell.valueLabel.text = vaule;
    cell.clickBlock = block;
    return cell;
}

- (void)initUI{
    
    UIImageView *rightIcon = [UIImageView new];
    rightIcon.image = UIImageName(@"more_gray");
    [self addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(6, 12));
    }];
    
    //title
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"" textColor:rgb(53,53,53)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    //value
    UILabel *label2 = [UILabel labelWithFont:Font_PingFang_SC_Bold(14) text:@"" textColor:rgb(152,152,152)];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(92);
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(0);
    }];
    
    _titleLabel = label1;
    _valueLabel = label2;
    _rightIcon = rightIcon;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
    [self addGestureRecognizer:tap];
    
    [self addTopLine];
    [self setTopLineX:15];
}

- (void)tapSelf{
    if (_clickBlock) {
        _clickBlock();
    }
}

- (void)setShowMoreIcon:(BOOL)showMoreIcon{
    _rightIcon.hidden = !showMoreIcon;
}

@end
