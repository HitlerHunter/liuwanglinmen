//
//  CouponVipViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CouponVipViewModel : NSObject

@property (nonatomic, strong) NSString *searchStr;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *searchDataArray;

- (void)getAllVipWithBlock:(SimpleBoolBlock)block;
- (void)searchVipWithBlock:(SimpleBoolBlock)block;

@end

NS_ASSUME_NONNULL_END
