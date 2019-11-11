//
//  SKMSignMoneyView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKMSignMoneyView : UIView

@property (nonatomic, strong) void (^finishBlock)(NSString *money,NSString *mark);

+ (SKMSignMoneyView *)view;
- (void)show;
- (void)dismiss;
@end
