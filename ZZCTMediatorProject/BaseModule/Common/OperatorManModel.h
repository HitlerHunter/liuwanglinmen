//
//  OperatorManModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/27.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OperatorManModel : NSObject

@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *merchantId;
@property (nonatomic, strong) NSString *merchantName;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *idCardCode;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *gendar;


@property (nonatomic, assign) BOOL status;

@property (nonatomic, assign) BOOL isSelected;
@end

NS_ASSUME_NONNULL_END
