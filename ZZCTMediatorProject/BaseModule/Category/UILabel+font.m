    //
    //  UILabel+font.m
    //  ScanPurse
    //
    //  Created by zenglizhi on 2018/3/19.
    //  Copyright © 2018年 zenglizhi. All rights reserved.
    //

#import "UILabel+font.h"

@implementation UILabel (font)

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize{
    return [[UILabel alloc] initWithFontSize:fontSize];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text{
    return [UILabel labelWithFontSize:fontSize text:text textColor:nil textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment{
    return [UILabel labelWithFontSize:fontSize text:text textColor:nil textAlignment:textAlignment];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor{
    return [UILabel labelWithFontSize:fontSize text:nil textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    return [UILabel labelWithFontSize:fontSize text:nil textColor:textColor textAlignment:textAlignment];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor{
    return [UILabel labelWithFontSize:fontSize text:text textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *lab = [[UILabel alloc] initWithFontSize:fontSize];
    
    if (text) {
        lab.text = text;
    }
    
    if (textColor) {
        lab.textColor = textColor;
    }
    
    if (textAlignment) {
        lab.textAlignment = textAlignment;
    }
    return lab;
}

- (instancetype)initWithFontSize:(CGFloat)fontSize{
    self = [super init];
    if (self) {
        self.font = Font_PingFang_SC_Regular(fontSize);
    }
    return self;
}

+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor{
    return [UILabel labelWithFont:font text:text textColor:textColor textAlignment:NSTextAlignmentLeft];
}

+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment{
    
    UILabel *lab = [[UILabel alloc] init];
    
    if (font) {
        lab.font = font;
    }
    
    if (text) {
        lab.text = text;
    }
    
    if (textColor) {
        lab.textColor = textColor;
    }
    
    if (textAlignment) {
        lab.textAlignment = textAlignment;
    }
    return lab;
}
@end
