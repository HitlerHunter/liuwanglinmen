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

NSString *getMessageSendTaskStatusTitleWithStatus(MessageSendRecordStatus status){
    
    switch (status) {
        case MessageSendRecordStatusUnSend:
            return @"待发送";
            break;
        case MessageSendRecordStatusSending:
            return @"执行中";
            break;
        case MessageSendRecordStatusSendFailue:
            return @"发送失败";
            break;
        case MessageSendRecordStatusSendSuccess:
            return @"已完成";
            break;
        case MessageSendRecordStatusSendPause:
            return @"已终止";
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

- (MessageSendRecordModel *)modelCopy{
    MessageSendRecordModel *model = [MessageSendRecordModel new];
    model.taskStatus = self.taskStatus;
    model.userId = self.userId;
    model.Id = self.Id;
    return model;
}

@end
