//
//  MarketMessageManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketMessageManager : NSObject

@property (nonatomic, assign) NSInteger changed;
@property (nonatomic, assign) NSInteger messageCount;

@property (nonatomic, strong) NSString *messageCountStr;

/**短信价格*/
@property (nonatomic, assign) double messagePrice;
/**每条/元*/
@property (nonatomic, strong) NSString *remark;

+ (MarketMessageManager *)shareInstance;

/**更新我的message信息*/
- (void)updateMessageInfo;
/**获取短信价格*/
- (void)getMessageRechargeRule:(void (^)(BOOL isSuccess))block;
/**传入金额，获得条数*/
- (NSInteger)messageCountWithMoney:(NSString *)money;
@end

NS_ASSUME_NONNULL_END
