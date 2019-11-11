//
//  UIButton+action.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/19.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (action)

- (void)addTouchAction:(void (^)(UIButton *sender))action;
@end
