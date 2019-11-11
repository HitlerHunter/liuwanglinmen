//
//  BankCardManager.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DebitCardModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, BankCardType) {
    /**储蓄卡*/
    BankCardTypeDebit,
    /**信用卡*/
    BankCardTypeCredit,
};

@interface BankCardManager : NSObject


+ (void)addCardWithType:(BankCardType)cardType
                 params:(NSDictionary *)params
                  block:(SimpleBoolBlock)block;

+ (void)editCardWithParams:(NSMutableDictionary *)params
                     block:(SimpleBoolBlock)block;
+ (void)removeCardWithType:(BankCardType)cardType
                    cardNo:(NSString *)cardNo
                     block:(SimpleBoolBlock)block;

+ (void)getDebitCardWithBlock:(SimpleObjBlock)block;
+ (void)getDefaultBankCard:(void (^)(DebitCardModel *debitCard))block;
+ (void)getDebitCardWithStatus:(NSString *)status
                         block:(void (^)(NSArray *array))block;
@end

NS_ASSUME_NONNULL_END
