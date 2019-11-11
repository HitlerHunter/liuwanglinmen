//
//  FormDataManagerModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/28.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FormDataManagerModel : NSObject

@property (nonatomic, assign) double alipayReceivableAmount;
@property (nonatomic, assign) NSInteger alipayReceivableNumber;

@property (nonatomic, assign) double receivableAmount;
@property (nonatomic, assign) NSInteger receivableNumber;

@property (nonatomic, assign) double refundAmount;
@property (nonatomic, assign) NSInteger refundNumber;
@property (nonatomic, assign) double totalIncome;

@property (nonatomic, assign) double wechatReceivableAmount;
@property (nonatomic, assign) NSInteger wechatReceivableNumber;
@end

NS_ASSUME_NONNULL_END
