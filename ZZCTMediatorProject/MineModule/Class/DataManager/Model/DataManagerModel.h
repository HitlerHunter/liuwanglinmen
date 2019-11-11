//
//  DataManagerModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/5.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManagerModel : NSObject

@property (nonatomic, assign) NSInteger allCount;
@property (nonatomic, assign) NSInteger successCount;
@property (nonatomic, assign) NSInteger failureCount;

@property (nonatomic, assign) CGFloat sumAllAmt;
@property (nonatomic, assign) CGFloat successAmt;
@property (nonatomic, assign) CGFloat failureAmt;
@property (nonatomic, assign) CGFloat sumAllFee;
@property (nonatomic, assign) CGFloat successFee;
@property (nonatomic, assign) CGFloat failureFee;
@property (nonatomic, strong) NSString *executeDate;

@property (nonatomic, strong) NSString *day;
@property (nonatomic, strong) NSString *monthDay;
@property (nonatomic, strong) NSString *yearMonthDay;

@end

NS_ASSUME_NONNULL_END
