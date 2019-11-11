//
//  CashSubmitViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/28.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CashSubmitViewController : SDBaseViewController
/** money ssf cardNo*/
@property (nonatomic, strong) NSDictionary *dic;
- (instancetype)initWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
