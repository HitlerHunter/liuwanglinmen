//
//  HomeTopToolView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "HomeTopToolView.h"
#import "HomeToolItem.h"

@implementation HomeTopToolView

- (void)initUI{
    
    CGSize itemSize = CGSizeMake(41, 63);
    
    HomeToolItem *item1 = [[HomeToolItem alloc] init];
    item1.titleLab.textColor = LZWhiteColor;
    item1.titleLab.text = @"收款";
    item1.imgView.image = UIImageName(@"shoukuan");
    [self addSubview:item1];
    
    HomeToolItem *item2 = [[HomeToolItem alloc] init];
    item2.titleLab.textColor = LZWhiteColor;
    item2.titleLab.text = @"扫码";
    item2.imgView.image = UIImageName(@"home_scan");
    [self addSubview:item2];
    
    HomeToolItem *item3 = [[HomeToolItem alloc] init];
    item3.titleLab.textColor = LZWhiteColor;
    item3.titleLab.text = @"统计";
    item3.imgView.image = UIImageName(@"tongji");
    [self addSubview:item3];
    
    [item2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self);
        make.size.mas_equalTo(itemSize);
    }];
    
    [item1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(item2);
        make.size.mas_equalTo(itemSize);
        make.right.mas_equalTo(item2.mas_left).offset(-70*LZScale);
    }];
    
    [item3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(item2);
        make.size.mas_equalTo(itemSize);
        make.left.mas_equalTo(item2.mas_right).offset(70*LZScale);
    }];
    
    [self setDefaultGradientWithCornerRadius:4];
    
    @weakify(self);
    [item1 addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock(0);
        }
    }];
    
    
    [item2 addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock(1);
        }
    }];
    
    [item3 addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.clickBlock) {
            self.clickBlock(2);
        }
    }];
}

@end
