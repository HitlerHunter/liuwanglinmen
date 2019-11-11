//
//  MarketMessageMoneyView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/6/26.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class MarketMessageMoneyView,MarketMessageMoneyModel;
@protocol MarketMessageMoneyViewDelegate <NSObject>

- (void)lz_view:(MarketMessageMoneyView *)selectView atIndex:(NSInteger)index model:(MarketMessageMoneyModel *)model;
- (void)lz_moneyViewClearChoice:(MarketMessageMoneyView *)selectView;
@end

@interface MarketMessageMoneyModel : NSObject

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *count;
@end

@interface MarketMessageMoneyCell : UIButton

@property (nonatomic, strong) UILabel *label_money;
@property (nonatomic, strong) UILabel *label_info;

@property (nonatomic, strong) MarketMessageMoneyModel *model;
@end

@interface MarketMessageMoneyView : SDBaseView

@property (nonatomic, strong) NSArray <MarketMessageMoneyModel *> *dataArray;

@property (nonatomic, weak) id <MarketMessageMoneyViewDelegate> delegate;
/**取消选中的cell*/
- (void)clearSelectedCell;
@end

NS_ASSUME_NONNULL_END
