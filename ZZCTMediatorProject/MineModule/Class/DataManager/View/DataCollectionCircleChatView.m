//
//  DataCollectionCircleChatView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataCollectionCircleChatView.h"

@interface DataCollectionCircleChatView ()

@property (nonatomic, strong) CAShapeLayer *alipayLayer;
@property (nonatomic, strong) CAShapeLayer *wechatLayer;

@property (nonatomic, assign) CGFloat wechatProgress;
@property (nonatomic, assign) CGFloat whiteLineSpacing;
@end

@implementation DataCollectionCircleChatView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
        ///计算中心点
    CGPoint center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    
        ///底层圆
    CGFloat radius = self.frame.size.width * 0.5-12;
    UIBezierPath* arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:0 endAngle:2 * M_PI clockwise:YES];
    
    self.alipayLayer.path = arcPath.CGPath;
    self.wechatLayer.path = arcPath.CGPath;
}

- (void)initUI{
    
    [self.layer addSublayer:self.alipayLayer];
    [self.layer addSublayer:self.wechatLayer];
    self.backgroundColor = LZWhiteColor;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshProgress)];
    [self addGestureRecognizer:tap];
    
    _whiteLineSpacing = 0.00;
    
}

- (void)refreshProgress{
    
    [self refreshAlipayProgress:_alipayProgress];
}

- (void)refreshAlipayProgress:(CGFloat)progress{
    _alipayProgress = progress;
    
    if (progress == 0.0) {
        return;
    }
    
    _wechatProgress = 1 - progress;
    
    
    [self refreshAnimation];
}

- (void)refreshAnimation{
    
    if (_alipayProgress > 0) {
        
        self.alipayLayer.strokeStart = _whiteLineSpacing;
        
        CABasicAnimation *animation_alipay = [ CABasicAnimation animationWithKeyPath : @"strokeEnd"];
        animation_alipay.fromValue = @(_whiteLineSpacing);
        animation_alipay.toValue = @(_alipayProgress);
        animation_alipay.duration = 0.3;
        animation_alipay.removedOnCompletion = NO;
        animation_alipay.fillMode = kCAFillModeForwards;
        
        [self.alipayLayer addAnimation:animation_alipay forKey:@"strokeEnd"];
    }else{
        self.alipayLayer.strokeEnd = 0.0f;
    }
    
    if (_wechatProgress > 0) {
        
        self.wechatLayer.strokeStart = _alipayProgress+_whiteLineSpacing;
        
        CABasicAnimation *animation_end = [CABasicAnimation animationWithKeyPath : @"strokeEnd"];
        animation_end.fromValue = @(_alipayProgress+_whiteLineSpacing);
        animation_end.toValue = @(1);
        animation_end.duration = 0.3;
        animation_end.removedOnCompletion = NO;
        animation_end.fillMode = kCAFillModeForwards;
        
        [self.wechatLayer addAnimation:animation_end forKey:@"strokeEnd"];
        
    }else{
        self.wechatLayer.strokeEnd = 0.0f;
    }
    
    
}


- (CAShapeLayer *)alipayLayer{
    if (!_alipayLayer) {
        _alipayLayer = [CAShapeLayer layer];
        _alipayLayer.lineWidth = 20.0;
        _alipayLayer.strokeColor = rgb(0,159,232).CGColor;
        _alipayLayer.fillColor = [UIColor clearColor].CGColor;
        _alipayLayer.lineCap = kCALineCapButt;
        _alipayLayer.lineJoin = kCALineJoinMiter;
    }
    return _alipayLayer;
}

- (CAShapeLayer *)wechatLayer{
    if (!_wechatLayer) {
        _wechatLayer = [CAShapeLayer layer];
        _wechatLayer.lineWidth = 20.0;
        _wechatLayer.strokeColor = rgb(64,186,73).CGColor;
        _wechatLayer.fillColor = [UIColor clearColor].CGColor;
        _wechatLayer.lineCap = kCALineCapButt;
        _wechatLayer.lineJoin = kCALineJoinMiter;
    }
    return _wechatLayer;
}
@end
