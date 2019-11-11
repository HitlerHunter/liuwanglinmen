//
//  AppMessage+LocalNotice.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "AppMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppMessage (LocalNotice)

- (void)showMessageWithDic:(NSDictionary *)dic;
@end

NS_ASSUME_NONNULL_END
