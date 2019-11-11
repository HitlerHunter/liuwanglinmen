//
//  LoginViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/9/29.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewModel : NSObject

+ (void)loginWithPhone:(NSString *)phone pswd:(NSString *)pswd block:(void (^)(NSDictionary *data, NSError *error))block;

+ (void)registerWithParams:(NSDictionary *)params block:(void (^)(NSDictionary *data, NSError *error))block;
@end

NS_ASSUME_NONNULL_END
