//
//  UIButton+DeleteLine.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/11/24.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UIButton+DeleteLine.h"
#import <objc/runtime.h>

BOOL wel_buttonShapesUnderline(id self, SEL _cmd) {
    
    return NO;
    
}

@implementation UIButton (DeleteLine)

+(void)load {
    
    Method m = class_getInstanceMethod([UILabel class], NSSelectorFromString(@"_shouldShowAccessibilityButtonShapesUnderline"));
    
    method_setImplementation(m, (IMP)wel_buttonShapesUnderline);
    
}
@end
