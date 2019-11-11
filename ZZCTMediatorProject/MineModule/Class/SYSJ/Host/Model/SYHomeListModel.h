//
//  SYHomeListModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/13.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SYHomeListModel : NSObject

@property (nonatomic, strong) NSString *channel;
@property (nonatomic, strong) NSString *explains;
@property (nonatomic, strong) NSString *flowAmt;
@property (nonatomic, strong) NSString *flowId;
@property (nonatomic, strong) NSString *flowType;
@property (nonatomic, strong) NSString *rebAmt;
@property (nonatomic, strong) NSString *rebUserMobile;
@property (nonatomic, strong) NSString *rebUserName;
@property (nonatomic, strong) NSString *rebUsrNo;
@property (nonatomic, strong) NSString *rebValue;
@property (nonatomic, strong) NSString *receiptUsrNo;
@property (nonatomic, strong) NSString *refund;
@property (nonatomic, strong) NSString *timestamp;

@property (nonatomic, strong) NSString *txnDate;
@property (nonatomic, strong) NSString *txnTime;
@property (nonatomic, strong) NSString *txnUserHeader;
@property (nonatomic, assign) NSInteger txnUserLvl;
@property (nonatomic, strong) NSString *txnUserMobile;
@property (nonatomic, strong) NSString *txnUserName;
@property (nonatomic, strong) NSString *txnUsrNo;

@property (nonatomic, assign) BOOL rebAck;
@property (nonatomic, assign) NSInteger cancel;

@property (nonatomic, strong) NSString *showTime;
@property (nonatomic, strong) NSString *showType;
@end

NS_ASSUME_NONNULL_END
