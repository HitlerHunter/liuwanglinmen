//
//  UIView+Gradient.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/14.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, GradientDirectionType) {
    /**横*/
    GradientDirectionTypeHorizontal,
    /**竖*/
    GradientDirectionTypeVertical,
};

@interface UIView (Gradient)

@property (nonatomic, strong) CAGradientLayer *gradientLayer;

- (void)setDefaultGradient;
- (void)setDefaultGradientWithCornerRadius:(CGFloat)cornerRadius;
- (void)setGradientWithColorArray:(NSArray *)colorArray
                     cornerRadius:(CGFloat)cornerRadius
                    directionType:(GradientDirectionType)directionType;

- (void)clearGradient;
@end

NS_ASSUME_NONNULL_END
