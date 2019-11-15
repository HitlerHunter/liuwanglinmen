//
//  AppMessage.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/1/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NoticeModel.h"
#import "NoticeModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppMessage : NSObject

@property (nonatomic, strong) NSMutableArray <NoticeModel *> *messageArray;

@property (nonatomic, strong, null_resettable) NSDictionary *noticeParams;

/**
 用于监听，刷新UI
 */
@property (nonatomic, assign) BOOL needRefreshUI;

+ (AppMessage *)shareInstance;

- (void)addNewMessageWithDic:(NSDictionary *)dic;

/**首页弹窗*/
+ (void)getHomePresentNoticeWithBlock:(void(^)(NoticeModel *message))block;
/**消息轮播*/
- (void)getNewNotice;

- (void)refreshUI;

- (NSMutableArray *)messageTitleArray;

#pragma mark - order
/**
 用于监听，刷新订单未读数量UI
 */
@property (nonatomic, assign) BOOL needRefreshOrderUI;


@end

NS_ASSUME_NONNULL_END
