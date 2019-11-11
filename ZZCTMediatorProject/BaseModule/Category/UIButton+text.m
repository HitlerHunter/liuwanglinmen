//
//  UIButton+text.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UIButton+text.h"

@implementation UIButton (text)

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize text:(NSString *)text{
    return [[self class] buttonWithFontSize:fontSize text:text selectText:nil textColor:nil selectTextColor:nil cornerRadius:NO];
}

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    return [[self class] buttonWithFontSize:fontSize text:nil selectText:nil textColor:textColor selectTextColor:nil cornerRadius:NO];
}

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor{
    
    return [[self class] buttonWithFontSize:fontSize text:text selectText:nil textColor:textColor selectTextColor:nil cornerRadius:NO];
}

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius{
    
    return [[self class] buttonWithFontSize:fontSize text:text selectText:nil textColor:textColor selectTextColor:nil cornerRadius:cornerRadius];
}

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize
                            text:(NSString *)text
                      selectText:(NSString *)text_sel
                       textColor:(UIColor *)textColor
                       selectTextColor:(UIColor *)textColor_sel
                    cornerRadius:(CGFloat)cornerRadius{
    
    UIButton *obj = [[[self class] alloc] initWithFontSize:fontSize];
    if (text) {
        [obj setTitle:text forState:UIControlStateNormal];
    }
    
    if (textColor) {
        [obj setTitleColor:textColor forState:UIControlStateNormal];
    }
    
    if (text_sel) {
        [obj setTitle:text forState:UIControlStateSelected];
    }
    if (textColor_sel) {
        [obj setTitleColor:textColor forState:UIControlStateSelected];
    }
    
    if (cornerRadius) {
        obj.layer.cornerRadius = cornerRadius;
        obj.layer.masksToBounds = YES;
    }
    return obj;
}

- (instancetype)initWithFontSize:(CGFloat)fontSize{
    self = [super init];
    if (self) {
        self.titleLabel.font = kfont(fontSize);
    }
    return self;
}
@end
