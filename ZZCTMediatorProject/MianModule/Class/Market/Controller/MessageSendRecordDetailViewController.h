//
//  MessageSendRecordDetailViewController.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MessageSendRecordModel,MessageTaskViewModel;
@interface MessageSendRecordDetailViewController : SDBaseViewController

- (instancetype)initWithModel:(MessageSendRecordModel *)model viewModel:(MessageTaskViewModel *)viewModel;
@end

NS_ASSUME_NONNULL_END
