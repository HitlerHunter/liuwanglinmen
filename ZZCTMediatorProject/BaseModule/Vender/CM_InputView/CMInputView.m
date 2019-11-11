//
//  CMTextView.m
//  CMInputView
//
//  Created by CrabMan on 16/9/9.
//  Copyright © 2016年 CrabMan. All rights reserved.
//

#import "CMInputView.h"

@interface CMInputView ()
/**
 *  UITextView作为placeholderView，使placeholderView等于UITextView的大小，字体重叠显示，方便快捷，解决占位符问题.
 */
@property (nonatomic, weak) UITextView *placeholderView;
/**
 *  文字高度
 */
@property (nonatomic, assign) NSInteger textH;
/**
 *  文字最大高度
 */
@property (nonatomic, assign) NSInteger maxTextH;
@end

@implementation CMInputView

- (void)textHeightValueDidChanged:(CM_textHeightChangedBlock)block{
    
    _textChangedBlock = block;

}
- (UITextView *)placeholderView
{
    if (!_placeholderView ) {
        UITextView *placeholderView = [[UITextView alloc] initWithFrame:self.bounds];
        _placeholderView = placeholderView;
        //防止textView输入时跳动问题
        _placeholderView.scrollEnabled = NO;
        _placeholderView.showsHorizontalScrollIndicator = NO;
        _placeholderView.showsVerticalScrollIndicator = NO;
        _placeholderView.userInteractionEnabled = NO;
        _placeholderView.font =  kfont(13);
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.backgroundColor = [UIColor clearColor];
        [self addSubview:placeholderView];
    }
    return _placeholderView;
}

- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
{
    _maxNumberOfLines = maxNumberOfLines;
    
    /**
     *  根据最大的行数计算textView的最大高度
     *  计算最大高度 = (每行高度 * 总行数 + 文字上下间距)
     */
    _maxTextH = ceil(self.font.lineHeight * maxNumberOfLines + self.textContainerInset.top + self.textContainerInset.bottom);
    
}

- (void)setCornerRadius:(NSUInteger)cornerRadius
{
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

/**
 *  通过设置placeholder设置私有属性placeholderView中的textColor
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    self.placeholderView.textColor = placeholderColor;
}
/**
 *  通过设置placeholder设置私有属性placeholderView中的textColor
 */
- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    self.placeholderView.text = placeholder;
}

- (void)setTitleColor:(UIColor *)titleColor{
    _titleColor = titleColor;
}

/**
 *  通过设置_placeholderFont设置私有属性placeholderView中的Font
*/
- (void)setPlaceholderFont:(UIFont *)placeholderFont {

    _placeholderFont = placeholderFont;
    self.placeholderView.font = placeholderFont;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.scrollEnabled = NO;
    self.scrollsToTop = NO;
    self.showsHorizontalScrollIndicator = NO;
    self.enablesReturnKeyAutomatically = YES;
   
//    //textView 里面的不偏移
//    self.topViewController.modalPresentationCapturesStatusBarAppearance = NO;
//    self.topViewController.edgesForExtendedLayout = UIRectEdgeNone;
//    self.topViewController.extendedLayoutIncludesOpaqueBars = NO;

    //实时监听textView值得改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    
    [self addObserver:self forKeyPath:@"attributedText" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if (object == self && ([keyPath isEqualToString:@"attributedText"] || [keyPath isEqualToString:@"text"]) ) {
        NSAttributedString *newStr = change[NSKeyValueChangeNewKey];
        NSAttributedString *oldStr = change[NSKeyValueChangeOldKey];
        
        if (newStr.length != oldStr.length) {
            [self textDidChange];
            return;
        }
    }
    // 根据文字内容决定placeholderView是否隐藏
    self.placeholderView.hidden = self.text.length > 0;
}

- (void)textDidChange
{
    if (_textValueDidChanged) {
        _textValueDidChanged(self.text);
    }
    
    if(_maxTextNumber>0) [self textFiledEditChanged:self];
    
    // 根据文字内容决定placeholderView是否隐藏
    self.placeholderView.hidden = self.text.length > 0;
    
    NSString *lang = self.textInputMode.primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        //获取高亮部分
        UITextPosition *position = [self positionFromPosition:self.markedTextRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计、限制等处理
        if (position) {
            return;
        }
    }
    

    NSInteger height = ceilf([self sizeThatFits:CGSizeMake(self.bounds.size.width, MAXFLOAT)].height);
    
    if (_textH != height) { // 高度不一样，就改变了高度
        // 当高度大于最大高度时，需要滚动
        self.scrollEnabled = height > _maxTextH && _maxTextH > 0;
        _textH = height;
        
        //当不可以滚动（即 <= 最大高度）时，传值改变textView高度
        if (_textChangedBlock && self.scrollEnabled == NO) {
            _textChangedBlock(self.text,height);
            
            [self.superview layoutIfNeeded];
            self.placeholderView.frame = self.bounds;
        }
    }
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:self.text];
    //字体颜色
    [attStr addAttribute:NSForegroundColorAttributeName value:self.titleColor ? self.titleColor : [UIColor grayColor] range:NSMakeRange(0, attStr.length)];
    //font
    [attStr addAttribute:NSFontAttributeName value:kfont(13) range:NSMakeRange(0, attStr.length)];
    
    self.attributedText = attStr;
}

-(void)textFiledEditChanged:(UITextView *)textField{
    
    NSString *toBeString = textField.text;
    NSString *lang = textField.textInputMode.primaryLanguage; // 键盘输入模式
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [textField markedTextRange];
        //获取高亮部分
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _maxTextNumber) {
                textField.text = [toBeString substringToIndex:_maxTextNumber];
            }
        }
        // 有高亮选择的字符串，则暂不对文字进行统计和限制
        else{
            
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else{
        if (toBeString.length > _maxTextNumber) {
            textField.text = [toBeString substringToIndex:_maxTextNumber];
        }
    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self removeObserver:self forKeyPath:@"attributedText"];
    [self removeObserver:self forKeyPath:@"text"];
}

@end
