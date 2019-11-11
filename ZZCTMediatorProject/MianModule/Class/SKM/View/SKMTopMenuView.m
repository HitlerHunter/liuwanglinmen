//
//  SKMTopMenuView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/18.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SKMTopMenuView.h"

@interface SKMTopMenuView ()

@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;

@property (nonatomic, strong) CAShapeLayer *line;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat showLineWidth;

@property (nonatomic, assign) CGFloat leftEnd;
@property (nonatomic, assign) CGFloat rightStart;

@end

@implementation SKMTopMenuView

- (void)initUI{
    
    _leftBtn = [UIButton buttonWithFontSize:16 text:@"微信收款" textColor:LZWhiteColor];
    _rightBtn = [UIButton buttonWithFontSize:16 text:@"支付宝收款" textColor:LZWhiteColor];
    
    _leftBtn.frame = CGRectMake(0, 0, self.width*0.5, self.height);
    _rightBtn.frame = CGRectMake(0, 0, self.width*0.5, self.height);
    _rightBtn.right = self.width;
    
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    
    
    [_leftBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_rightBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _showLineWidth = 50;
    CGFloat _lineWidth = _rightBtn.centerX-_leftBtn.centerX+_showLineWidth;
    _leftEnd = _showLineWidth/_lineWidth;
    _rightStart = 1-(_showLineWidth/_lineWidth);
    
    CGFloat x = _leftBtn.centerX-_showLineWidth*0.5;
    CGFloat y = _leftBtn.centerY+15;
    
    _line = [CAShapeLayer layer];
    _line.strokeColor = LZWhiteColor.CGColor;
    _line.fillColor = [UIColor clearColor].CGColor;
    _line.lineCap = kCALineCapRound;
    _line.lineJoin = kCALineJoinRound;
    _line.lineWidth = 2;
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(x, y)];
    [path addLineToPoint:CGPointMake(x+_lineWidth, y)];
    _line.path = path.CGPath;
    
    [self.layer addSublayer:self.line];
    
    //初始化位置
    self.line.strokeStart = 0;
    self.line.strokeEnd = _leftEnd;
    _leftBtn.selected = YES;
}

- (void)btnClick:(UIButton *)btn{
    
    if (btn.isSelected) {
        return;
    }
    
    NSInteger index = 0;
    btn.selected = YES;
    if (btn == self.leftBtn) {
        self.rightBtn.selected = NO;
        [self lineMovetoLeft];
        
    }else{
        self.leftBtn.selected = NO;
        [self lineMovetoRight];
        index = 1;
    }
    
    if (self.btnClickBlock) {
        self.btnClickBlock(index);
    }
}

- (void)lineMovetoLeft{
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStart.duration = 0.4;
    strokeStart.toValue = 0;
    strokeStart.fromValue = @(_rightStart);
    strokeStart.removedOnCompletion = NO;
    strokeStart.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEnd.duration = 0.7;
    strokeEnd.toValue = @(_leftEnd);
    strokeEnd.fromValue = @1;
    strokeEnd.removedOnCompletion = NO;
    strokeEnd.fillMode = kCAFillModeForwards;
    
    group.animations = @[strokeStart,strokeEnd];
    
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 0.7;
    
    [self.line addAnimation:group forKey:@"lineMovetoLeft"];
}

- (void)lineMovetoRight{
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    
    CABasicAnimation *strokeStart = [CABasicAnimation animationWithKeyPath:@"strokeStart"];
    strokeStart.duration = 0.7;
    strokeStart.fromValue = 0;
    strokeStart.toValue = @(_rightStart);
    strokeStart.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    strokeStart.removedOnCompletion = NO;
    strokeStart.fillMode = kCAFillModeForwards;
    
    CABasicAnimation *strokeEnd = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    strokeEnd.duration = 0.4;
    strokeEnd.fromValue = @(_leftEnd);
    strokeEnd.toValue = @1;
    strokeEnd.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    strokeEnd.removedOnCompletion = NO;
    strokeEnd.fillMode = kCAFillModeForwards;
    
    group.animations = @[strokeStart,strokeEnd];
    group.removedOnCompletion = NO;
    group.fillMode = kCAFillModeForwards;
    group.duration = 0.7;
    
    [self.line addAnimation:group forKey:@"lineMovetoRight"];
}

@end
