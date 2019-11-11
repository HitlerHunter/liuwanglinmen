//
//  UIView+Category.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/26.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UIView+Category.h"

@implementation LZViewModel

@synthesize lz_cornerRadius = _lz_cornerRadius;
@synthesize lz_border = _lz_border;
@synthesize lz_shadow = _lz_shadow;

- (LZViewCornerRadiusBlock)lz_cornerRadius{
    
    if (!_lz_cornerRadius) {
        __weak typeof(self) weakSelf = self;
        _lz_cornerRadius = ^(CGFloat radius){
            weakSelf.lz_setView.layer.cornerRadius = radius;
            weakSelf.lz_setView.layer.masksToBounds = YES;
            return weakSelf;
        };
    }
    return _lz_cornerRadius;
}

- (LZViewBorderBlock)lz_border{
    
    if (!_lz_border) {
        __weak typeof(self) weakSelf = self;
        _lz_border = ^(CGFloat width,UIColor *color){
            weakSelf.lz_setView.layer.borderWidth = width;
            weakSelf.lz_setView.layer.borderColor = color.CGColor;
            return weakSelf;
        };
    }
    return _lz_border;
}

- (LZViewCornerRadiusAddShadowBlock)lz_shadow{
    
    if (!_lz_shadow) {
        __weak typeof(self) weakSelf = self;
        _lz_shadow = ^(CGFloat radius,UIColor *shadowColor, CGSize shadowOffset, CGFloat shadowOpacity,CGFloat shadowRadius){
            weakSelf.lz_setView.layer.cornerRadius = radius;
            weakSelf.lz_setView.clipsToBounds = NO;
            weakSelf.lz_setView.layer.masksToBounds = NO;
            weakSelf.lz_setView.layer.shadowColor = shadowColor.CGColor;
            weakSelf.lz_setView.layer.shadowOffset = shadowOffset;
            weakSelf.lz_setView.layer.shadowOpacity = shadowOpacity;
            weakSelf.lz_setView.layer.shadowRadius = shadowRadius;
            return weakSelf;
        };
    }
    return _lz_shadow;
}
@end

@implementation UIView (Category)

- (LZViewModel *)lz_setView{
    
    LZViewModel *model = [self ownLayoutModel];
    if (!model) {
        model = [LZViewModel new];
        model.lz_setView = self;
        [self setOwnLayoutModel:model];
        
    }
    
    return model;
}


- (LZViewModel *)ownLayoutModel
{
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setOwnLayoutModel:(LZViewModel *)ownLayoutModel
{
    objc_setAssociatedObject(self, @selector(ownLayoutModel), ownLayoutModel, OBJC_ASSOCIATION_RETAIN);
}

@end
