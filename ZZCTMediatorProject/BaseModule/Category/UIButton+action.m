//
//  UIButton+action.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UIButton+action.h"
#import <objc/runtime.h>

static NSString * const UIButtonActionBlockKey = @"UIButtonActionBlockKey";
typedef void(^ActionBlock)(UIButton *sender);
@implementation UIButton (action)

- (void)addTouchAction:(ActionBlock)action{
    
    [self setActionBlock:action];
    
    [self removeTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonClick{
    
    ActionBlock block = [self actionBlock];
    if (block) {
        block(self);
    }
}

- (void)setActionBlock:(ActionBlock)actionBlock{
    objc_setAssociatedObject(self, &UIButtonActionBlockKey, actionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ActionBlock)actionBlock{
    return objc_getAssociatedObject(self, &UIButtonActionBlockKey);
}
@end
