//
//  CouponDetailCellView.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/8/30.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import "SDBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CouponDetailCellModel : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *vaule;
@property (nonatomic, assign) NSTextAlignment textAlignment;
@end

@interface CouponDetailCell : SDBaseView
@property (nonatomic, strong) UILabel *label_title;
@property (nonatomic, strong) UILabel *label_vaule;
@property (nonatomic, strong) CouponDetailCellModel *model;

@end

@interface CouponDetailCellView : SDBaseView

@property (nonatomic, strong) NSArray <CouponDetailCellModel *> *dataArray;

@end


NS_ASSUME_NONNULL_END
