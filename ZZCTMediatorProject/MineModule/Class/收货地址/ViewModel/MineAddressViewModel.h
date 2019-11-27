//
//  MineAddressViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/19.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class MineAddressModel;
@interface MineAddressViewModel : NSObject

+ (void)removeAddressWithModel:(MineAddressModel *)model
                         block:(SimpleBoolBlock)block;
+ (void)addAddressWithModel:(MineAddressModel *)model
                      block:(SimpleBoolBlock)block;
+ (void)editAddressWithModel:(MineAddressModel *)model
                       block:(SimpleBoolBlock)block;
+ (void)getAddressListWithBlock:(SimpleObjBlock)block;
+ (void)getDefaultAddressWithBlock:(SimpleObjBlock)block;
@end

NS_ASSUME_NONNULL_END
