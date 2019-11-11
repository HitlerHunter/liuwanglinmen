//
//  MineInterfaceCell.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MineInterfaceCell.h"

@interface MineInterfaceCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *rightIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) void (^clickBlock)(void);
@end

@implementation MineInterfaceCell

+ (MineInterfaceCell *)cellWithImage:(NSString *)image title:(NSString *)title block:(void (^)(void))block{
    MineInterfaceCell *cell = [MineInterfaceCell new];
    cell.imageView.image = UIImageName(image);
    cell.titleLabel.text = title;
    cell.clickBlock = block;
    return cell;
}

- (void)initUI{
    
    UIImageView *imageView = [UIImageView new];
    [self addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(21, 21));
    }];
    
    UIImageView *rightIcon = [UIImageView new];
    rightIcon.image = UIImageName(@"more_gray");
    [self addSubview:rightIcon];
    [rightIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(6, 12));
    }];
    
    UILabel *label1 = [UILabel labelWithFont:Font_PingFang_SC_Bold(15) text:@"" textColor:rgb(53,53,53)];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(8);
        make.centerY.mas_equalTo(0);
    }];
    
    _imageView = imageView;
    _titleLabel = label1;
    _rightIcon = rightIcon;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapSelf)];
    [self addGestureRecognizer:tap];
    
    [self addBottomLine];
}

- (void)tapSelf{
    if (_clickBlock) {
        _clickBlock();
    }
}

@end
