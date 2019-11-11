//
//  CALayer+XibBorderColor.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/20.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CALayer (XibBorderColor)
- (void)setBorderColorWithUIColor:(UIColor *)color;
@end
