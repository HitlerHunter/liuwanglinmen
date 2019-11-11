//
//  CounponVipSearchBarView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CounponVipSearchBarView : SDBaseView

@property (nonatomic, strong) void (^didReturnBlock)(NSString *str);

- (void)setVipNumber:(NSInteger)vipNumber
        couponNumber:(NSInteger)couponNumber;
@end

NS_ASSUME_NONNULL_END
