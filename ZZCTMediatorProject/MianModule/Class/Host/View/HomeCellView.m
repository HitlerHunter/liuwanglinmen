//
//  HomeCellView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "HomeCellView.h"

@implementation HomeCellView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:UIImageName(@"shoukuan")];
    _imageView = imageView;
    [self addSubview:imageView];
    
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
   
    UILabel *lab2 = [UILabel labelWithFontSize:15 textColor:[UIColor blackColor] textAlignment:NSTextAlignmentCenter];
    lab2.text = @"收款码管理";
    _titleLabel = lab2;
    [self addSubview:lab2];
    
    [lab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(imageView.mas_right).offset(12);
        make.centerY.mas_equalTo(self);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)];
    [self addGestureRecognizer:tap];
}

- (void)click{
    
    if (_clickBlock) {
        _clickBlock();
    }
}
@end
