//
//  DataManagerViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

static NSString *DataTypeDealCount = @"dealCount";
static NSString *DataTypeDealMoney = @"dealMoney";

@class DataManagerModel;
@interface DataManagerViewModel : NSObject
/**查询的操作员id*/
@property (nonatomic, strong, nullable) NSString *merchantNo;
@property (nonatomic, strong) NSString *day;
/** dealCount 交易笔数 dealMoney 净收金额*/
@property (nonatomic, strong) NSString *dataType;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSDictionary *sumDictionary;
@property (nonatomic, strong) NSDictionary *payWay_wechatDictionary;
@property (nonatomic, strong) NSDictionary *payWay_alipayDictionary;

- (void)getLineDataAddAllDataWithBlock:(void (^)(NSArray <DataManagerModel *>*dataArray))block;
- (void)getPaywayDataWithBlock:(void (^)(void))block;
@end

NS_ASSUME_NONNULL_END
