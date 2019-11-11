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
    /**执行失败*/
    MessageSendRecordStatusSendFailue = 3,
    /**执行终止*/
    MessageSendRecordStatusSendPause = 4,
};

static NSString *const MessageSendTaskTypeWakeUpString = @"rouse";
static NSString *const MessageSendTaskTypeBirthdayString = @"birthday";
static NSString *const MessageSendTaskTypeCustomString = @"custom";

/**MessageSendTask 1 --> 执行中 ...*/
extern NSString *getMessageSendTaskStatusTitleWithStatus(MessageSendRecordStatus status);
/**MessageSendTask birthday --> 生日祝福 ...*/
extern NSString *getMessageSendTaskSMSTypeTitleWithSMSType(NSString *SMSType);

@interface MessageSendRecordModel : NSObject

@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *delFlag;
@property (nonatomic, strong) NSString *delayDay;
@property (nonatomic, strong) NSString *executeTime;
@property (nonatomic, strong) NSString *executeType;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *perdayTime;
@property (nonatomic, strong) NSString *reason;
@property (nonatomic, strong) NSString *remark;

@property (nonatomic, strong) NSString *sendContent;
@property (nonatomic, strong) NSString *sendHead;
@property (nonatomic, strong) NSString *sendTarge;
@property (nonatomic, strong) NSString *sendTargeType;
@property (nonatomic, strong) NSString *sendTemplateId;

@property (nonatomic, strong) NSString *tagName;
@property (nonatomic, strong) NSString *sendTimes;
@property (nonatomic, strong) NSString *smsType;
@property (nonatomic, assign) MessageSendRecordStatus taskStatus;
@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *sendSuccessCount;
@property (nonatomic, strong) NSString *sendFailureCount;

@property (nonatomic, strong, readonly) MessageSendRecordModel *modelCopy;
@end

NS_ASSUME_NONNULL_END
