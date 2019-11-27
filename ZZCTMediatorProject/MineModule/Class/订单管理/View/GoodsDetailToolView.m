//
//  GoodsDetailToolView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "GoodsDetailToolView.h"

@interface GoodsDetailToolView ()

@end

@implementation GoodsDetailToolView

- (void)initUI{
    
    UIView *leftView = [UIView new];
    [self addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    UIImageView *imageV = [UIImageView viewWithImage:UIImageName(@"GoodsDetail_call")];
    [leftView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(5);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(23, 17));
    }];
    
    UILabel *lab = [UILabel labelWithFontSize:10 text:@"联系客服" textAlignment:NSTextAlignmentCenter];
    [leftView addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-5);
        make.centerX.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
    }];
    
    UIButton *btn = [UIButton buttonWithFontSize:16 text:@"立即购买" textColor:LZWhiteColor];
    [self addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-8);
        make.top.mas_equalTo(8);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(85);
    }];
    [btn setDefaultGradientWithCornerRadius:20];
    
    [btn addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(callKeFu)];
    [leftView addGestureRecognizer:tap];
}

- (void)callKeFu{
    [AppCenter callKeFu];
}

- (void)buy{
    if (self.buyBlock) {
        self.buyBlock();
    }
}

@end
