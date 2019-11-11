//
//  SPKeyBoard.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "SPKeyBoard.h"
#import "SPKeyBoardButton.h"
#import "SPKeyBoardSureButton.h"

//键盘

#define LZKeyBoardBGColor UIColorHex(0xE5E5E5)

#define LZKeyBoardDeleteBGColor [UIColor blackColor]
#define LZKeyBoardTextColor UIColorHex(0xC63B33)
#define LZKeyBoardPlaceholderColor [LZKeyBoardTextColor colorWithAlphaComponent:0.8];
#define LZKeyBoardSureColor rgb(255,81,0)

@interface SPKeyBoard ()
@property (nonatomic, strong) UIView *numberView;
@property (nonatomic, strong) UIView *rightView;
@property (nonatomic, strong) UIButton *deleteBtn;
@property (nonatomic, strong) SPKeyBoardButton *clearBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UIView *bgView;
/**输入为空*/
@property (nonatomic, assign, readonly) BOOL isEmpty;

@property (nonatomic, strong) NSArray *numberArray;

@property (nonatomic, assign) CGFloat spacing;
@property (nonatomic, assign) CGFloat btnH;
@end

@implementation SPKeyBoard

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self config];
    [self setUpKeyBoard];
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self config];
        [self setUpKeyBoard];
    }
    return self;
}


- (void)config{
    _placeholder = @"0.00";
    _placeholderColor = LZKeyBoardPlaceholderColor;
    _textColor = LZKeyBoardTextColor;
    _maxValue = 1000000.00;
    _minValue = 0.00;
    _sureBtnColor = LZOrangeColor;
    _sureBtnEmptyColor = _sureBtnColor;
    _sureText = @"扫码收款";
    
    _spacing = 1;
    _btnH = (self.height - _spacing*3) * 0.25;
}

- (void)setUpKeyBoard{
    
    [self initNumberView];
    [self initRightView];
    
}

- (void)initNumberView{
    
    
    CGFloat numberViewWidth = self.width  * 0.75 + _spacing*2;
    CGFloat btnW = (numberViewWidth - _spacing*2) / 3.0;
    
    _numberView = [UIView new];
    _numberView.backgroundColor = LZKeyBoardBGColor;
    [self addSubview:_numberView];
    
    [_numberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.width.mas_equalTo(numberViewWidth);
    }];
    
    UIView *lastLeftView = self;
    UIView *lastTopView = self;
    
    for (int i = 0; i < self.numberArray.count; i++) {
        
        NSString *str = self.numberArray[i];
        
        SPKeyBoardButton *btn = [SPKeyBoardButton buttonWithType:UIButtonTypeCustom];
        btn.value = str;
        btn.index = i;
        
        [btn addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_numberView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            if (lastLeftView == self) {
                make.left.mas_equalTo(self);
            }else{
                make.left.mas_equalTo(lastLeftView.mas_right).offset(self.spacing);
            }
            
            if (lastTopView == self) {
                make.top.mas_equalTo(self);
            }else{
                make.top.mas_equalTo(lastTopView.mas_bottom).offset(self.spacing);
            }
            
            make.size.mas_equalTo(CGSizeMake(btnW, self.btnH));
        }];
        
        lastLeftView = btn;
        
        if ((i+1)%3 == 0) {
            lastLeftView = self;
            lastTopView = btn;
        }
        
    }
    
    //0
    NSString *str = @"0";
    SPKeyBoardButton *btnZero = [SPKeyBoardButton buttonWithType:UIButtonTypeCustom];
    btnZero.direction = ContentDirectionLeft;
    btnZero.value = str;
    btnZero.index = self.numberArray.count;
    
    [btnZero addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_numberView addSubview:btnZero];
    [btnZero mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.top.mas_equalTo(lastTopView.mas_bottom).offset(self.spacing);
        make.size.mas_equalTo(CGSizeMake(btnW*2+self.spacing, self.btnH));
    }];
    lastLeftView = btnZero;
    
    //.
    NSString *str1 = @".";
    SPKeyBoardButton *btnPoint = [SPKeyBoardButton buttonWithType:UIButtonTypeCustom];
    btnPoint.value = str1;
    btnPoint.index = self.numberArray.count;
    
    [btnPoint addTarget:self action:@selector(numberBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [_numberView addSubview:btnPoint];
    [btnPoint mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(btnZero.mas_right).offset(self.spacing);
        make.top.mas_equalTo(lastTopView.mas_bottom).offset(self.spacing);
        make.size.mas_equalTo(CGSizeMake(btnW, self.btnH));
    }];
    lastLeftView = btnPoint;
}

- (void)initRightView{
    
    
    _rightView = [UIView new];
    _rightView.backgroundColor = _numberView.backgroundColor;
    [self addSubview:_rightView];
    
    [_rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.left.mas_equalTo(self.numberView.mas_right);
        make.bottom.mas_equalTo(self);
    }];
    
    _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_deleteBtn setImage:UIImageName(@"delete_sk") forState:UIControlStateNormal];
    [_deleteBtn setBackgroundColor:LZKeyBoardBtnBGColor forState:UIControlStateNormal];
    
    [_rightView addSubview:_deleteBtn];
    
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self.rightView);
        make.left.mas_equalTo(self.spacing);
        make.height.mas_equalTo(self.btnH);
    }];
    
    
    _sureBtn = [SPKeyBoardSureButton new];
    _sureBtn.titleLabel.font = kfont(13);
    [_sureBtn setTitle:_sureText forState:UIControlStateNormal];
    _sureBtn.titleLabel.numberOfLines = 2;
    [_sureBtn setImage:UIImageName(@"scan_sk") forState:UIControlStateNormal];
    [_sureBtn setButtonImagePosition:TLButtonImagePositionTop spacing:17];
    
    [_sureBtn setBackgroundColor:_sureBtnColor forState:UIControlStateNormal];
    [_sureBtn setBackgroundColor:_sureBtnEmptyColor forState:UIControlStateDisabled];
    [_rightView addSubview:_sureBtn];
    
    [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.deleteBtn.mas_bottom);
        make.bottom.left.right.mas_equalTo(self.rightView);
    }];
    
    [_deleteBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_sureBtn addTarget:self action:@selector(functionBtnClick:) forControlEvents:UIControlEventTouchUpInside];

}



- (void)setInputView:(UILabel *)inputView{
    _inputView = inputView;
    
    self.textColor = inputView.textColor;
    self.placeholderColor = [inputView.textColor colorWithAlphaComponent:0.8];
    
    inputView.text = _placeholder;
    
    self.sureBtn.enabled = NO;
}


- (void)numberBtnClick:(SPKeyBoardButton *)btn{
    
    NSString *lastText = self.inputView.text;
    
    if (!self.isEmpty) {
        if ([btn.value isEqualToString:@"."]) {
            if ([lastText containsString:@"."]) {
                return;//防止两个 点 存在
            }
        }
        
        if ([btn.value isEqualToString:@"+"]) {
            double value = lastText.doubleValue + 1;
            if (value > _maxValue) {
                return;
            }
            self.inputView.text = [NSString stringWithFormat:@"%.2lf",value];
            self.sureBtn.enabled = YES;
            return;
        }
        
        NSString *nextStr = [NSString stringWithFormat:@"%@%@",lastText,btn.value];
        
        if ([lastText containsString:@"."]) {
            NSString *pointStr = [nextStr componentsSeparatedByString:@"."].lastObject;
            if (pointStr.length > 2) {
                return;//小数点2位
            }
        }
        
        if (nextStr.doubleValue > _maxValue) {
            return;
        }
        if ([nextStr isEqualToString:_placeholder]) {
            self.inputView.textColor = _placeholderColor;
            self.inputView.text = _placeholder;
            self.sureBtn.enabled = NO;
            return;
        }
        
        self.inputView.text = nextStr;
        //值为0
        self.sureBtn.enabled = nextStr.doubleValue > 0;
        return;
    }
    
    if (self.isEmpty) {
        
        if ([btn.value isEqualToString:@"+"]) {
            self.inputView.text = @"1.00";
            self.inputView.textColor = _textColor;
            self.sureBtn.enabled = YES;
            return;
        }
        
        if ([btn.value isEqualToString:@"00"]) {
            return;
        }else if ([btn.value isEqualToString:@"0"]) {
            return;
        }
        
        if ([btn.value isEqualToString:@"."]) {
            NSString *nextStr = [NSString stringWithFormat:@"0%@",btn.value];
            self.inputView.text = nextStr;
            self.inputView.textColor = _textColor;
            
            self.sureBtn.enabled = NO;
            return;
        }
    }
    
    self.inputView.text = btn.value;
    self.inputView.textColor = _textColor;
    
    self.sureBtn.enabled = YES;
}

- (void)functionBtnClick:(UIButton *)btn{
    
    NSString *lastText = self.inputView.text;
    
    if (btn == _deleteBtn) {
        
        if (self.isEmpty) {
            return;
        }
        
        if (lastText.length-1) {
            NSString *nextStr = [lastText substringToIndex:lastText.length-1];
            self.inputView.text = nextStr;
            //值为0 或者 . 结尾
            if (nextStr.doubleValue == 0 || [nextStr hasSuffix:@"."]) {
                self.sureBtn.enabled = NO;
            }else{
                self.sureBtn.enabled = YES;
            }
            
        }else{
            self.inputView.text = _placeholder;
            self.inputView.textColor = _placeholderColor;
            self.sureBtn.enabled = NO;
        }
        
    }else if (btn == _sureBtn){
        if (self.isEmpty) {
            return;
        }
        
        if (lastText.doubleValue < _minValue) {
            [self showMessage:[NSString stringWithFormat:@"单笔最低不得低于%.lf元",_minValue]];
            
            return;
        }
        
        if ([lastText hasSuffix:@"."]) {
            lastText = [lastText substringToIndex:lastText.length-1];
            self.inputView.text = lastText;
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(makeSureWithNumber:)]) {
            [_delegate makeSureWithNumber:lastText];
        }
    }else if (btn == _clearBtn){
        if (self.isEmpty) {
            return;
        }
        [self setNumber:_placeholder];
    }
};

- (BOOL)isEmpty{
    return [self.inputView.text isEqualToString:_placeholder];
}


- (void)setNumber:(NSString *)number{
    
    if (!number.length) {
        return;
    }
    
    if (number.doubleValue > _maxValue) {
        number = [NSString stringWithFormat:@"%.2lf",_maxValue];
        [self showMessage:[NSString stringWithFormat:@"单笔最高%@元",number]];
    }
    
    if ([number isEqualToString:_placeholder]) {
        self.inputView.text = _placeholder;
        self.inputView.textColor = _placeholderColor;
        self.sureBtn.enabled = NO;
    }else{
        self.inputView.textColor = _textColor;
        self.inputView.text = number;
        self.sureBtn.enabled = YES;
    }
    
}

#pragma mark - method
- (void)makeSureBtnEnable{
    self.sureBtn.enabled = NO;
}

- (void)showMessage:(NSString *)message{
    [SVProgressHUD showImage:nil status:message];
}

- (void)show{
    if (!self.superview) {
        
        [KeyWindow addSubview:self];
        [KeyWindow addSubview:self.bgView];
        
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.superview);
            make.height.mas_equalTo(SPKeyBoardHeight);
            make.bottom.mas_equalTo(self.superview).mas_offset(SPKeyBoardHeight);
        }];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.mas_equalTo(self.superview);
            make.bottom.mas_equalTo(self.mas_top);
        }];
        
        [self.superview layoutIfNeeded];
        
        self.bgView.alpha = 0;
    }
    
    [self.superview setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.superview);
        }];
        self.bgView.alpha = 0.8;
        [self.superview layoutIfNeeded];
    }];
}

- (void)dismiss{
    
    if (_delegate && [_delegate respondsToSelector:@selector(willDismiss)]) {
        [_delegate willDismiss];
    }
    
    [self.superview setNeedsUpdateConstraints];
    
    [UIView animateWithDuration:0.5 animations:^{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.superview).mas_offset(SPKeyBoardHeight);
        }];
        self.bgView.alpha = 0;
        [self.superview layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.bgView removeFromSuperview];
        [self removeFromSuperview];
    }];
}

//,@"0",@".",@"+",
- (NSArray *)numberArray{
    if (!_numberArray) {
        _numberArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _numberArray;
}

- (UIView *)bgView{
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [_bgView addGestureRecognizer:tap];
        _bgView.userInteractionEnabled = YES;
    }
    return _bgView;
}
@end
