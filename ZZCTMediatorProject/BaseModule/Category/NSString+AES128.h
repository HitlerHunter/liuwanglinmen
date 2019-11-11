//
//  NSString+AES128.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>


#import "NSData+AES128.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES128)

-(NSString *) aes128_encrypt:(NSString *)key;
-(NSString *) aes128_decrypt:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
