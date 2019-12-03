//
//  NSDate+countDown.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "NSDate+countDown.h"

@implementation NSDate (countDown)

static NSTimer *activeTimer = nil;
static NSInteger timeDifference = 0;
static LZCountDownBlock countDownBlock = nil;

+ (void)stopCountDown{
    [activeTimer invalidate];
    activeTimer = nil;
    countDownBlock = nil;
}

+ (void)countDownSinceDateBeginStr:(NSString *)beginStr TimeInterval:(NSTimeInterval)TimeInterval block:(LZCountDownBlock)block{
    
     NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *beginDate = [formatter dateFromString:beginStr];
    NSTimeInterval endTime = [beginDate timeIntervalSince1970]+TimeInterval;
    NSTimeInterval nowTime = [[NSDate date] timeIntervalSince1970];
    
    timeDifference = endTime - nowTime;
    
    if (timeDifference > 0) {
        countDownBlock = block;
        activeTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(activeCountDownAction) userInfo:nil repeats:YES];
        [activeTimer fire];
        
    }
    
    
}

+ (void)activeCountDownAction{
    timeDifference -= 1;
    [self timeSinceNowWithSeconds:timeDifference];
}

+ (void)timeSinceNowWithSeconds:(NSInteger)seconds{
    
    // 重新计算 时/分/秒
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", seconds / 3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (seconds % 3600) / 60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld", seconds % 60];
    NSString *format_time = [NSString stringWithFormat:@"%@ : %@ : %@", str_hour, str_minute, str_second];
   
    if (countDownBlock) {
        countDownBlock(format_time);
    }

    // 当倒计时结束时做需要的操作: 比如活动到期不能提交
    if(seconds <= 0) {

        [self stopCountDown];
    }
   
}

@end
