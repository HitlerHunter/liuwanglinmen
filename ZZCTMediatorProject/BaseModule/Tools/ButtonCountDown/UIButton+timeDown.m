//
//  UIButton+timeDown.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "UIButton+timeDown.h"
#import "TimeCountDownManager.h"
#import <objc/runtime.h>

static NSString *timerKey = @"timerKey";

@implementation UIButton (timeDown)

- (void)checkTimeWithTimeId:(NSString *)timeId
                      title:(NSString *)title
             countDownTitle:(NSString *)subTitle{
    
    NSTimeInterval timeInterval = [[TimeCountDownManager shareInstance] getTimeWithID:timeId];
    
    if (timeInterval) {
        [self startWithTime:timeInterval maxTime:60 title:title countDownTitle:subTitle timeId:timeId];
    }
}

- (void)startWithTime:(NSTimeInterval)timeLine
              maxTime:(NSTimeInterval)maxTime
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
               timeId:(NSString *)timeId{
    [self startWithTime:timeLine maxTime:maxTime title:title countDownTitle:subTitle mainColor:nil countColor:nil timeId:timeId];
}

- (void)startWithTime:(NSTimeInterval)timeLine
                maxTime:(NSTimeInterval)maxTime
                title:(NSString *)title
       countDownTitle:(NSString *)subTitle
            mainColor:(UIColor *)mColor
           countColor:(UIColor *)color
                timeId:(NSString *)timeId{
    
    NSTimeInterval timeInterval = [[TimeCountDownManager shareInstance] getTimeWithID:timeId];
    
    //倒计时时间
    __block NSInteger timeOut = timeLine;
    
    if (timeInterval) {
        timeOut = timeInterval;
    }else{
        [[TimeCountDownManager shareInstance] saveTimeWithID:timeId timeInterval:maxTime];
    }
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    self.timer = _timer;
    
    //每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        //倒计时结束，关闭
        if (timeOut <= 0) {
            self.timer = nil;
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                if(mColor) self.backgroundColor = mColor;
                [self setTitle:title forState:UIControlStateNormal];
                self.userInteractionEnabled = YES;
            });
        } else {
            int allTime = (int)timeLine + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%0.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(color)self.backgroundColor = color;
                [self setTitle:[NSString stringWithFormat:@"%@%@",timeStr,subTitle] forState:UIControlStateNormal];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

- (void)cancelTimer{
    if (self.timer) {
        
        dispatch_source_cancel(self.timer);
        self.timer = nil;
    }
}

- (void)setTimer:(dispatch_source_t)timer{
    //关联对象
    objc_setAssociatedObject(self, &timerKey, timer, OBJC_ASSOCIATION_ASSIGN);
}

- (dispatch_source_t)timer{
    return objc_getAssociatedObject(self, &timerKey);
}
@end
