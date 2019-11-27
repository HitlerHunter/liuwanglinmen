//
//  MerchantManagerTopView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/22.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MerchantManagerTopView.h"

@interface MerchantManagerTopView ()

@end

@implementation MerchantManagerTopView

-(void)initUI{
    
    self.backgroundColor = LZBackgroundColor;
    
    SDBaseView *bgView = [SDBaseView new];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 70, 0));
    }];
    [bgView setDefaultGradient];
    bgView.radian = 10;
    
    MerchantManagerCardView *cardView = [MerchantManagerCardView new];
    [self addSubview:cardView];
    [cardView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(116);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-35);
    }];
    cardView.lz_setView.lz_shadow(6, rgba(255, 81, 0, 0.14), CGSizeMake(0, 2), 1, 5);
    _cardView = cardView;
    
     UILabel *lab1 = [UILabel labelWithFontSize:12 text:@"直推商户数:" textColor:rgb(152,152,152)];
    [self addSubview:lab1];
    [lab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cardView);
        make.bottom.mas_equalTo(-10);
    }];
    _lab_number = lab1;
}

@end
