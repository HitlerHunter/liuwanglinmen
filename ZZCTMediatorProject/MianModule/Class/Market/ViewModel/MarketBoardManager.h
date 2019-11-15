//
//  MarketBoardManager.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/25.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarketBoardCellModel.h"
NS_ASSUME_NONNULL_BEGIN

static NSString *const MarketPlanTypeWakeUpString = @"rouse";
static NSString *const MarketPlanTypeBirthdayString = @"birth";
static NSString *const MarketPlanTypeCustomString = @"custom";

static NSString *const MarketPlanTypeWakeUpTitle = @"会员唤醒";
static NSString *const MarketPlanTypeBirthdayTitle = @"生日祝福";
static NSString *const MarketPlanTypeCustomTitle = @"短信群发";

extern NSString *getMarketBoardTypeTitleWithTypeStr(NSString *typeStr);
extern NSString *getMarketBoardTypeStrWithTypeTitle(NSString *title);

@interface MarketBoardManager : NSObject
/**公共模板*/
@property (nonatomic, strong) NSMutableArray <MarketBoardCellModel *> *publicBoardArray;
/**自定义模板*/
@property (nonatomic, strong) NSMutableArray <MarketBoardCellModel *> *mineBoardArray;

@property (nonatomic, assign) NSInteger changed;

+ (MarketBoardManager *)shareInstance;

- (void)refreshData;
/**添加模板*/
- (void)addBoard:(MarketBoardCellModel *)board returnBlock:(void (^)(BOOL isSuccess))returnBlock;
/**删除模板*/
- (void)removeBoard:(MarketBoardCellModel *)board;
/**编辑模板*/
- (void)editBoard:(MarketBoardCellModel *)board returnBlock:(void (^)(BOOL isSuccess))returnBlock;

/**筛选type*/
- (NSMutableArray *)getMineBoardArrayWithType:(NSString *)type;
/**筛选type 审核通过的*/
- (NSMutableArray *)getMineBoardArrayWithOutUnpassByType:(NSString *)type;
- (NSMutableArray *)getPublicBoardArrayWithType:(NSString *)type;
@end

NS_ASSUME_NONNULL_END
