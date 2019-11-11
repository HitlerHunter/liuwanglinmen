//
//  HomeTodayDataView.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/3/8.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeTodayMoneyItemModel : NSObject

@property (nonatomic, strong) NSString *money;
@property (nonatomic, strong) NSString *title;

+ (HomeTodayMoneyItemModel *)modelWithMoney:(NSString *)money
                                      title:(NSString *)title;
@end

@interface HomeTodayMoneyModel : NSObject

@property (nonatomic, strong) NSArray <HomeTodayMoneyItemModel *>*dataArray;

@end

@interface HomeTodayMoneyView : SDBaseView

@property (nonatomic, strong) UILabel *moneyLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@interface HomeTodayCollectCell : UICollectionViewCell

@property (nonatomic, strong) HomeTodayMoneyView *moneyView;
@property (nonatomic, strong) HomeTodayMoneyView *moneyView2;

@end

@interface HomeTodayDataView : SDBaseView

@property (nonatomic, strong) NSArray <HomeTodayMoneyModel *>*dataArray;
@end

NS_ASSUME_NONNULL_END
