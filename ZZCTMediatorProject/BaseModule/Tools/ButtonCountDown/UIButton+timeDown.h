//
//  UIButton+timeDown.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (timeDown)

@property (nonatomic, weak) dispatch_source_t timer;

/**检测是否还没有倒计时完*/
- (void)checkTimeWithTimeId:(NSString *)timeId
                      title:(NSString *)title
             countDownTitle:(NSString *)subTitle;

/**开始倒计时1*/
- (void)startWithTime:(NSTimeInterval)timeLine
              maxTime:(NSTimeInterval)maxTime
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
               timeId:(NSString *)timeId;

/**开始倒计时2*/
- (void)startWithTime:(NSTimeInterval)timeLine
              maxTime:(NSTimeInterval)maxTime
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
            mainColor:(UIColor *)mColor
           countColor:(UIColor *)color
               timeId:(NSString *)timeId;

/**退出*/
- (void)cancelTimer;
@end
