//
//  SYHomeTypeView.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/11.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SYHomeTypeView.h"

@interface SYHomeTypeMaker ()



@end

@implementation SYHomeTypeMaker

@end

@interface SYHomeTypeView ()
@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSMutableArray *btnArray;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIButton *selectedBtn;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) SYHomeTypeMaker *maker;
@end

@implementation SYHomeTypeView

- (SYHomeTypeMaker *)maker{
    if (!_maker) {
        _maker = [SYHomeTypeMaker new];
        _maker.spaceX = 27.0;
        _maker.firstItemSpaceX = 15;
        _maker.titleFontNormal = Font_PingFang_SC_Medium(14);
        _maker.titleColorNormal = rgb(101,101,101);
        _maker.titleColorSelected = rgb(255,81,0);
        _maker.lineColor = rgb(255,81,0);
        _maker.lineHeight = 5;
        _maker.lineWScale = 1.0;
        _maker.titleSelectedScale = 1.0;
        _maker.lineEdgeInsets = UIEdgeInsetsZero;
    }
    return _maker;
}

- (instancetype)initWithFrame:(CGRect)frame
                        maker:(void (^)(SYHomeTypeMaker *maker))maker{
    self = [super initWithFrame:frame];
    if (self) {
        
        if (maker) {
            maker(self.maker);
        }
        
        [self addSubview:self.scrollView];
        [self.scrollView addSubview:self.line];
        self.backgroundColor = LZWhiteColor;
    }
    return self;
}

- (void)initWithTitleArray:(NSArray *)array{
    _titleArray = array;
    
    CGFloat btnHeight = self.height*0.6;
    for (int i = 0; i < self.titleArray.count; i++) {
        
        NSString *title = self.titleArray[i];
        CGFloat titleW = [title tt_sizeWithFont:self.maker.titleFontNormal].width;
        if (titleW < self.maker.minItemW) {
            titleW =  self.maker.minItemW;
        }
        SDLog(@"titleW:%.2lf",titleW);
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.titleLabel.font = Font_PingFang_SC_Medium(14);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:self.maker.titleColorNormal forState:UIControlStateNormal];
        [btn setTitleColor:self.maker.titleColorSelected forState:UIControlStateSelected];
        
        if (i == 0) {
            btn.frame = CGRectMake(self.maker.firstItemSpaceX, 0, titleW, btnHeight);
            btn.centerY = self.height*0.5;
            btn.selected = YES;
            _selectedBtn = btn;
            
            CGFloat lineW = titleW*self.maker.lineWScale+self.maker.lineEdgeInsets.right;
            self.line.frame = CGRectMake(btn.left+(btn.width-lineW)*0.5+self.maker.lineEdgeInsets.left, btn.centerY+10+self.maker.lineEdgeInsets.top, lineW , self.maker.lineHeight+self.maker.lineEdgeInsets.bottom);
        }else{
            UIButton *lastBtn = self.btnArray.lastObject;
            btn.frame = CGRectMake(lastBtn.right+self.maker.spaceX, 0, titleW, btnHeight);
            btn.centerY = self.height*0.5;
        }
        
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.scrollView addSubview:btn];
        [self.btnArray addObject:btn];
    }
    
    UIButton *lastBtn = self.btnArray.lastObject;
    self.scrollView.contentSize = CGSizeMake(lastBtn.right+self.maker.firstItemSpaceX, 0);
    
}


- (void)btnClick:(UIButton *)btn{
    
    if (btn == self.selectedBtn) {
        return;
    }
    
    btn.selected = YES;
    _selectedBtn.selected = NO;
    _selectedBtn.transform = CGAffineTransformIdentity;
    _selectedBtn = btn;
    
    _selectedBtn.transform = CGAffineTransformMakeScale(_maker.titleSelectedScale, _maker.titleSelectedScale);

    CGFloat scrollToX = btn.centerX-self.width*0.5;

    
    if (scrollToX < 0) {
        scrollToX = 0.0;
    }else if (btn.centerX+self.width*0.5 > self.scrollView.contentSize.width) {
        scrollToX = self.scrollView.contentSize.width-self.width;
    }
    
    [self.scrollView setContentOffset:CGPointMake(scrollToX, 0) animated:YES];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.line.frame = CGRectMake(btn.centerX-self.line.width*0.5, self.line.top, self.line.width, self.line.height);
    }];
    
    if (_delegate && [_delegate respondsToSelector:@selector(view:clickBtnAtIndex:)]) {
        [_delegate view:self clickBtnAtIndex:[self.btnArray indexOfObject:btn]];
    }
}



- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.scrollEnabled = YES;
    }
    return _scrollView;
}

- (NSMutableArray *)btnArray{
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = self.maker.lineColor;
        _line.layer.cornerRadius = self.maker.lineHeight*0.5;
        _line.layer.masksToBounds = YES;
    }
    return _line;
}
@end
