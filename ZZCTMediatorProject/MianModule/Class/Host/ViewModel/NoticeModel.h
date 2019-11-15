//
//  NoticeModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/9/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NoticeModel : NSObject

@property (nonatomic, strong) NSString *createdTime;
@property (nonatomic, strong) NSString *nid;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *noticeType;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *isClick;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *delFlag;
@end

NS_ASSUME_NONNULL_END
