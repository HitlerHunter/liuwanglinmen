//
//  UIView+Category.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/26.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZViewModel;

typedef LZViewModel *(^LZViewCornerRadiusBlock)(CGFloat radius);
typedef LZViewModel *(^LZViewCornerRadiusAddShadowBlock)(CGFloat radius,UIColor *shadowColor, CGSize shadowOffset, CGFloat shadowOpacity,CGFloat shadowRadius);
typedef LZViewModel *(^LZViewBorderBlock)(CGFloat width,UIColor *color);

@interface LZViewModel : NSObject

@property (nonatomic, weak) UIView *lz_setView;

@property (nonatomic, copy, readonly) LZViewCornerRadiusBlock lz_cornerRadius;
@property (nonatomic, copy, readonly) LZViewCornerRadiusAddShadowBlock lz_shadow;
@property (nonatomic, copy, readonly) LZViewBorderBlock lz_border;
@end

@interface UIView (Category)

- (LZViewModel *)lz_setView;
@end
