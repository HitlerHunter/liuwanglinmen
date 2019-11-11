//
//  DataCollectionNavBar.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/28.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataCollectionNavBar.h"

@implementation DataCollectionNavBar

- (void)initUI{
    
    UIView *bgView = [UIView new];
    [self addSubview:bgView];
    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *label_title = [UILabel labelWithFont:Font_PingFang_SC_Medium(18) text:@"统计" textColor:LZWhiteColor];
    [bgView addSubview:label_title];
    
    [label_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(bgView);
    }];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    [btn setImage:UIImageName(@"back_white") forState:UIControlStateNormal];
    
    [bgView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.left.mas_equalTo(10);
        make.size.mas_equalTo(CGSizeMake(60, 44));
    }];
    
    UIButton *btn_right = [UIButton buttonWithFontSize:13 text:@"全部收银员" textColor:LZWhiteColor];
    btn_right.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _rightBtn = btn_right;
    
    [bgView addSubview:btn_right];
    [btn_right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bgView);
        make.right.mas_equalTo(-10);
    }];
    
    @weakify(self);
    [btn addTouchAction:^(UIButton *sender) {
        @strongify(self);
        [self.topViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [btn_right addTouchAction:^(UIButton *sender) {
        @strongify(self);
        if (self.rightBtnBlock) {
            self.rightBtnBlock(self.rightBtn);
        }
    }];
}

- (void)setRightTitle:(NSString *)rightTitle{
    _rightTitle = rightTitle;
    
    [_rightBtn setTitle:rightTitle forState:UIControlStateNormal];
    
}

@end
