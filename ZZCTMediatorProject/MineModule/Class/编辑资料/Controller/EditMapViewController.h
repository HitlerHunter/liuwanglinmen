//
//  EditMapViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^FinishBlock)(NSDictionary *addressDic);

@interface EditMapViewController : SDBaseViewController

- (instancetype)initWithLatitude:(NSString *)latitude
                       longitude:(NSString *)longitude
                     FinishBlock:(FinishBlock)block;
@end

NS_ASSUME_NONNULL_END
