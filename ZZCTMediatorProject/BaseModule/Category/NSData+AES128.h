//
//  NSData+AES128.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/4/29.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES128)
-(NSData *) aes128_encrypt:(NSString *)key;
-(NSData *) aes128_decrypt:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
