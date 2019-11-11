//
//  LevelUpSelecteCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/16.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "LevelUpSelecteCell.h"

@implementation LevelUpSelecteCell

+ (LevelUpSelecteCell *)cellWithTitle:(NSString *)title
                          placeholder:(NSString *)placeholder
                                block:(void (^)(void))block{
    LevelUpSelecteCell *cell = [LevelUpSelecteCell new];
    cell.label_title.text = title;
    cell.label_text.text = placeholder;
    cell.block = block;
    return cell;
};

- (void)initUI{
    self.backgroundColor = rgb(238,238,238);
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(16) text:@"地区" textColor:rgb(18,18,18)];
    [self addSubview:label_title];
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
    }];
    
    UILabel *label_text = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"请选择所在地区" textColor:rgb(152,152,152)];
    [self addSubview:label_text];
    [label_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(65);
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
    }];
    
    
    UIImageView *rightIcon = [UIImageView new];
    rightIcon.image = UIImageName(@"more_gray");
    [self addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label_text.mas_right).offset(5);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(6, 12));
    }];
    
    self.lz_setView.lz_cornerRadius(3);
    
    _label_title = label_title;
    _label_text = label_text;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfClick)];
    [self addGestureRecognizer:tap];
}

- (void)selfClick{
    if (_block) {
        _block();
    }
}

@end
