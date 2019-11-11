//
//  UIButton+text.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (text)

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize text:(NSString *)text;
+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize textColor:(UIColor *)textColor;
+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor;
+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize text:(NSString *)text textColor:(UIColor *)textColor cornerRadius:(CGFloat)cornerRadius;

+ (UIButton *)buttonWithFontSize:(CGFloat)fontSize
                            text:(NSString *)text
                      selectText:(NSString *)text_sel
                       textColor:(UIColor *)textColor
                 selectTextColor:(UIColor *)textColor_sel
                    cornerRadius:(CGFloat)cornerRadius;
@end
