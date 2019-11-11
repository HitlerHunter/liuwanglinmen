//
//  DataManagerModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "DataManagerModel.h"

@implementation DataManagerModel

- (void)setExecuteDate:(NSString *)executeDate{
    _executeDate = executeDate;
    
    NSString *timeStr = [executeDate substringToIndex:10];
    _yearMonthDay = timeStr;
    
    _monthDay = [timeStr substringFromIndex:5];
    _day = [timeStr substringFromIndex:8];
    
}

@end
