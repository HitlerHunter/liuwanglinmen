//
//  TimeCountDownManager.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/14.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "TimeCountDownManager.h"

@implementation TimeModel

@end

@interface TimeCountDownManager ()
@property (nonatomic, strong) NSMutableArray <TimeModel *> *dataArray;
@end

@implementation TimeCountDownManager

+ (TimeCountDownManager *)shareInstance{
    static TimeCountDownManager *helper;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        if (helper == nil) {
            helper = [[TimeCountDownManager alloc]init];
        }
    });
    return helper;
}

- (void)saveTimeWithID:(NSString *)timeId timeInterval:(NSTimeInterval)timeInterval{
    
    NSDate *finishDate = [NSDate dateWithTimeIntervalSinceNow:timeInterval];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeId == '%@'",timeId];
    NSArray *exists = [self.dataArray filteredArrayUsingPredicate:predicate];
    [self.dataArray removeObjectsInArray:exists];
    
    TimeModel *time = [TimeModel new];
    time.finishDate = finishDate;
    time.timeId = timeId;
    
    [self.dataArray addObject:time];
}

- (NSTimeInterval)getTimeWithID:(NSString *)timeId{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"timeId == %@",timeId];
    NSArray *exists = [self.dataArray filteredArrayUsingPredicate:predicate];
    
    if (exists.count == 0) {
        return 0;
    }
    
    TimeModel *time = [exists safeObjectWithIndex:0];
    
    NSTimeInterval t = [time.finishDate timeIntervalSinceNow];
    
    if(t <= 0){
        [self.dataArray removeObject:time];
    }
    
    return t>0?t:0;
}

- (NSMutableArray<TimeModel *> *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end
