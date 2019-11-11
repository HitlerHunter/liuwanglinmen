//
//  BookSectionModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/25.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookOrderDetailModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface BookListModel : NSObject
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *transOrderNo;
@property (nonatomic, strong) NSString *orderAmount;
@property (nonatomic, strong) NSString *payType;
@property (nonatomic, assign) BookOrderStatus status;

@property (nonatomic, strong, readonly) NSString *statuStr;

@end

@interface BookSectionModel : NSObject
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, assign) NSInteger orderCount;
@property (nonatomic, assign) double totalAmount;
@property (nonatomic, strong) NSArray <BookListModel *> *listOrders;

@end

NS_ASSUME_NONNULL_END
