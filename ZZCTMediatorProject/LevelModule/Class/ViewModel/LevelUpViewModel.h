//
//  LevelUpViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/10/21.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LevelUpViewModel : NSObject

- (void)getLevelInfoConfigListWithLevel:(NSInteger)level
                                  block:(SimpleObjBlock)block;
+ (void)upLevelWithMoney:(NSString *)money
                   level:(NSString *)level
                   block:(SimpleObjBlock)block;
+ (void)upLevelWithMoney:(NSString *)money
                    area:(NSString *)area
                   level:(NSString *)level
                   phone:(NSString *)phone
                    name:(NSString *)name
                   block:(SimpleObjBlock)block;
@end

NS_ASSUME_NONNULL_END
