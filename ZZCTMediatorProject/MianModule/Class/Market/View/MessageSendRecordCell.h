//
//  MessageSendRecordCell.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MessageSendRecordModel,CouponSendRecordModel;
@interface MessageSendRecordCell : LZBaseTableViewCell

@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_status;
@property (nonatomic, strong) UILabel *label_count;
@property (nonatomic, strong) UILabel *label_date;
@property (nonatomic, strong) UILabel *label_type;

@property (nonatomic, strong) MessageSendRecordModel *model;
@property (nonatomic, strong) CouponSendRecordModel *couponSendRecordModel;

@end

NS_ASSUME_NONNULL_END
