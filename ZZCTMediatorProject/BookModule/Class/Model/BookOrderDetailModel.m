//
//  BookOrderDetailModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BookOrderDetailModel.h"



@implementation BookOrderDetailModel

- (NSString *)statuStr{
    
    return getBookOrderStatusTitleWithStatu(_orderStatus);
}

- (NSString *)showDate{
    
    return _payDate?_payDate:_createDate;
}
@end
