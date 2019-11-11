//
//  RealNameModel.m
//  ScanPurse
//
//  Created by zenglizhi on 2018/3/22.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "RealNameModel.h"

@implementation RealNameModel

- (void)setIsRequested:(BOOL)isRequested{
    _isRequested = isRequested;
    
}

//- (NSString *)title{
//    
//    if (_isRequested) {
//        if (![_title hasPrefix:@"*"]) {
//            _title = [@"*" stringByAppendingString:_title];
//        }
//    }else if (!_isRequested) {
//        if ([_title hasPrefix:@"*"]) {
//            _title = [_title substringFromIndex:1];
//        }
//    }
//    return _title;
//}
@end
