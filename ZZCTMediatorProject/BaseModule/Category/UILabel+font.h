//
//  UILabel+font.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (font)

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text;
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;

- (instancetype)initWithFontSize:(CGFloat)fontSize;

+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor;
+ (UILabel *)labelWithFont:(UIFont *)font text:(NSString *)text textColor:(UIColor *)textColor textAlignment:(NSTextAlignment)textAlignment;
@end
