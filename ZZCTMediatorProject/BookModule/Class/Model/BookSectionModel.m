//
//  BookSectionModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/25.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import "BookSectionModel.h"

@implementation BookListModel


- (NSString *)statuStr{
    
    return getBookOrderStatusTitleWithStatu(_status);
}
@end

@implementation BookSectionModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"listOrders":@"BookListModel"};
}

@end
