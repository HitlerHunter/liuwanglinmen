//
//  MineOrderModel.m
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/25.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "MineOrderModel.h"

@implementation MineOrderModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id":@"id"};
}

- (NSString *)goodsSpecs{
    if (IsNull(_goodsSpecs)) {
        return @"";
    }
    return _goodsSpecs;
}
@end

NSString *getOrdStatusTitleWithStatus(MineOrderStatus status){
    if (status == MineOrderStatusCancel) {
        return @"订单超时，已取消";
    }else if (status == MineOrderStatusWaitingPay) {
        return @"待付款";
    }else if (status == MineOrderStatusWaitingSend) {
        return @"买家已付款";
    }else if (status == MineOrderStatusWaitingTake) {
        return @"卖家已发货";
    }
    return @"";
}
