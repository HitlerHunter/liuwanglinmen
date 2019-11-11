//
//  RewardRecordModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ChangeSalesStatus) {
        //拒绝
    ChangeSalesStatusRefund,
        //审核中
    ChangeSalesStatusReviewing,
        //通过
    ChangeSalesStatusSuccess,
};

extern NSString *getStatusTitleWithStatus(ChangeSalesStatus status);

@interface RewardRecordModel : NSObject

@property (nonatomic, strong) NSString *checkRemark;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *handRentalAgreement;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *memberId;
@property (nonatomic, strong) NSString *rentalAgreement;
@property (nonatomic, strong) NSString *shareComp1;
@property (nonatomic, strong) NSString *shareComp13;
@property (nonatomic, strong) NSString *shareComp14;
@property (nonatomic, strong) NSString *shareComp3;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *userNo;

@property (nonatomic, assign) ChangeSalesStatus status_lz;
@end

NS_ASSUME_NONNULL_END
