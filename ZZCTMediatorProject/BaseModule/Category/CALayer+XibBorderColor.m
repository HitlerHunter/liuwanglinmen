//
//  CALayer+XibBorderColor.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/20.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "CALayer+XibBorderColor.h"

@implementation CALayer (XibBorderColor)

- (void)setBorderColorWithUIColor:(UIColor *)color
{
    
    self.borderColor = color.CGColor;
}

@end
