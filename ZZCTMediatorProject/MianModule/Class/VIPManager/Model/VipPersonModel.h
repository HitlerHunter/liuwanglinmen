//
//  VipPersonModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/24.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface VipPersonModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSString *gendar;
@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *grade;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *bindMerchant;
@property (nonatomic, strong) NSString *bindMerchantName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *tagName;

@property (nonatomic, strong) NSString *totalPay;
@property (nonatomic, strong) NSString *payTimes;
@property (nonatomic, strong) NSString *lastPayTime;

@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *mctName;
@end

NS_ASSUME_NONNULL_END
