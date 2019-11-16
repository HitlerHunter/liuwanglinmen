//
//  MessageSendRecordModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "MessageSendRecordModel.h"

@implementation MessageSendRecordModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

- (NSString *)tagName{
    return getMessageSendTargetTypeTitleWithSMSType(self.sendTargeType);
}

NSString *getMessageSendTaskStatusTitleWithStatus(MessageSendRecordStatus status){
    
    switch (status) {
        case MessageSendRecordStatusUnSend:
            return @"待发送";
            break;
        case MessageSendRecordStatusSending:
            return @"执行中";
            break;
        case MessageSendRecordStatusSendFailue:
            return @"已终止";
            break;
        case MessageSendRecordStatusSendSuccess:
            return @"已完成";
            break;
            
        default:
            break;
    }
};

 NSString *getMessageSendTaskSMSTypeTitleWithSMSType(NSString *typeStr){
    if ([typeStr isEqualToString:MessageSendTaskTypeWakeUpString]) {
        return MarketPlanTypeWakeUpTitle;
    }else if ([typeStr isEqualToString:MessageSendTaskTypeBirthdayString]) {
        return MarketPlanTypeBirthdayTitle;
    }else if ([typeStr isEqualToString:MessageSendTaskTypeCustomString]) {
        return MarketPlanTypeCustomTitle;
    }
    
    return MarketPlanTypeCustomTitle;
};

NSString *getMessageSendTargetTypeTitleWithSMSType(NSString *sendTargetType){
    if ([sendTargetType isEqualToString:MessageSendTargetTypeDirectString]) {
        return MessageSendTargetTypeDirectNameString;
    }else if ([sendTargetType isEqualToString:MessageSendTargetTypeCouponString]) {
        return MessageSendTargetTypeCouponNameString;
    }else if ([sendTargetType isEqualToString:MessageSendTargetTypeTradeString]) {
        return MessageSendTargetTypeTradeNameString;
    }
    
    return MessageSendTargetTypeDirectNameString;
}

- (MessageSendRecordModel *)modelCopy{
    MessageSendRecordModel *model = [MessageSendRecordModel new];
    model.taskStatus = self.taskStatus;
    model.usrNo = self.usrNo;
    model.sendTemplateId = self.sendTemplateId;
    model.taskId = self.taskId;
    return model;
}

@end
