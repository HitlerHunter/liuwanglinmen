//
//  GoodsModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GoodsModel : NSObject

@property (nonatomic, strong) NSString *goodsPrice;
@property (nonatomic, strong) NSString *goodsCode;
@property (nonatomic, strong) NSString *goodsName;
@property (nonatomic, strong) NSString *goodsCount;
@property (nonatomic, strong) NSString *goodsSpecs;
@property (nonatomic, strong) NSString *goodsType;
@property (nonatomic, strong) NSString *orderAmt;
@property (nonatomic, strong) NSString *topPic;
@property (nonatomic, strong) NSString *buttomPic;

@property (nonatomic, strong) NSString *logo;

@property (nonatomic, strong) NSArray *topArray;
@property (nonatomic, strong) NSArray *bottomArray;
@end

NS_ASSUME_NONNULL_END
