//
//  MessageSendRecordModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MessageSendRecordStatus) {
    /**未执行*/
    MessageSendRecordStatusUnSend = 0,
    /**执行中*/
    MessageSendRecordStatusSending = 1,
    /**执行成功*/
    MessageSendRecordStatusSendSuccess = 2,
    /**执行失败终止*/
    MessageSendRecordStatusSendFailue = 3,
};

static NSString *const MessageSendTaskTypeWakeUpString = @"rouse";
static NSString *const MessageSendTaskTypeBirthdayString = @"birth";
static NSString *const MessageSendTaskTypeCustomString = @"custom";

static NSString *const MessageSendTargetTypeDirectString = @"direct";
static NSString *const MessageSendTargetTypeCouponString = @"coupon";
static NSString *const MessageSendTargetTypeTradeString = @"trade";

static NSString *const MessageSendTargetTypeDirectNameString = @"直推用户";
static NSString *const MessageSendTargetTypeCouponNameString = @"领劵用户";
static NSString *const MessageSendTargetTypeTradeNameString = @"消费用户";

/**MessageSendTask 1 --> 执行中 ...*/
extern NSString *getMessageSendTaskStatusTitleWithStatus(MessageSendRecordStatus status);
/**MessageSendTask birthday --> 生日祝福 ...*/
extern NSString *getMessageSendTaskSMSTypeTitleWithSMSType(NSString *SMSType);
/**MessageSendTask direct --> 直推用户 ...*/
extern NSString *getMessageSendTargetTypeTitleWithSMSType(NSString *sendTargetType);

@interface MessageSendRecordModel : NSObject

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *delFlag;
@property (nonatomic, strong) NSString *preDays;
@property (nonatomic, strong) NSString *executeTime;
@property (nonatomic, strong) NSString *updateTime;
@property (nonatomic, strong) NSString *executeType;
@property (nonatomic, strong) NSString *taskId;

@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *sendContent;
@property (nonatomic, strong) NSString *sendHead;
@property (nonatomic, strong) NSString *sendTarge;
@property (nonatomic, strong) NSString *sendTargeType;
@property (nonatomic, strong) NSString *sendTemplateId;

@property (nonatomic, strong) NSString *sendTimes;
@property (nonatomic, strong) NSString *smsType;
@property (nonatomic, assign) MessageSendRecordStatus taskStatus;
@property (nonatomic, strong) NSString *taskType;
@property (nonatomic, strong) NSString *usrNo;

@property (nonatomic, strong, readonly) NSString *tagName;

@property (nonatomic, strong, readonly) MessageSendRecordModel *modelCopy;
@end

NS_ASSUME_NONNULL_END
