//
//  NoticeListViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "BaseRefreshViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NoticeListViewModel : BaseRefreshViewModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *rows;
@property (nonatomic, strong) NSString *showType;
@property (nonatomic, strong) NSString *userNo;

/**清空*/
+ (void)clearNoticeWithBlock:(void (^)(BOOL isSuccess))block;
/**删除*/
+ (void)removeNoticeWithNoticeId:(NSString *)noticeId
                           block:(void (^)(BOOL isSuccess))block;
@end

NS_ASSUME_NONNULL_END
