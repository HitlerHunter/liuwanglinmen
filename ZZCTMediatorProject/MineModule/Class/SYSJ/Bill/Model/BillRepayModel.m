//
//  BillRepayModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/18.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "BillRepayModel.h"

@implementation BillRepayModel

- (NSString *)showTime{
    if (!_showTime) {
        
        NSString *createTm = [[NSString stringWithFormat:@"%@",_tmSmp] substringToIndex:10];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTm.integerValue];
        _showTime = [NSString stringWithFormat:@"%@ %@",[date formatYMDWithSeparate:@"-"],[date formatHMS]];
        _isToday = [date minutesBeforeDate:[NSDate date]] < 15;
    }
    return _showTime;
}
@end
