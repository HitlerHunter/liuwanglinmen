//
//  BillCashModel.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/28.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BillCashModel.h"

@implementation BillCashModel

- (NSString *)showTime{
    if (!_showTime) {
        
        NSString *createTm = [[NSString stringWithFormat:@"%@",_txnDate] substringToIndex:10];
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTm.integerValue];
        _showTime = [NSString stringWithFormat:@"%@ %@",[date formatYMDWithSeparate:@"-"],[date formatHMS]];
    }
    return _showTime;
}
@end
