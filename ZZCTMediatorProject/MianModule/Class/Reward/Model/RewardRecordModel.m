//
//  RewardRecordModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "RewardRecordModel.h"

@implementation RewardRecordModel

NSString *getStatusTitleWithStatus(ChangeSalesStatus status){
    switch (status) {
        case ChangeSalesStatusSuccess:
            return @"审核通过";
            break;
        case ChangeSalesStatusReviewing:
            return @"审核中";
            break;
        case ChangeSalesStatusRefund:
            return @"审核不通过";
            break;
            
        default:
            break;
    }
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

/**
 0(未审核) 1(本地审核通过) 2(本地审核拒绝)
 3(待上游审核) 5(上游审核通过) 9(费率修改失败)
 */

- (void)setStatus:(NSString *)status{
    _status = status;
    
    NSInteger status_Int = status.integerValue;
    if (status_Int == 0 || status_Int == 1 || status_Int == 3) {
        _status_lz = ChangeSalesStatusReviewing;
    }else if (status_Int == 2) {
        _status_lz = ChangeSalesStatusRefund;
    }else if (status_Int == 5) {
        _status_lz = ChangeSalesStatusSuccess;
    }else if (status_Int == 9) {
        _status_lz = ChangeSalesStatusRefund;
    }
}

@end
