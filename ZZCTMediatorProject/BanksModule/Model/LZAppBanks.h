//
//  LZAppBanks.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/19.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LZAppBanks : NSObject

+ (NSArray *)bankArray;
+(UIImage*)getBankLog:(NSString *)bankName;
+ (UIImage *)getCardBgImageWithBankName:(NSString *)bankName;

@end

NS_ASSUME_NONNULL_END
