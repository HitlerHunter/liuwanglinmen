//
//  DebitCardModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DebitCardModel : NSObject

@property (nonatomic, strong) NSString *bankCode;
@property (nonatomic, strong) NSString *debitBankName;
@property (nonatomic, strong) NSString *debitCardNo;
@property (nonatomic, strong) NSString *debitMobile;
@property (nonatomic, strong) NSString *idCardNo;
@property (nonatomic, strong) NSString *idCardType;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *usrNo;

@end

NS_ASSUME_NONNULL_END
