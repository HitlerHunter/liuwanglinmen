//
//  UIView+Gradient.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "UIView+Gradient.h"
#import <objc/runtime.h>

static NSString * const gradientStr = @"gradientLayer";

@implementation UIView (Gradient)

- (void)setDefaultGradient{
    self.backgroundColor = [UIColor clearColor];
    
    [self setDefaultGradientWithCornerRadius:0];
}

- (void)setDefaultGradientWithCornerRadius:(CGFloat)cornerRadius{
    self.backgroundColor = [UIColor clearColor];
    
    [self setGradientWithColorArray:@[rgb(255,142,1),rgb(255,111,2),rgb(255,81,0)] cornerRadius:cornerRadius directionType:GradientDirectionTypeHorizontal];
}

- (void)setGradientWithColorArray:(NSArray *)colorArray
                     cornerRadius:(CGFloat)cornerRadius
                    directionType:(GradientDirectionType)directionType{
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *locations = [NSMutableArray array];
    
    for (UIColor *color in colorArray) {
        [array addObject:(__bridge id)color.CGColor];
    }
    
    [locations addObject:@0.0];
    
    for (int i = 1; i < colorArray.count-1; i++) {
        CGFloat loca = 1.0 / (colorArray.count-1) * i;
        [locations addObject:@(loca)];
    }
    
    [locations addObject:@1.0];
    
    [self layoutIfNeeded];
    
        //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = array;
    gradientLayer.locations = locations;
    
    if (directionType == GradientDirectionTypeVertical) {
        gradientLayer.startPoint = CGPointMake(1, 1);
        gradientLayer.endPoint = CGPointMake(1, 0);
    }else{
        gradientLayer.startPoint = CGPointMake(0, 0);
        gradientLayer.endPoint = CGPointMake(1.0, 0);
    }
    
    gradientLayer.frame = self.bounds;
    gradientLayer.cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
    self.gradientLayer = gradientLayer;
    
    self.layer.masksToBounds = YES;
    
    @weakify(self);
    [RACObserve(self, frame) subscribeNext:^(id  _Nullable x) {
        @strongify(self);
        if (self.gradientLayer) {
            [self.gradientLayer setFrame:self.bounds];
        }
    }];
    
}

- (void)clearGradient{
    [self.gradientLayer removeFromSuperlayer];
}

- (void)setGradientLayer:(CAGradientLayer *)gradientLayer{
    objc_setAssociatedObject(self, &gradientStr, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CAGradientLayer *)gradientLayer{
    id obj = objc_getAssociatedObject(self, &gradientStr);
    return obj;
}

@end
