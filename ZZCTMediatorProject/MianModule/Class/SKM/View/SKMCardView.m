//
//  SKMCardView.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/17.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SKMCardView.h"

@interface SKMCardView ()
@property (nonatomic, strong) CALayer *line;
@property (nonatomic, assign) CGFloat corTopY;
@property (nonatomic, assign) CGFloat radius;
@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@end

@implementation SKMCardView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        _corTopY = 70;//半圆的Y
        _radius = 10;//半径
        
        [self drawCor:frame];
        
        CALayer *line = [CALayer layer];
        line.backgroundColor = rgb(233,219,217).CGColor;
        line.frame = CGRectMake(20, 80, self.width-40, 0.5);
        [self.layer addSublayer:line];
        _line = line;
        
        [self initUI2];
    }
    return self;
}
- (void)drawCor:(CGRect)rect {
    // Drawing code
    
    // 画圆
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat corTopY = _corTopY;//半圆的Y
    CGFloat radius = _radius;//半径
    
    CGPathMoveToPoint(path,NULL, 0,0);
    CGPathAddLineToPoint(path,NULL, self.width, 0);
    CGPathAddLineToPoint(path,NULL, self.width, corTopY);
    
    CGPathAddArc(path,NULL, self.width, corTopY + radius, radius, -M_PI_2, -M_PI_2-M_PI, YES);

    CGPathAddLineToPoint(path,NULL, self.width, corTopY+2*radius);
    CGPathAddLineToPoint(path,NULL, self.width, self.height);
    
    CGPathAddLineToPoint(path,NULL, 0, self.height);//左下角
    
    CGPathAddLineToPoint(path,NULL, 0, corTopY+2*radius);
    CGPathAddArc(path,NULL, 0, corTopY + radius, radius, M_PI_2, -M_PI_2, YES);
    CGPathAddLineToPoint(path,NULL, 0, corTopY);
    
    CGPathAddLineToPoint(path,NULL, 0, 0);
    
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    self.layer.mask = shapeLayer;
    
    shapeLayer.cornerRadius = 1;
    shapeLayer.shadowColor = rgba(0, 0, 0, 0.8).CGColor;
    shapeLayer.shadowOffset = CGSizeMake(0, 2.5);
    shapeLayer.shadowOpacity = 1;
    shapeLayer.shadowRadius = 7.5;
    
}

- (void)initUI2{
    
    UILabel *titleLab = [UILabel labelWithFontSize:13 text:@"订单金额" textAlignment:NSTextAlignmentCenter];
    titleLab.textColor = rgb(255,81,0);
    titleLab.frame = CGRectMake(0, 23, self.width, 15);
    [self addSubview:titleLab];
    
    UILabel *moneyLab = [UILabel labelWithFontSize:18 text:@"" textAlignment:NSTextAlignmentCenter];
    moneyLab.textColor = rgb(53,53,53);
    moneyLab.frame = CGRectMake(0, titleLab.bottom+8, self.width, 20);
    [self addSubview:moneyLab];
    _moneyLabel = moneyLab;
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.line.frame.origin.y+30, 200, 200)];
    imageView.centerX = self.width*0.5;
    
    [self addSubview:imageView];
    _imageView = imageView;
    
    UILabel *lab = [UILabel labelWithFontSize:13 text:@"微信扫一扫，向我付钱" textAlignment:NSTextAlignmentCenter];
    lab.textColor = rgb(53,53,53);
    lab.frame = CGRectMake(0, imageView.bottom+30, self.width, 15);
    [self addSubview:lab];
    _infoLabel = lab;
    
}

- (void)setMoney:(NSString *)money{
    _money = money;
    
    _moneyLabel.text = [NSString stringWithFormat:@"￥%@",money];
}

- (void)setInfo:(NSString *)info{
    _info = info;
    
    _infoLabel.text = info;
}

@end
