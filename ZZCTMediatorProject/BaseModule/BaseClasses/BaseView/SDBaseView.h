//
//  SDBaseView.h
//  YaYingInternational
//
//  Created by 曾立志 on 2017/12/24.
//  Copyright © 2017年 Mr.Z. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DXRadianDirection) {
    DXRadianDirectionBottom     = 0,
    DXRadianDirectionTop        = 1,
    DXRadianDirectionLeft       = 2,
    DXRadianDirectionRight      = 3,
};

@interface SDBaseView : UIView

@property (nonatomic, readonly, assign) CGFloat defaultHeght;
+ (CGFloat)defaultHeight;

- (void)initUI;
+ (instancetype)xibView;

//line
@property (nonatomic, strong) CALayer *topLine;
@property (nonatomic, strong) CALayer *bottomLine;
@property (nonatomic, strong) UIColor *lineColor;

- (void)setBottomLineX:(CGFloat)spacingX;
- (void)setTopLineX:(CGFloat)spacingX;

- (void)addTopLine;
- (void)addBottomLine;

#pragma 弧形
// 圆弧方向, 默认在下方
@property (nonatomic) DXRadianDirection direction;
// 圆弧高/宽, 可为负值。 正值凸, 负值凹
@property (nonatomic) CGFloat radian;

@end
