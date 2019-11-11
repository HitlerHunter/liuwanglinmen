//
//  MessageTaskViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/7/3.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@class MessageSendRecordModel;
@interface MessageTaskViewModel : BaseRefreshViewModel

@property (nonatomic, assign) BOOL isWaitingSend;

+ (void)editTask:(MessageSendRecordModel *)task returnBlock:(void (^)(BOOL isSuccess))returnBlock;
//通过id查询tag名称
+ (void)getTagNameWithId:(NSString *)tagId returnBlock:(void (^)(NSString *TagName))returnBlock;
@end

NS_ASSUME_NONNULL_END
