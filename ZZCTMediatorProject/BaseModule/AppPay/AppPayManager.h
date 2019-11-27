//
//  AppPayManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/7.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WechatOpenSDK/WXApi.h>
NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, AppPayType) {
    AppPayTypeUplevel,
    AppPayTypeMarketMessage,
    AppPayTypeBoomGoodsPay,
};

typedef NS_ENUM(NSUInteger, AppPayStatus) {
    AppPayStatusSuccess,
    AppPayStatusFailue,
    AppPayStatusCancel,
};

@interface AppPayManager : NSObject <WXApiDelegate>
/**当前为哪个模块支付*/
@property (nonatomic, assign) AppPayType currentPayType;

+ (AppPayManager *)shareInstance;

- (void)WXPayWithDic:(NSDictionary *)dict;
@end

NS_ASSUME_NONNULL_END
