//
//  NSDate+countDown.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/27.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^LZCountDownBlock)(NSString *HMSString);
@interface NSDate (countDown)

+ (void)stopCountDown;
+ (void)countDownSinceDateBeginStr:(NSString *)beginStr
                      TimeInterval:(NSTimeInterval)TimeInterval
                             block:(LZCountDownBlock)block;
@end

NS_ASSUME_NONNULL_END
