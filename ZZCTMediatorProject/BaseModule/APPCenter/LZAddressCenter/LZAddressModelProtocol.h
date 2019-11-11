//
//  LZAddressModelProtocol.h
//  ZZCTMediatorProject
//
//  Created by zenglizhi on 2019/11/2.
//  Copyright © 2019 zenglizhi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LZAddressModelProtocol <NSObject>

@required
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *code;


@end

NS_ASSUME_NONNULL_END
