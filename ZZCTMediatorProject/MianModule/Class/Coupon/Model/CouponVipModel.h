//
//  CouponVipModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class CouponVipSectionModel;
@interface CouponVipModel : NSObject

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *tagsName;
@property (nonatomic, strong) NSString *phone;

@property (nonatomic, weak) CouponVipSectionModel *section;

@property (nonatomic, assign) BOOL isSelected;

//代金券详情
/**核销时间*/
@property (nonatomic, strong) NSString *verifyTime;
/**领取时间时间*/
@property (nonatomic, strong) NSString *createTime;

@end

@interface CouponVipSectionModel : NSObject

@property (nonatomic, strong) NSString *tagsName;
@property (nonatomic, strong) NSArray *vipArray;

@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) BOOL isShow;
/**这组 已选中的数量*/
@property (nonatomic, assign, readonly) NSInteger didSelectCount;

/**检查这组是否都选中*/
- (void)checkSelect;
/**全选or全不选*/
- (void)selectAllOrNot:(BOOL)isSelected;
@end

NS_ASSUME_NONNULL_END
