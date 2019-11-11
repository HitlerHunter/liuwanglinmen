//
//  MineDelegateTypeView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/15.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineDelegateTypeView.h"

@interface MineDelegateTypeView ()
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, strong) UIView *btnBgView;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIButton *selectedBtn;
@end

@implementation MineDelegateTypeView

- (void)initUI{
    self.backgroundColor = [UIColor clearColor];
    _buttonArray = [NSMutableArray array];
    
    _btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 147*LZScale)];
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    
    _bgView.backgroundColor = [UIColor blackColor];
    _btnBgView.backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_bgView];
    [self addSubview:_btnBgView];
    
    int count = 3;
    CGFloat btnW = 99*LZScale;
    CGFloat spacingX = (kScreenWidth -btnW*count)/(count+1);
    CGFloat spacingH = 19;
    CGFloat btnH = 45*LZScale;
    for (int i = 0; i<6; i++) {
        UIButton *btn = [UIButton buttonWithFontSize:17 text:nil textColor:LZWhiteColor];
        [btn setBackgroundColor:LZOrangeColor forState:UIControlStateSelected];
        [btn setBackgroundColor:rgb(152,152,152) forState:UIControlStateNormal];
        [btn setTitleColor:LZWhiteColor forState:UIControlStateSelected];
        
        btn.tag = 100 + i;
        
        CGFloat X = (i%count)*btnW+(i%count+1)*spacingX;
        CGFloat Y = (i/count)*btnH+(i/count+1)*spacingH;
        btn.frame = CGRectMake(X, Y, btnW, btnH);
        
        btn.lz_setView.lz_cornerRadius(5*LZScale);
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnBgView addSubview:btn];
        [self.buttonArray addObject:btn];
    }
    
    UITapGestureRecognizer *dismissTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissAnimation)];
    [self.bgView addGestureRecognizer:dismissTap];
    
    //默认
    UIButton *firstBtn = _buttonArray.firstObject;
    firstBtn.selected = YES;
    _selectedBtn = firstBtn;
    
    self.bgView.alpha = 0.0;
    self.btnBgView.bottom = 0;
}

- (void)setTitleArray:(NSArray *)titleArray{
    
    [_buttonArray enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL * _Nonnull stop) {
        btn.hidden = YES;
    }];
    
    for (int i = 0; i<titleArray.count; i++) {
        if (i < _buttonArray.count) {
            UIButton *btn = _buttonArray[i];
            btn.hidden = NO;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn setTitle:titleArray[i] forState:UIControlStateSelected];
        }
    }
}

- (void)btnClick:(UIButton *)btn{
    if (btn != _selectedBtn) {
        _selectedBtn.selected = NO;
        btn.selected = YES;
        _selectedBtn = btn;
        
        if (self.clickBlock) {
            self.clickBlock(btn.tag-100);
        }
    }
}

- (void)showAnimationWithSuperView:(UIView *)superView{
    
    [superView addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.7;
        self.btnBgView.top = 0;
    }];
    
}

- (void)showWithNoAnimation{
    
    self.bgView.alpha = 0.7;
    self.btnBgView.top = 0;
    
}

- (void)dismissAnimation{
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bgView.alpha = 0.0;
        self.btnBgView.bottom = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}


@end
