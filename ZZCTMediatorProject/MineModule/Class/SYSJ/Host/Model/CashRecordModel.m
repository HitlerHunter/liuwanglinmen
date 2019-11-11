//
//  CashRecordModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2018/7/6.
//  Copyright © 2018年 徐迪华. All rights reserved.
//

#import "CashRecordModel.h"

@implementation CashRecordModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"tranId":@"id"};
}

- (NSString *)showTime{
    if (!_showTime) {
        
        _showTime = [self.createTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    return _showTime;
}
@end
