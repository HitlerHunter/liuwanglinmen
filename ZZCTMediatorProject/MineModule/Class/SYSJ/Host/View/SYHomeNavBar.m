//
//  SYHomeNavBar.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeNavBar.h"

@interface SYHomeNavBar ()

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation SYHomeNavBar

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    
    UILabel *titleLabel = [UILabel labelWithFont:Font_PingFang_SC_Bold(16) text:@"我的收益" textColor:rgb(254,254,254)];
    _titleLabel = titleLabel;
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8);
        make.centerX.mas_equalTo(self);
    }];
    
    //定制左按钮
    SDBaseItemBtn *but = [SDBaseItemBtn buttonWithType:UIButtonTypeCustom];
    but.imageEdgeInsets = UIEdgeInsetsMake(5, -10, -5, 10);
    
    [but setImage:UIImageName(@"back_white") forState:UIControlStateNormal];
    [self addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 44));
    }];
    
    @weakify(self);
    [but addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}


- (void)setProgress:(CGFloat)progress{
    _progress = progress;
    
    self.alpha = 1-progress;
    
}

@end
