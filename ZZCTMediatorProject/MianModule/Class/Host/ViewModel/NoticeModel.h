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

@property (nonatomic, strong) NSString *createDate;
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, strong) NSString *msgContent;
@property (nonatomic, strong) NSString *msgType;
@property (nonatomic, strong) NSString *shopNo;
@end

NS_ASSUME_NONNULL_END
