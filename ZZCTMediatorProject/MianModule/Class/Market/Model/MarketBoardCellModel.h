//
//  MarketBoardCellModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, MarketBoardStatus) {
    /**审核通过*/
    MarketBoardStatusSuccess = 1,
    /**审核未通过*/
    MarketBoardStatusNoPass = 2,
    /**审核中*/
    MarketBoardStatusReviewing = 0,
};

typedef NS_ENUM(NSUInteger, MarketBoardCellType) {
    MarketBoardCellTypePublic,
    MarketBoardCellTypeShow,
    MarketBoardCellTypeSelect,
};

@class MarketBoardCellModel;
typedef void(^MarketBoardCellBlock)(MarketBoardCellModel *model);

@interface MarketBoardCellModel : NSObject

@property (nonatomic, strong) NSString *Id;

@property (nonatomic, strong) NSString *usrNo;
@property (nonatomic, strong) NSString *userName;

@property (nonatomic, strong) NSString *businessType;
@property (nonatomic, strong) NSString *templateHead;
@property (nonatomic, strong) NSString *templateContent;
@property (nonatomic, strong) NSString *auditReason;
@property (nonatomic, strong) NSString *delFlag;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) MarketBoardStatus status;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, assign) MarketBoardCellType cellType;

@property (nonatomic, strong) MarketBoardCellBlock block;

@property (nonatomic, strong, readonly) MarketBoardCellModel *modelCopy;
@end

NS_ASSUME_NONNULL_END
