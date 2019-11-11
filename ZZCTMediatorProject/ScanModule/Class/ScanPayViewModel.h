//
//  ScanPayViewModel.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2018/10/6.
//  Copyright © 2018年 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ScanPayViewModel : NSObject

+ (void)payWithCode:(NSString *)code
              money:(NSString *)money
             remark:(NSString *)remark
              block:(SimpleObjMsgBoolBlock)block;
@end

NS_ASSUME_NONNULL_END
