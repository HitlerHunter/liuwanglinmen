//
//  BossStudyModel.m
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/12.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "BossStudyModel.h"

@implementation BossStudyModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"ID":@"id"};
}

- (NSString *)showTime{
    if (!_showTime) {
        
//        NSString *createTm = [[NSString stringWithFormat:@"%@",_createTime] substringToIndex:10];
//        NSDate *date = [NSDate dateWithTimeIntervalSince1970:createTm.integerValue];
//        _showTime = [date formatYMDWithSeparate:@"-"];
        _showTime = _createTime;
    }
    return _showTime;
}
@end
