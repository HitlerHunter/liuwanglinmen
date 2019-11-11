//
//  TimeCountDownManager.h
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeModel : NSObject
@property (nonatomic, strong) NSDate *finishDate;
@property (nonatomic, strong) NSString *timeId;
@end

@interface TimeCountDownManager : NSObject

+ (TimeCountDownManager *)shareInstance;

/**保存开始倒计时的date*/
- (void)saveTimeWithID:(NSString *)timeId timeInterval:(NSTimeInterval)timeInterval;

/**获取剩余时间*/
- (NSTimeInterval)getTimeWithID:(NSString *)timeId;

@end
