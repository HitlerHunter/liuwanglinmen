//
//  MarketMessagePayManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/6.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MarketMessagePayManager : NSObject

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *smsCount;
@property (nonatomic, strong) NSString *remark;

- (void)requestOrder;
@end

NS_ASSUME_NONNULL_END
