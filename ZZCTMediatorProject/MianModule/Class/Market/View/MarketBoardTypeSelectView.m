//
//  MarketBoardTypeSelectView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MarketBoardTypeSelectView.h"

@interface MarketBoardTypeSelectView ()
@property (nonatomic, strong) NSMutableArray *btnArray;
@end

@implementation MarketBoardTypeSelectView

- (void)initUI{
    
    self.backgroundColor = LZWhiteColor;
    
    UILabel *label_name = [UILabel labelWithFont:Font_PingFang_SC_Regular(16) text:@"请选择短信类型" textColor:rgb(53,53,53)];
    [self addSubview:label_name];
    _label_title = label_name;
    
    [label_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(18);
    }];
    
    
}

- (void)setTitleArray:(NSArray *)titleArray{
    _titleArray = titleArray;
    
    CGFloat btnW = 80;
    CGFloat btnH = 24;
    CGFloat spacingX = 10;
    
    _btnArray = [NSMutableArray array];
    UIView *lastView = nil;
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *btn = [UIButton buttonWithFontSize:14 text:titleArray[i] textColor:rgb(152,152,152)];
        [btn setTitleColor:LZWhiteColor forState:UIControlStateSelected];
        btn.tag = i+100;
        [self addSubview:btn];
        
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            if (lastView) {
                make.left.mas_equalTo(lastView.mas_right).offset(spacingX);
            }else{
                make.left.mas_equalTo(self.label_title);
            }
            make.size.mas_equalTo(CGSizeMake(btnW, btnH));
            make.top.mas_equalTo(self.label_title.mas_bottom).offset(15);
        }];
        btn.lz_setView.lz_cornerRadius(btnH*0.5).lz_border(1, rgb(152,152,152));
        
        lastView = btn;
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_btnArray addObject:btn];
    }
}

- (void)btnClick:(UIButton *)btn{
    btn.selected = YES;
    btn.layer.borderWidth = 0;
    [btn setDefaultGradientWithCornerRadius:12];
    
    [_btnArray enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj != btn) {
            [obj.gradientLayer removeFromSuperlayer];
            obj.layer.borderWidth = 1;
            obj.selected = NO;
        }
    }];
    
    _selectedTitle = btn.titleLabel.text;
    
    if (_delegate && [_delegate respondsToSelector:@selector(lz_view:atIndex:title:)]) {
        NSInteger index = btn.tag - 100;
        [_delegate lz_view:self atIndex:index title:_selectedTitle];
    }
}

- (void)selectBtnAtIndex:(NSInteger)index{
    
    UIButton *btn = [self.btnArray safeObjectWithIndex:index];
    
    [self btnClick:btn];
}

- (void)setSelectedTitle:(NSString *)selectedTitle{
    _selectedTitle = selectedTitle;
    
    if ([self.titleArray containsObject:selectedTitle]) {
        NSInteger index = [self.titleArray indexOfObject: selectedTitle];
        [self selectBtnAtIndex:index];
    }
}
@end
