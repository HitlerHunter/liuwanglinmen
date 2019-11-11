//
//  BossStudyCell.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BossStudyCell.h"

@implementation BossStudyCell

- (void)initUI{
    
    if (kScreenWidth == 320) {
        self.btn.hidden = YES;
    }
    
    [self addBottomLine];
    
    self.btn.backgroundColor = LZWhiteColor;
        //渐变颜色
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[(__bridge id)rgb(251,148,57).CGColor, (__bridge id)rgb(255,96,0).CGColor];
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = self.btn.bounds;
    gradientLayer.cornerRadius = self.btn.height*0.5;
    [self.btn.layer addSublayer:gradientLayer];
}

@end
