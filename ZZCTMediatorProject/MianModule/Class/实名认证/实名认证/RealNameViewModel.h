//
//  RealNameViewModel.h
//  ZhouZhuanFu
//
//  Created by zenglizhi on 2019/1/22.
//  Copyright © 2019 徐迪华. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class LZAddressCenter;
@interface RealNameViewModel : NSObject

/**
 活体检测
 */
@property (nonatomic, strong) UIImage *livingImage;

/**
 身份证正面
 */
@property (nonatomic, strong) UIImage *cardFrontImage;

/**
 身份证反面
 */
@property (nonatomic, strong) UIImage *cardBackImage;

/**
 个人照片
 */
@property (nonatomic, strong) UIImage *personImage;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *IDCardNumber;
@property (nonatomic, strong) NSString *bankCardNumber;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *bankName;


- (void)submitStep1:(SimpleBoolBlock)block;
@end

NS_ASSUME_NONNULL_END
