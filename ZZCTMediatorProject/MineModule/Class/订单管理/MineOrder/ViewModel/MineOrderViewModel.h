//
//  MineOrderViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/12/25.
//  Copyright © 2018 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MineOrderViewModel : BaseRefreshViewModel
/** 订单状态 订单状态:待付款1；待发货2；已发货3
 */
@property (nonatomic, strong) NSString *orderStatus;

+ (void)cancelOrderWithOrderId:(NSString *)orderId block:(SimpleBoolBlock)block;
/**确认收货*/
+ (void)sureOrderHasGetGoodsWithOrderId:(NSString *)orderId block:(SimpleBoolBlock)block;

/**提交订单
receiveAddrId 地址
 productIds 产品id
 */
+ (void)submitOrderWithReceiveAddrId:(NSString *)receiveAddrId
                          productIds:(NSArray <NSDictionary *> *)productIds
                         agentUserNo:(NSString *)agentUserNo
                               Block:(SimpleObjBoolBlock)block;

+ (void)submitOrderWithResource:(NSString *)resource
                  receiveAddrId:(NSString *)receiveAddrId
                shoppingCartIds:(NSArray <NSString *> *)shoppingCartIds
                          Block:(SimpleObjBoolBlock)block;

+ (void)getOrderDetailWithOrderId:(NSString *)orderId block:(SimpleObjBlock)block;

+ (void)sureHasPayWithOrderId:(NSString *)orderId block:(SimpleObjBlock)block;
@end

NS_ASSUME_NONNULL_END
